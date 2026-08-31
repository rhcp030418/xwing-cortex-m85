#!/usr/bin/env python3
"""Build a file-level research-data catalog and experiment lineage tables."""

from __future__ import annotations

from collections import Counter, defaultdict
import csv
from datetime import datetime
import hashlib
import json
from pathlib import Path
import re
import zipfile


PAPER_ROOT = Path(__file__).resolve().parent
TOPIC_ROOT = PAPER_ROOT.parent
CATALOG_PATH = PAPER_ROOT / "전체_데이터_카탈로그.tsv"
LINEAGE_PATH = PAPER_ROOT / "실험_계보_카탈로그.tsv"
DENOMINATOR_PATH = PAPER_ROOT / "분모_표준화_카탈로그.tsv"
EXCLUSIONS_PATH = PAPER_ROOT / "데이터_패키지_제외목록.tsv"
SUMMARY_PATH = PAPER_ROOT / "데이터_카탈로그_요약.json"
WORKBOOK_JSON_PATH = PAPER_ROOT / "데이터_카탈로그_워크북.json"
GENERATED_NAMES = {
    CATALOG_PATH.name,
    LINEAGE_PATH.name,
    DENOMINATOR_PATH.name,
    EXCLUSIONS_PATH.name,
    SUMMARY_PATH.name,
    WORKBOOK_JSON_PATH.name,
    "데이터_카탈로그.xlsx",
    "all-data-upload.zip",
    "전체_파일_SHA256.tsv",
}

CATALOG_COLUMNS = [
    "path",
    "archive_path",
    "bytes",
    "sha256",
    "modified_local",
    "extension",
    "top_area",
    "date",
    "experiment_ids",
    "role",
    "evidence_level",
    "data_stage",
    "lifecycle",
    "canonicality",
    "all_data_included",
    "artifact_included",
    "duplicate_group_size",
    "notes",
]

LINEAGE_COLUMNS = [
    "record_type",
    "id",
    "family",
    "first_date",
    "last_date",
    "file_count",
    "raw_log_count",
    "result_count",
    "prereg_count",
    "artifact_file_count",
    "source_count",
    "measurement_class",
    "current_status",
    "evidence_or_result",
    "canonical_reference",
    "notes",
]

DENOMINATOR_COLUMNS = [
    "row_kind",
    "source_item",
    "related_experiments",
    "data_family",
    "original_denominator",
    "standard_denominator_ids",
    "standard_denominator",
    "reference_cycles",
    "operation_scope",
    "conversion_status",
    "conversion_formula",
    "normalized_value_or_scope",
    "comparability_group",
    "allowed_comparison",
    "forbidden_comparison",
    "evidence",
    "notes",
]


def rel(path: Path) -> str:
    return path.relative_to(TOPIC_ROOT).as_posix()


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest().upper()


def write_tsv(path: Path, columns: list[str], rows: list[dict[str, object]]) -> None:
    with path.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, columns, delimiter="\t", lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def extract_date(path_text: str) -> str:
    match = re.search(r"(20\d{2})-(\d{2})-(\d{2})", path_text)
    if match:
        return match.group(0)
    match = re.search(r"(?:bak-|failed-)(20\d{2})(\d{2})(\d{2})", path_text)
    if match:
        return "-".join(match.groups())
    return ""


def filename_experiment_ids(path_text: str) -> tuple[list[str], list[str]]:
    ids: set[str] = set()
    notes: list[str] = []
    for component in Path(path_text).parts:
        matches = list(re.finditer(r"(?<![A-Za-z])exp([A-Z]{1,3}(?:\d+[A-Za-z]?)?)(?![A-Za-z])", component))
        for match in matches:
            value = match.group(1).upper()
            if value == "AU514":
                ids.add("AU")
                notes.append("expAU514 filename: 514 is SLOT_N, not a separate experiment")
            else:
                ids.add(value)
            tail = component[match.end() :]
            for token in re.findall(r"_([A-Z]{1,3}\d*[A-Za-z]?)(?=_|\.|-)", tail):
                normalized = token.upper()
                # expDE_A/expDE_B name deployment modes, not legacy experiments A/B.
                if value == "DE" and normalized in {"A", "B"}:
                    continue
                ids.add(normalized)

    lower = path_text.lower()
    name = Path(path_text).name
    lower_name = name.lower()
    legacy = re.search(r"(?:^|_)exp_?([a-z0-9]+)", lower_name)
    if legacy:
        token = legacy.group(1)
        legacy_map = {"bmid": "B", "bfull": "B", "f2": "F", "j": "J"}
        if token in legacy_map:
            ids.add(legacy_map[token])
        elif token in {"a", "b", "c", "d", "e", "f", "l", "n", "p", "q", "t", "u", "w", "y", "ac", "ae", "cs", "dc"}:
            ids.add(token.upper())
    if "expak" in lower and ("results" in lower or "/logs/" in lower or "/artifacts/" in lower):
        ids.update(("AK1", "AK2"))
    if "expz" in lower:
        ids.update(("Z1", "Z2"))
    if name == "mve_keccak.py":
        ids.update(("G2", "O"))
    if "expam_x25519_mve_design" in lower:
        ids.add("AM0")
        ids.discard("AM")
    if "expbo" in lower:
        ids.add("BO")
        notes.append("BO execution/source exists; standalone RAM result dump is not preserved")
    if "expcg" in lower and ("results" in lower or "harvest" in lower):
        ids.update(("CH", "CI"))
    return sorted(ids), notes


def artifact_membership() -> dict[str, str]:
    archive_path = PAPER_ROOT / "artifact-upload.zip"
    if not archive_path.is_file():
        return {}
    members: dict[str, str] = {}
    with zipfile.ZipFile(archive_path) as archive:
        for info in archive.infolist():
            if info.is_dir():
                continue
            digest = hashlib.sha256(archive.read(info)).hexdigest().upper()
            members[info.filename] = digest
    return members


def is_artifact_included(path_text: str, digest: str, members: dict[str, str]) -> bool:
    candidates = [path_text]
    if path_text == "논문_데이터_표.md":
        candidates.append("paper/논문_데이터_표.md")
    if path_text == "분모_정의_통일.md":
        candidates.append("paper/분모_정의_통일.md")
    if path_text == "paper/ARTIFACT_README.md":
        candidates.append("README.md")
    return any(members.get(candidate) == digest for candidate in candidates)


def classify(path_text: str) -> dict[str, str]:
    path = Path(path_text)
    parts = path.parts
    top = parts[0] if len(parts) > 1 else "[root]"
    name = path.name
    lower = path_text.lower()
    suffix = path.suffix.lower() or "[none]"
    backup = top == "_보관" or ".bak-" in name.lower() or ".failed-" in lower
    git_internal = ".git" in parts or name == ".git"
    cache = "__pycache__" in parts or suffix == ".pyc"
    legacy_overleaf = path_text.startswith("paper/A주제_overleaf/")

    if git_internal:
        role, evidence, stage, lifecycle, canonicality = (
            "vcs_metadata", "V-vcs", "metadata", "metadata", "metadata"
        )
    elif cache:
        role, evidence, stage, lifecycle, canonicality = (
            "runtime_cache", "C-cache", "generated", "generated", "derived"
        )
    elif legacy_overleaf:
        role, evidence, stage, lifecycle, canonicality = (
            "history_backup", "E2/E3-historical", "history", "superseded", "snapshot"
        )
    elif backup:
        role, evidence, stage, lifecycle, canonicality = (
            "history_backup", "E2/E3-historical", "history", "historical", "backup"
        )
    elif top in {"pqmx-upstream", "pqmx-mve-ntts"}:
        role, evidence, stage, lifecycle, canonicality = (
            "vendor_dependency", "D-dependency", "dependency", "dependency", "third-party"
        )
    elif lower.startswith("measure-harness/logs/"):
        role, evidence, stage, lifecycle, canonicality = (
            "raw_board_log", "E1-direct", "raw", "current", "evidence"
        )
    elif lower.startswith("measure-harness/artifacts/"):
        role, evidence, stage, lifecycle, canonicality = (
            "frozen_experiment_artifact", "E2-frozen", "frozen", "frozen", "snapshot"
        )
    elif lower.startswith("measure-harness/") and name.endswith("_results.md"):
        role, evidence, stage, lifecycle, canonicality = (
            "experiment_result", "E2-result", "processed", "current", "evidence"
        )
    elif lower.startswith("measure-harness/") and name.endswith("_prereg.md"):
        role, evidence, stage, lifecycle, canonicality = (
            "preregistration", "E4-protocol", "protocol", "current", "support"
        )
    elif path_text == "논문_데이터_표.md":
        role, evidence, stage, lifecycle, canonicality = (
            "canonical_numeric_ledger", "E4-ledger", "summary", "current", "canonical"
        )
    elif name in {"데이터_누적_검증대장.md", "데이터_계보_아티팩트_정합성.md"}:
        role, evidence, stage, lifecycle, canonicality = (
            "canonical_lineage_ledger", "E4-ledger", "summary", "current", "canonical"
        )
    elif name in {"전체_파일_SHA256.tsv", "verify_all_files.py", "verify_data_ledger.ps1", "build_data_catalog.py", "package_all_data.py"}:
        role, evidence, stage, lifecycle, canonicality = (
            "catalog_or_audit_tool", "M-metadata", "metadata", "current", "metadata"
        )
    elif lower.startswith("paper/ko/") and suffix == ".tex":
        role, evidence, stage, lifecycle, canonicality = (
            "manuscript_source", "E5-publication", "publication", "current", "canonical"
        )
    elif lower.startswith("paper/") and suffix in {".pdf", ".zip", ".aux", ".bbl", ".blg", ".bcf", ".out", ".log"}:
        role, evidence, stage, lifecycle, canonicality = (
            "publication_derivative", "E5-publication", "publication", "generated", "derived"
        )
    elif lower.startswith("paper/"):
        role, evidence, stage, lifecycle, canonicality = (
            "paper_support", "E5/E4", "publication", "current", "support"
        )
    elif top == "papers":
        role, evidence, stage, lifecycle, canonicality = (
            "literature_reference", "D-reference", "reference", "dependency", "third-party"
        )
    elif top == "slothy-2stream":
        role, evidence, stage, lifecycle, canonicality = (
            "solver_source_or_output", "E3-host/static", "source", "current", "evidence"
        )
    elif top == "artifact":
        role, evidence, stage, lifecycle, canonicality = (
            "legacy_reproduction_artifact", "E2/E3", "frozen", "frozen", "snapshot"
        )
    elif lower.startswith("measure-harness/") and suffix in {".elf", ".srec", ".map", ".o"}:
        role, evidence, stage, lifecycle, canonicality = (
            "build_image", "E1/E2-build", "frozen", "current", "evidence"
        )
    elif suffix in {".c", ".h", ".s", ".inc", ".py", ".ps1", ".ld", ".mk", ".sh", ".bat"}:
        role, evidence, stage, lifecycle, canonicality = (
            "source_or_tool", "E3-source/static", "source", "current", "support"
        )
    elif suffix in {".elf", ".srec", ".map", ".o"}:
        role, evidence, stage, lifecycle, canonicality = (
            "build_image", "E1/E2-build", "frozen", "current", "evidence"
        )
    elif suffix in {".md", ".txt", ".json", ".tsv", ".csv"}:
        role, evidence, stage, lifecycle, canonicality = (
            "research_document_or_data", "E3/E4", "summary", "current", "support"
        )
    else:
        role, evidence, stage, lifecycle, canonicality = (
            "other_research_file", "E3/E4", "support", "current", "support"
        )

    included = not git_internal and not cache
    return {
        "extension": suffix,
        "top_area": top,
        "role": role,
        "evidence_level": evidence,
        "data_stage": stage,
        "lifecycle": lifecycle,
        "canonicality": canonicality,
        "all_data_included": "Y" if included else "N",
    }


def parse_candidate_rows(ledger_text: str) -> dict[str, tuple[str, str]]:
    rows: dict[str, tuple[str, str]] = {}
    in_candidates = False
    for line in ledger_text.splitlines():
        if line.startswith("### 2.2 "):
            in_candidates = True
            continue
        if in_candidates and line.startswith("## 3."):
            break
        if not in_candidates:
            continue
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if len(cells) >= 3 and re.fullmatch(r"[KXWT]\d{2}", cells[0]):
            rows[cells[0]] = (cells[1], cells[2])
    return rows


def parse_experiment_status(ledger_text: str, known_ids: set[str]) -> dict[str, tuple[str, str]]:
    rows: dict[str, tuple[str, str]] = {}
    in_chronology = False
    for line in ledger_text.splitlines():
        if line.startswith("## 3."):
            in_chronology = True
            continue
        if line.startswith("## 4."):
            break
        if not in_chronology or not line.startswith("|"):
            continue
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if len(cells) < 3 or cells[0] in {"순서", "날짜·순서", "---:", "---"}:
            continue
        label = cells[1]
        tokens = set(re.findall(r"(?<![A-Z0-9])([A-Z]{1,3}\d*[A-Za-z]?)(?![A-Z0-9])", label))
        if label.startswith("실험 "):
            tokens.update(re.findall(r"실험 ([A-Z])\b", label))
        selected = {token.upper() for token in tokens if token.upper() in known_ids}
        result = " | ".join(cells[2:-1]) if len(cells) > 3 else cells[2]
        status = cells[-1]
        for token in selected:
            rows[token] = (status, result)
    return rows


def measurement_class(status: str, evidence: str) -> str:
    text = f"{status} {evidence}"
    if "미측정" in text:
        return "미측정/부분 미측정"
    if any(word in text for word in ("실보드", "실측", "보드")):
        return "실보드/직접 측정"
    if any(word in text for word in ("호스트", "정적", "상한", "방법론")):
        return "호스트·정적·파생"
    if any(word in text for word in ("실패", "종료", "기각")):
        return "종료/실패 판정"
    return "대장 참조"


def canonical_reference(rows: list[dict[str, object]]) -> str:
    paths = [str(row["path"]) for row in rows]
    priorities = [
        lambda value: value.startswith("measure-harness/") and value.endswith("_results.md") and "/artifacts/" not in value,
        lambda value: value.startswith("measure-harness/") and value.endswith("_prereg.md") and "/artifacts/" not in value,
        lambda value: value.startswith("measure-harness/logs/"),
        lambda value: value.startswith("slothy-2stream/") and value.endswith(".log"),
        lambda value: value.startswith("slothy-2stream/"),
        lambda value: not value.startswith("_보관/"),
        lambda value: True,
    ]
    for predicate in priorities:
        candidates = sorted(value for value in paths if predicate(value))
        if candidates:
            return candidates[0]
    return ""


def build_lineage(
    catalog_rows: list[dict[str, object]], ledger_text: str
) -> list[dict[str, object]]:
    by_id: defaultdict[str, list[dict[str, object]]] = defaultdict(list)
    for row in catalog_rows:
        for experiment_id in str(row["experiment_ids"]).split(";"):
            if experiment_id:
                by_id[experiment_id].append(row)

    internal_ids = {
        *list("ABCDEFGHIJKLMNOPQRSTUVWXYZ"),
        "K1", "K2", "K3", "K4", "G2", "M4", "N2",
        "AK1", "AK2", "AM0", "CH", "CI", "Z1", "Z2", "BO",
    }
    known_ids = set(by_id) | internal_ids
    experiment_status = parse_experiment_status(ledger_text, known_ids)
    candidate_rows = parse_candidate_rows(ledger_text)
    output: list[dict[str, object]] = []
    legacy_dates = {
        **{value: ("2026-08-16", "2026-08-16") for value in ("A", "B", "C", "D", "K1", "K2", "K3", "K4")},
        **{value: ("2026-08-17", "2026-08-20") for value in ("E", "F", "G", "H", "I", "J", "K", "L", "M", "M4", "N", "N2")},
        "G2": ("2026-08-20", "2026-08-20"),
        "O": ("2026-08-20", "2026-08-20"),
    }

    for experiment_id in sorted(known_ids, key=lambda value: (len(value), value)):
        rows = by_id.get(experiment_id, [])
        dates = sorted({str(row["date"]) for row in rows if row["date"]})
        status, evidence = experiment_status.get(
            experiment_id,
            ("누적 대장에 식별자 존재; 개별 행 참조", "자동 상태 추출이 모호해 추정하지 않음"),
        )
        role_counts = Counter(str(row["role"]) for row in rows)
        notes = []
        if experiment_id == "BO":
            notes.append("RAM rep_cyc/EXPBO_JSON 미보존; 수치 인용 금지")
            measured = "보존 불완전/수치 인용 금지"
        else:
            measured = measurement_class(status, evidence)
        if experiment_id == "AU":
            notes.append("expAU514의 514는 SLOT_N")
        output.append(
            {
                "record_type": "experiment",
                "id": experiment_id,
                "family": experiment_id[0],
                "first_date": legacy_dates.get(experiment_id, (dates[0] if dates else "", ""))[0],
                "last_date": legacy_dates.get(experiment_id, ("", dates[-1] if dates else ""))[1],
                "file_count": len(rows),
                "raw_log_count": role_counts["raw_board_log"],
                "result_count": role_counts["experiment_result"],
                "prereg_count": role_counts["preregistration"],
                "artifact_file_count": role_counts["frozen_experiment_artifact"],
                "source_count": sum(
                    count for role, count in role_counts.items()
                    if role in {"source_or_tool", "solver_source_or_output", "catalog_or_audit_tool"}
                ),
                "measurement_class": measured,
                "current_status": status,
                "evidence_or_result": evidence,
                "canonical_reference": canonical_reference(rows),
                "notes": "; ".join(notes),
            }
        )

    for candidate_id in sorted(candidate_rows, key=lambda value: (value[0], int(value[1:]))):
        status, evidence = candidate_rows[candidate_id]
        output.append(
            {
                "record_type": "candidate",
                "id": candidate_id,
                "family": candidate_id[0],
                "first_date": "",
                "last_date": "",
                "file_count": 0,
                "raw_log_count": 0,
                "result_count": 0,
                "prereg_count": 0,
                "artifact_file_count": 0,
                "source_count": 0,
                "measurement_class": measurement_class(status, evidence),
                "current_status": status,
                "evidence_or_result": evidence,
                "canonical_reference": "paper/데이터_누적_검증대장.md §2.2",
                "notes": "후보 ID; 독립 실험 파일이 없어도 계보에 포함",
            }
        )
    return output


def build_denominator_catalog() -> list[dict[str, object]]:
    """Return the denominator registry and one explicit mapping for every T item.

    Normalization never rescales cycles across a draft, ELF, cache state, or
    operation.  Fixed denominators are used only for the two named end-to-end
    cohorts; paired denominators remain bound to the exact baseline cell.
    """
    standards = [
        ("D24-KG", "X-Wing 2024/039 keygen 1회 전체", 794198, "keygen", "E2E-2024-KG"),
        ("D24-ENC", "X-Wing 2024/039 encaps 1회 전체", 1175479, "encaps", "E2E-2024-ENC"),
        ("D24-DEC", "X-Wing 2024/039 decaps 1회 전체", 868772, "decaps", "E2E-2024-DEC"),
        ("D10-KG", "X-Wing draft-10 keygen 1회 전체", 627069, "keygen", "E2E-D10-KG"),
        ("D10-ENC", "X-Wing draft-10 encaps 1회 전체", 988456, "encaps", "E2E-D10-ENC"),
        ("D10-DEC-W", "X-Wing draft-10 decaps warm 1회 전체", 780020, "decaps warm", "E2E-D10-DEC-W"),
        ("D10-DEC-C", "X-Wing draft-10 decaps cold 1회 전체", 1406887, "decaps cold", "E2E-D10-DEC-C"),
        ("D-PAIR-A", "같은 ELF·같은 연산의 A 기준 셀", "", "연산별; warm/cold 분리", "PAIR-A/{ELF}/{operation}/{cache}"),
        ("D-ATTR-AB", "같은 run·연산의 전체 A−B 감소 cycle", "", "축별 기여 비중; warm/cold 분리", "ATTR-AB/{run}/{operation}/{cache}"),
        ("D-PAIR-F", "같은 재플래시·순서쌍의 F 기준 셀", "", "연산별 F/U", "PAIR-F/{reflash}/{operation}"),
        ("D-PAIR-S", "같은 ELF·같은 연산의 S 또는 S' 기준 셀", "", "연산별 S/U'", "PAIR-S/{ELF}/{operation}"),
        ("D-PAIR-INST-A", "같은 DWT-off ELF·같은 연산의 A 퇴직 명령 수", "", "연산별 PMU instruction A/B", "PAIR-INST-A/{ELF}/{operation}/{cache}"),
        ("D-RESOURCE-A", "같은 BSP·빌드 manifest의 A 자원 바이트", "", "비휘발·정적 RAM; 자원 종류 분리", "RESOURCE-A/{build-manifest}/{metric}"),
        ("D-SEQ", "같은 입력·빌드의 순차 기준 커널", "", "커널/스케줄 1회", "LOCAL-SEQ/{build}/{kernel}"),
        ("D-MIN", "min(cyc_A, cyc_B)", "", "두 스트림의 겹침 구간", "LOCAL-HIDE/{build}/{pair}"),
        ("D-ISSUE", "2 × 측정 cycle의 발행 슬롯", "", "동일 커널 발행 슬롯", "LOCAL-ISSUE/{build}/{kernel}"),
        ("D-CALL", "명시된 함수·커널 1회 호출", "", "cyc/call", "LOCAL-CALL/{build}/{symbol}"),
        ("D-INST", "명시된 동적 명령 1개", "", "cyc/instruction", "LOCAL-INST/{build}/{instruction}"),
        ("D-BATCH", "명시된 크기의 완전한 배치 1회", "", "cyc/batch; batch size 필수", "LOCAL-BATCH/{build}/{size}"),
        ("D-SAMPLE", "독립 표본·seed·boot 1개", "", "통계 표본 단위", "SAMPLE/{protocol}/{class}"),
        ("D-NOPERF", "성능 분모 없음", "", "정확성·정정·철회", "NO-PERFORMANCE-DENOMINATOR"),
    ]
    rows: list[dict[str, object]] = []
    for identifier, definition, cycles, scope, group in standards:
        rows.append(
            {
                "row_kind": "standard",
                "source_item": "",
                "related_experiments": "",
                "data_family": "표준 분모 레지스트리",
                "original_denominator": "",
                "standard_denominator_ids": identifier,
                "standard_denominator": definition,
                "reference_cycles": cycles,
                "operation_scope": scope,
                "conversion_status": "definition",
                "conversion_formula": "",
                "normalized_value_or_scope": "",
                "comparability_group": group,
                "allowed_comparison": "동일 comparability_group의 동일 연산·빌드·cache 상태",
                "forbidden_comparison": "draft·ELF·연산·warm/cold를 넘는 직접 비율 비교",
                "evidence": "분모_정의_통일.md §7; 논문_데이터_표.md 분모 규칙",
                "notes": "고정 cycle이 빈 분모는 각 paired/local 셀의 실측값을 사용",
            }
        )

    mappings = [
        ("T1", "K1~K4", "게이트 상한·발행 슬롯", "전체 X-Wing cycle; 2×cyc", "D24-KG;D24-ENC;D24-DEC;D-ISSUE", "derived", "100×overlap/D24; idle/(2×cyc)", "26.4/21.3/24.2% of D24; 슬롯 낭비는 로컬", "E2E-2024/{operation}; LOCAL-ISSUE", "T1↔T3의 같은 연산", "D10·warm/cold·다른 연산과 교차"),
        ("T2", "A~F;AG", "스케줄러 비교", "해당 행의 순차 스케줄", "D-SEQ", "local_only", "100×(candidate-seq)/seq", "cyc/schedule; 같은 행 순차 대비 %", "LOCAL-SEQ/{generation}/{kernel}", "같은 입력·같은 세대의 순차/지퍼/solver", "08-16 역사값과 AG 현행값의 직접 합산"),
        ("T3", "M;M4;K", "초기 E2E 투영·유닛 진단", "구 매크로 유닛 합; 현행 D24", "D24-KG;D24-ENC;D24-DEC;D-CALL", "derived", "100×절감cycle/D24", "7.7/5.5/7.2% of D24; 회수율 29/26/30%", "E2E-2024/{operation}; LOCAL-CALL", "T1 상한과 같은 D24", "유닛 내부 %를 E2E %로 표기"),
        ("T4", "E;I;J;L", "회수 얇음 원인", "순차; min(A,B); 곱 1회", "D-SEQ;D-MIN;D-CALL", "local_only", "지표별 표준식", "커널별 cyc/call·은닉률·A-세금", "LOCAL/{build}/{metric}", "같은 빌드·같은 커널 지표", "종단간 D24/D10와 나란히 합산"),
        ("T5", "N;N2;Q", "페어링 스펙트럼", "min(A,B) 또는 해당 순차", "D-MIN;D-SEQ", "local_only", "hidden/min(A,B); 100×(candidate-seq)/seq", "페어/파이프별 로컬 은닉률", "LOCAL-HIDE/{build}/{pair}", "같은 build의 pairing", "다른 파이프/빌드의 절대 cycle 합산"),
        ("T6", "T", "no-yield+b0", "같은 커널 순차", "D-SEQ", "local_only", "100×(candidate-seq)/seq", "커널 A/B별 로컬 변화", "LOCAL-SEQ/T/{kernel}", "T 내부 A/B", "E2E 대표값으로 승격"),
        ("T7", "U", "yield1+b1", "로컬 순차 및 2024 E2E 투영", "D-SEQ;D24-KG;D24-ENC;D24-DEC", "derived", "로컬은 seq; 투영은 절감cycle/D24", "역사 후보; AF가 직접 E2E 대체", "LOCAL-SEQ/U; E2E-2024/{operation}", "투영끼리만", "직접 실측과 투영을 같은 증거등급으로 취급"),
        ("T8", "V;W", "NTT standalone", "NTT/invNTT 1회 호출", "D-CALL", "local_only", "cycle/call", "forward/inverse 각각 cyc/call", "LOCAL-CALL/{build}/{ntt-direction}", "동일 구현·방향", "full ML-KEM/X-Wing E2E %로 직접 환산"),
        ("T9", "X;Y", "ML-KEM 직접 통합", "같은 ELF의 A 기준 연산", "D-PAIR-A", "derived", "100×(A-B)/A", "연산별 paired effect", "PAIR-A/{ELF}/{operation}", "같은 X/Y A/B 셀", "다른 ELF의 T11 이후 값과 산술 합"),
        ("T10", "Z", "동시 보존·귀속", "같은 연산의 기준 셀", "D-PAIR-A", "derived", "100×bucket/A", "연산 내부 귀속 비중", "PAIR-A/Z/{operation}", "같은 Z attribution 합계", "attribution을 독립 E2E 효과로 중복 합산"),
        ("T11", "AA;AB", "초기 X-Wing E2E", "같은 ELF의 A 기준 연산", "D-PAIR-A", "derived", "100×(A-B)/A", "2.85/1.54/3.25% paired effect", "PAIR-A/AA-AB/{operation}", "동일 ELF의 연산별 A/B", "T14와 단순 합산"),
        ("T12", "AC;AD", "b0+x4 E2E 실패", "같은 ELF의 A 기준 연산", "D-PAIR-A", "derived", "100×(A-B)/A", "실패 효과와 원인 분해", "PAIR-A/AC/{operation}", "AC 내부 셀", "성공 대표값에 편입"),
        ("T13", "AE2;AF;AI", "U 직접 E2E 실패", "같은 ELF의 A 기준 연산", "D-PAIR-A", "derived", "100×(A-B)/A", "실패 paired effect", "PAIR-A/AF/{operation}", "같은 AF 셀", "현행 F/U 범위와 합치기"),
        ("T14", "AJ", "C9 v1 E2E", "같은 ELF의 A 기준 연산", "D-PAIR-A", "derived", "100×(A-B)/A", "1.46/2.67/4.66% paired effect", "PAIR-A/AJ/{operation}", "AJ 내부 A/B", "T11과 다른 ELF 간 산술 합"),
        ("T15", "AK1;AK2", "C9 v2·ITCM", "각 같은 ELF의 A 기준 연산", "D-PAIR-A", "derived", "100×(A-B)/A", "기각 paired effect", "PAIR-A/AK/{ELF}/{operation}", "동일 AK ELF 내부", "AK1/AK2 또는 타 실험을 무조건 같은 분모로 취급"),
        ("T16", "AL", "same-ELF 2×2", "같은 ELF cell-00", "D-PAIR-A", "derived", "100×(cell00-cellXY)/cell00", "4.29/4.16/7.71% 요인 분해", "PAIR-A/AL/{operation}", "AL 2×2 내부", "T20 절대 정본과 같은 baseline으로 간주"),
        ("T17", "AX;BC;BH;BN;BI", "채택 최적화", "각 실험의 같은 ELF A 셀", "D-PAIR-A", "derived", "100×(A-B)/A", "최적화별 paired effect; 세로 누적은 파생", "PAIR-A/{experiment}/{operation}", "각 행 내부 A/B", "서로 다른 ELF 행의 절대 cycle 직접 비교"),
        ("T18", "BA;BL;BV;BX", "M85 발행 규칙", "호출 또는 동적 명령 1개", "D-CALL;D-INST", "local_only", "cycles/call 또는 cycles/instruction", "단위별 로컬 단가", "LOCAL-INST/{instruction}", "같은 명령·의존 조건", "cyc/call과 cyc/instruction 혼합"),
        ("T19", "BJ", "메모리 배치", "함수 호출 또는 명시 배치", "D-CALL;D-BATCH", "local_only", "cycles/call 또는 cycles/batch", "배치 크기·배치 위치별 단가", "LOCAL-BATCH/BJ/{size}", "같은 batch size·배치", "batch size 없는 per-item 환산"),
        ("T20", "BU;BW", "draft-10 절대 cycle", "draft-10 연산 1회", "D10-KG;D10-ENC;D10-DEC-W;D10-DEC-C", "direct", "identity", "627069/988456/780020 warm/1406887 cold cyc/op", "E2E-D10/{operation}/{cache}", "동일 draft·연산·cache", "D24 또는 warm/cold 교차"),
        ("T21", "BV;BY", "스칼라×MVE·상한", "min(stream) 또는 연산 cycle", "D-MIN;D-CALL", "local_only", "hidden/min(A,B); bucket/operation", "100% 은닉은 로컬; NTT는 연산 상한", "LOCAL-HIDE; LOCAL-CALL", "같은 커널·연산", "100%를 E2E 100%로 해석"),
        ("T22", "BE;BF;BG;BK;BP;BQ;BS;BT;BX", "종료 가족 상한", "후보별 동일 기준 커널/연산", "D-SEQ;D-CALL;D-INST", "local_only", "후보별 표준 로컬 식", "각 후보 상한은 해당 로컬 분모", "LOCAL/{experiment}/{metric}", "같은 후보 내부", "가족 간 상한을 한 E2E 합으로 더하기"),
        ("T23", "BV;BQ;BI;BL", "과거 수치 정정", "성능 분모 없음", "D-NOPERF", "not_applicable", "none", "정정/교체 관계만 기록", "NO-PERFORMANCE-DENOMINATOR", "구값↔정정값 계보", "정정표 자체를 새 측정으로 인용"),
        ("T24", "CA;CB;CC;CD;CE", "합성 stitching", "커널 1회·명령 1개·min(stream)", "D-CALL;D-INST;D-MIN", "local_only", "cycles/call; cycles/instruction; hidden/min", "합성 커널 로컬 규칙", "LOCAL/T24/{metric}", "같은 lane·커널·명령수", "full X-Wing 실측으로 표기"),
        ("T25", "CG;CH;CI", "실물 X25519 guest", "호출·명령·순차 커널", "D-CALL;D-INST;D-SEQ", "local_only", "candidate/seq; cycles/instruction", "cyc/call 및 로컬 회귀율", "LOCAL/T25/{kernel}", "같은 플래시·커널", "T24 합성 누출계수의 무조건 적용"),
        ("T26", "CJ", "draft-10 누적 A/B", "같은 ELF A 기준 연산", "D-PAIR-A", "derived", "100×(A-B)/A", "25.967/20.249/11.224 warm/18.298 cold%", "PAIR-A/CJ/{operation}/{cache}", "CJ A/B 동일 cache", "T20 절대 cycle로 역산하거나 warm/cold 혼합"),
        ("T27", "CK;CL", "동적 명령·슬롯·F 상한", "명령·발행 슬롯·같은 F 셀", "D-INST;D-ISSUE;D-PAIR-F", "derived", "cycles/instruction; idle/(2×cyc); 100×(F-U)/F", "단위별 슬롯 회계", "PAIR-F/CK/{operation}; LOCAL-ISSUE", "같은 CK run/연산", "히스토그램만으로 순서 하한 복원"),
        ("T28", "CM", "공식 vector 정확성", "성능 분모 없음", "D-NOPERF", "not_applicable", "none", "공식 vector 전량 PASS", "NO-PERFORMANCE-DENOMINATOR", "byte-for-byte/KAT 결과", "정확성 PASS를 성능값으로 환산"),
        ("T28b", "CO", "in-context checkpoint", "같은 ELF 기준 셀 또는 단계 호출", "D-PAIR-S;D-CALL", "derived", "100×(S-U)/S; cycles/call", "연산별 checkpoint 효과", "PAIR-S/CO/{operation}; LOCAL-CALL", "CO 내부 동일 단계", "다른 checkpoint/ELF와 절대 비교"),
        ("T29", "CP", "파트너 범위 확장", "같은 ELF 기준 셀·순차", "D-PAIR-A;D-SEQ", "derived", "100×(A-B)/A", "35% 커버리지 후보 음성", "PAIR-A/CP/{operation}", "CP 내부", "실패 후보를 누적 이득에 포함"),
        ("T30", "CQ", "부팅 재현성", "독립 reset/boot 표본", "D-SAMPLE", "local_only", "range/CV across boots", "boot별 cycle 분포", "SAMPLE/CQ/{cell}/{boot}", "같은 cell의 boot 반복", "boot 표본을 같은 실행 반복으로 축소"),
        ("T31", "CL", "히스토그램 하한 철회", "성능 분모 없음", "D-NOPERF", "not_convertible", "none", "기존 하한 주장 폐기", "NO-PERFORMANCE-DENOMINATOR", "철회 사실만", "순서 없는 histogram에서 cycle 하한 재생성"),
        ("T32", "CR", "fe25519_mul y1", "fe25519_mul 1회 호출", "D-CALL", "local_only", "cycles/call", "r11 y1 micro cyc/call", "LOCAL-CALL/CR/fe25519_mul", "동일 구현·호출", "T43 E2E 효과로 자동 환산"),
        ("T33", "CS", "phase-0 solver", "같은 입력 순차 커널", "D-SEQ", "local_only", "100×(candidate-seq)/seq", "phase-0 로컬 음성", "LOCAL-SEQ/CS/phase0", "동일 phase·입력", "alias-safe 전체 solver 성능으로 확대"),
        ("T34", "CV;CZ", "주 F/U 7회", "각 재플래시의 같은 F 셀", "D-PAIR-F", "derived", "100×(F-U)/F", "14 effects/연산; paired F 분모", "PAIR-F/{reflash}/{operation}", "각 F/U 쌍과 연산별 effects", "F/U 절대 셀 28개를 28 effects라 부르기"),
        ("T35", "CU", "leave-one-out", "같은 ELF A 기준 연산; 같은 run의 A−B 감소", "D-PAIR-A;D-ATTR-AB", "derived", "100×(A-B)/A; 100×(B−i−B)/(A−B)", "6-run 축별 기여·잔차; x06 비중 46.11–67.61%", "PAIR-A/CU/{axis}/{operation}/{cache}; ATTR-AB/CU/{run}/{operation}/{cache}", "같은 run·연산의 CU 셀과 A−B", "다른 run/축의 extrema 조합"),
        ("T36", "CW", "8-seed decaps", "같은 ELF A 기준 seed별 decaps", "D-PAIR-A;D-SAMPLE", "derived", "100×(A_seed-B_seed)/A_seed", "12.97–13.02% warm; 18.58–18.62% cold", "PAIR-A/CW/{seed}/{cache}", "같은 seed·cache A/B", "warm/cold 또는 seed extrema 교차"),
        ("T37", "CX", "고정/무작위 timing", "독립 timing 표본", "D-SAMPLE", "local_only", "Welch t over protocol-defined samples", "run5/6 t-statistic", "SAMPLE/CX/{run}/{class}/{cache}", "동일한 버퍼·프로토콜 run5/6", "결함 run1~4와 정본 혼합"),
        ("T38", "CT", "CP-SAT seed 민감도", "host solver seed 1개", "D-SAMPLE", "local_only", "objective distribution across seeds", "seed별 host objective", "SAMPLE/CT/{seed}", "같은 모델·입력·worker 조건", "보드 cycle로 인용"),
        ("T39", "CY", "누적 동결 ELF 5-run", "같은 ELF A 기준 연산", "D-PAIR-A", "derived", "100×(A-B)/A", "25.96/20.25/11.22 warm/18.30 cold%", "PAIR-A/CY/{operation}/{cache}", "CY 동일 ELF·cache", "T20 절대 cycle과 baseline 혼동"),
        ("T40", "CZ", "현재 보드 F/U", "같은 재플래시 F 기준 연산", "D-PAIR-F", "derived", "100×(F-U)/F", "연산별 paired F/U effect", "PAIR-F/CZ/{reflash}/{operation}", "CZ 각 F/U 쌍", "다른 재플래시 extrema 교차"),
        ("T41", "DA", "33/43 후보", "같은 입력 순차 커널", "D-SEQ", "local_only", "100×(candidate-seq)/seq", "직접 후보 음성", "LOCAL-SEQ/DA/{kernel}", "DA 내부", "성공 누적값에 포함"),
        ("T42", "DB", "전 조각 solver", "정확성 실패로 성능 분모 없음", "D-NOPERF", "not_convertible", "none", "cycle 전량 무효", "NO-PERFORMANCE-DENOMINATOR", "정확성 실패 기록", "실패 cycle을 어떠한 성능 비교에도 사용"),
        ("T43", "DC", "Lenngren U' E2E", "같은 ELF S' 기준 연산", "D-PAIR-S", "derived", "100×(S'-U')/S'", "연산별 U' paired effect; 음성", "PAIR-S/DC/{operation}", "DC S'/U' 동일 연산", "T32 micro 효과를 별도 가산"),
        ("T44", "DD", "DWT-off PMU A/B", "같은 ELF A cycle 및 A 퇴직 명령", "D-PAIR-A;D-PAIR-INST-A", "derived", "100×(A-B)/A; 100×(A_inst-B_inst)/A_inst", "cycle 10.85–23.78%; instruction 9.23–27.08% 감소", "PAIR-A/DD/{operation}/{cache}; PAIR-INST-A/DD/{operation}/{cache}", "DD 내부 동일 연산·cache·PMU 구성", "DWT cycle과 합치기; stall 0으로 해석; 예비 no-wrap 로그 인용"),
        ("T45", "DE", "최소 배포 프록시·stack", "같은 BSP·빌드 manifest의 A 바이트", "D-RESOURCE-A", "direct_and_derived", "bytes; 100×(B_bytes-A_bytes)/A_bytes", "비휘발 +34,308 B/+111.53%; 정적 RAM +2,040 B/+138.40%; max stack 10,264 B", "RESOURCE-A/DE/{metric}", "DE A/B의 같은 자원 종류 및 연산별 stack", "expCJ 결합 section과 감산; 타 플랫폼 순수 라이브러리 크기로 해석"),
        ("T46", "DF", "M85 잔여 병목 micro-gate", "같은 입력·빌드의 scalar/독립 기준 커널", "D-SEQ", "local_only", "100×(A-B)/A", "MVE cswap 46.851%; paired inversion 47.487%; 실패 후보 2개", "LOCAL-SEQ/DF/{gate}", "DF 내부의 같은 gate A/B", "micro 이득을 전체 X-Wing 이득으로 승격"),
        ("T47", "DH", "MVE cswap·paired inversion 전체 경로", "같은 ELF A 기준 연산", "D-PAIR-A", "derived", "100×(A-B)/A", "encaps 결합 4.226–4.228%; warm/cold 1.707–1.709/0.928%", "PAIR-A/DH/{operation}/{cache}", "DH 내부 동일 연산·cache", "T39 개선률과 합산·곱셈"),
        ("T48", "DI", "dual-beat cswap 스케줄", "같은 입력 순차 cswap 또는 같은 ELF A 경로", "D-SEQ;D-PAIR-A;D-INST", "derived", "100×(A-B)/A; cycles/instruction", "micro 12.883%; E2E 0.162–0.309%; 최종 기각", "LOCAL-SEQ/DI/cswap; PAIR-A/DI/{operation}/{cache}", "DI 내부 동일 스케줄·경로", "stall 0을 인과 증명으로 해석; 최종 총계에 포함"),
        ("T49", "DJ", "최초 A0→최종 B8 직접 총효과", "같은 ELF A0 기준 연산과 같은 wrapper의 A0 자원", "D-PAIR-A;D-RESOURCE-A", "direct_and_derived", "100×(A0-B8)/A0; bytes", "19.52/19.75/11.66/15.48%; 동일 경로 stack 차이 0", "PAIR-A/DJ/{run}/{operation}/{cache}; RESOURCE-A/DJ/{metric}", "DJ 동일 ELF·연산·cache·wrapper", "T39/T47 개선률을 더하거나 dispatcher-free 배포값으로 해석"),
    ]
    for item, experiments, family, original, ids, status, formula, normalized, group, allowed, forbidden in mappings:
        rows.append(
            {
                "row_kind": "data_mapping",
                "source_item": item,
                "related_experiments": experiments,
                "data_family": family,
                "original_denominator": original,
                "standard_denominator_ids": ids,
                "standard_denominator": "레지스트리의 ID별 정의; 여러 ID는 지표별 분리",
                "reference_cycles": "",
                "operation_scope": "원래 연산·빌드·cache 상태 유지",
                "conversion_status": status,
                "conversion_formula": formula,
                "normalized_value_or_scope": normalized,
                "comparability_group": group,
                "allowed_comparison": allowed,
                "forbidden_comparison": forbidden,
                "evidence": f"논문_데이터_표.md {item}; paper/데이터_누적_검증대장.md §5",
                "notes": "원시 cycle 불변; 환산은 명시된 분자와 동일 셀 분모만 사용",
            }
        )
    return rows


def main() -> int:
    members = artifact_membership()
    paths = sorted(
        (
            path for path in TOPIC_ROOT.rglob("*")
            if path.is_file() and not (path.parent == PAPER_ROOT and path.name in GENERATED_NAMES)
        ),
        key=lambda path: rel(path).casefold(),
    )

    hashed: list[tuple[Path, int, str]] = []
    duplicate_map: defaultdict[tuple[int, str], list[str]] = defaultdict(list)
    for path in paths:
        size = path.stat().st_size
        digest = sha256(path)
        hashed.append((path, size, digest))
        duplicate_map[(size, digest)].append(rel(path))

    catalog_rows: list[dict[str, object]] = []
    exclusions: list[dict[str, object]] = []
    for path, size, digest in hashed:
        path_text = rel(path)
        classification = classify(path_text)
        experiment_ids, special_notes = filename_experiment_ids(path_text)
        notes = list(special_notes)
        group_size = len(duplicate_map[(size, digest)])
        if group_size > 1:
            notes.append(f"same-content group size={group_size}")
        if size == 0:
            notes.append("zero-byte placeholder")
        included = classification["all_data_included"] == "Y"
        row: dict[str, object] = {
            "path": path_text,
            "archive_path": f"corpus/A주제/{path_text}" if included else "",
            "bytes": size,
            "sha256": digest,
            "modified_local": datetime.fromtimestamp(path.stat().st_mtime).astimezone().isoformat(timespec="seconds"),
            "extension": classification["extension"],
            "top_area": classification["top_area"],
            "date": extract_date(path_text),
            "experiment_ids": ";".join(experiment_ids),
            "role": classification["role"],
            "evidence_level": classification["evidence_level"],
            "data_stage": classification["data_stage"],
            "lifecycle": classification["lifecycle"],
            "canonicality": classification["canonicality"],
            "all_data_included": classification["all_data_included"],
            "artifact_included": "Y" if is_artifact_included(path_text, digest, members) else "N",
            "duplicate_group_size": group_size,
            "notes": "; ".join(notes),
        }
        catalog_rows.append(row)
        if not included:
            exclusions.append(
                {
                    "path": path_text,
                    "bytes": size,
                    "sha256": digest,
                    "reason": "Git internal metadata" if classification["role"] == "vcs_metadata" else "rebuildable Python cache",
                    "role": classification["role"],
                }
            )

    ledger_text = (PAPER_ROOT / "데이터_누적_검증대장.md").read_text(encoding="utf-8")
    lineage_rows = build_lineage(catalog_rows, ledger_text)
    denominator_rows = build_denominator_catalog()
    write_tsv(CATALOG_PATH, CATALOG_COLUMNS, catalog_rows)
    write_tsv(LINEAGE_PATH, LINEAGE_COLUMNS, lineage_rows)
    write_tsv(DENOMINATOR_PATH, DENOMINATOR_COLUMNS, denominator_rows)
    write_tsv(
        EXCLUSIONS_PATH,
        ["path", "bytes", "sha256", "reason", "role"],
        exclusions,
    )

    role_counts = Counter(str(row["role"]) for row in catalog_rows)
    stage_counts = Counter(str(row["data_stage"]) for row in catalog_rows)
    evidence_counts = Counter(str(row["evidence_level"]) for row in catalog_rows)
    included_rows = [row for row in catalog_rows if row["all_data_included"] == "Y"]
    summary = {
        "generated_at": datetime.now().astimezone().isoformat(timespec="seconds"),
        "topic_root": str(TOPIC_ROOT),
        "catalog_rows": len(catalog_rows),
        "included_source_files": len(included_rows),
        "excluded_source_files": len(exclusions),
        "included_source_bytes": sum(int(row["bytes"]) for row in included_rows),
        "excluded_source_bytes": sum(int(row["bytes"]) for row in catalog_rows if row["all_data_included"] == "N"),
        "artifact_included_files": sum(row["artifact_included"] == "Y" for row in catalog_rows),
        "experiment_records": sum(row["record_type"] == "experiment" for row in lineage_rows),
        "candidate_records": sum(row["record_type"] == "candidate" for row in lineage_rows),
        "denominator_standards": sum(row["row_kind"] == "standard" for row in denominator_rows),
        "denominator_data_mappings": sum(row["row_kind"] == "data_mapping" for row in denominator_rows),
        "denominator_conversion_status_counts": dict(sorted(Counter(
            str(row["conversion_status"]) for row in denominator_rows if row["row_kind"] == "data_mapping"
        ).items())),
        "duplicate_groups": sum(len(values) > 1 for values in duplicate_map.values()),
        "duplicate_instances": sum(len(values) for values in duplicate_map.values() if len(values) > 1),
        "role_counts": dict(sorted(role_counts.items())),
        "stage_counts": dict(sorted(stage_counts.items())),
        "evidence_counts": dict(sorted(evidence_counts.items())),
        "generated_outputs_excluded_from_snapshot": sorted(GENERATED_NAMES),
    }
    SUMMARY_PATH.write_text(json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    WORKBOOK_JSON_PATH.write_text(
        json.dumps(
            {
                "catalog_columns": CATALOG_COLUMNS,
                "catalog_rows": catalog_rows,
                "lineage_columns": LINEAGE_COLUMNS,
                "lineage_rows": lineage_rows,
                "denominator_columns": DENOMINATOR_COLUMNS,
                "denominator_rows": denominator_rows,
                "exclusion_columns": ["path", "bytes", "sha256", "reason", "role"],
                "exclusion_rows": exclusions,
                "summary": summary,
            },
            ensure_ascii=False,
        ) + "\n",
        encoding="utf-8",
    )
    print(
        "DATA_CATALOG_BUILD_PASS "
        f"rows={summary['catalog_rows']} included={summary['included_source_files']} "
        f"excluded={summary['excluded_source_files']} experiments={summary['experiment_records']} "
        f"candidates={summary['candidate_records']} denominators={summary['denominator_data_mappings']}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
