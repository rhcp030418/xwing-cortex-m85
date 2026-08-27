"""Prepare, report, and freeze experiment AL without touching prior artifacts."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import shutil
import sys
import tempfile
import time


HERE = Path(__file__).resolve().parent
TOOLS = Path(__file__).resolve()
DEFAULT_PROJECT = Path(r"C:\Users\cnscj\e2_studio\workspace\blinky")
INC_SOURCE = HERE / "expAL_factorial.inc"
PREREG = HERE / "2026-08-24_expAL_cumulative_factorial_prereg.md"
HARVESTER = HERE / "harvest_ra8m1_expAL.py"
RUNNER = HERE / "run_expAL.ps1"
DEFAULT_LOGS = (
    HERE / "logs" / "2026-08-24_expAL_run1.txt",
    HERE / "logs" / "2026-08-24_expAL_run2.txt",
)
DEFAULT_RESULT = HERE / "2026-08-24_expAL_results.md"
DEFAULT_ARTIFACT = HERE / "artifacts" / "2026-08-24_expAL"
DEFAULT_STAGE = HERE / "staging" / "2026-08-24_expAL"
DEFAULT_BUILD_LOG = HERE / "logs" / "2026-08-24_expAL_build.txt"

INCLUDE = '#include "expAL_factorial.inc"'
CALL = "    expal_run_all();"
OLD_READY = '    uart_puts("rep arrays ready x100 (309 slots)\\n");'
NEW_READY = '    uart_puts("rep arrays ready x100 (333 slots)\\n");'


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest().upper()


def project_fingerprint(project: Path) -> str:
    digest = hashlib.sha256()
    files = []
    for path in project.rglob("*"):
        if not path.is_file():
            continue
        relative = path.relative_to(project)
        if any(part in {"Debug", ".git", ".metadata"} for part in relative.parts):
            continue
        if path.name == "JLinkLog.log":
            continue
        files.append((relative, path))
    for relative, path in sorted(files, key=lambda item: item[0].as_posix()):
        digest.update(relative.as_posix().encode("utf-8"))
        digest.update(b"\0")
        with path.open("rb") as handle:
            for chunk in iter(lambda: handle.read(1024 * 1024), b""):
                digest.update(chunk)
        digest.update(b"\0")
    return digest.hexdigest().upper()


def write_atomic(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(
        "w", encoding="utf-8", newline="\n", dir=path.parent, delete=False
    ) as handle:
        handle.write(text)
        temporary = Path(handle.name)
    try:
        for attempt in range(20):
            try:
                temporary.replace(path)
                return
            except PermissionError:
                if attempt == 19:
                    raise
                time.sleep(0.1)
    finally:
        if temporary.exists():
            temporary.unlink()


def replace_once(text: str, old: str, new: str, label: str) -> str:
    count = text.count(old)
    if count != 1:
        raise ValueError(f"{label}: 예상 anchor 1개, 실제 {count}개")
    return text.replace(old, new, 1)


def patch_harness(text: str) -> str:
    applied = (
        "#define REP_SLOTS 333" in text
        and INCLUDE in text
        and CALL in text
        and NEW_READY in text
    )
    if applied:
        return text

    text = replace_once(
        text, "#define REP_SLOTS 309", "#define REP_SLOTS 333", "REP_SLOTS"
    )
    text = replace_once(
        text, "void harness_main(void)", INCLUDE + "\n\nvoid harness_main(void)", "include"
    )
    text = replace_once(
        text,
        OLD_READY,
        "    /* ==== Experiment AL: same-ELF cumulative 2x2 ==== */\n"
        + CALL
        + "\n\n"
        + NEW_READY,
        "harness_main call",
    )
    return text


def preflight(project: Path) -> Path:
    harness = project / "src" / "harness.c"
    required = {
        harness: "void harness_main(void)",
        project / "src" / "mlkem" / "ntt.c": "mlkem_ntt_mode",
        project / "src" / "mlkem" / "cbd.c": "mlkem_c9_mode",
        project / "src" / "mlkem" / "poly.c": "mlkem_c9_mode",
        project / "src" / "mlkem" / "poly.h": "mlkem_c9_mode",
        project / "src" / "mlkem" / "poly_mve.c": "#define EXPAK_ITCM 0",
    }
    for path, needle in required.items():
        if not path.is_file():
            raise FileNotFoundError(path)
        if needle not in path.read_text(encoding="utf-8"):
            raise ValueError(f"{path}: {needle!r} 없음")
    if not INC_SOURCE.is_file():
        raise FileNotFoundError(INC_SOURCE)
    return harness


def command_check(project: Path) -> None:
    harness = preflight(project)
    original = harness.read_text(encoding="utf-8")
    patched = patch_harness(original)
    assert "#define REP_SLOTS 333" in patched
    assert patched.count(INCLUDE) == 1
    assert patched.count(CALL) == 1
    assert patch_harness(patched) == patched
    installed_inc = project / "src" / INC_SOURCE.name
    if CALL in original:
        if not installed_inc.is_file() or sha256(installed_inc) != sha256(INC_SOURCE):
            raise ValueError(f"설치된 include가 준비본과 다름: {installed_inc}")
    print(f"expAL prepare check PASS: {harness}")
    print(f"  harness SHA-256 current={sha256(harness)}")
    print(f"  expAL include SHA-256={sha256(INC_SOURCE)}")


def command_apply(project: Path) -> None:
    harness = preflight(project)
    original = harness.read_text(encoding="utf-8")
    patched = patch_harness(original)
    destination_inc = project / "src" / INC_SOURCE.name

    if patched == original and destination_inc.is_file():
        if sha256(destination_inc) == sha256(INC_SOURCE):
            print("expAL already applied")
            return
        include_backup = destination_inc.with_name(
            "expAL_factorial.inc.bak-20260824-AL"
        )
        if include_backup.exists():
            raise FileExistsError(f"기존 include backup을 덮지 않음: {include_backup}")
        shutil.copy2(destination_inc, include_backup)
        shutil.copy2(INC_SOURCE, destination_inc)
        print(f"expAL include updated: {destination_inc}")
        print(f"  backup: {include_backup}")
        return

    backup = harness.with_name("harness.c.bak-20260824-AL")
    if backup.exists():
        raise FileExistsError(f"기존 backup을 덮지 않음: {backup}")
    shutil.copy2(harness, backup)
    shutil.copy2(INC_SOURCE, destination_inc)
    write_atomic(harness, patched)
    print(f"expAL applied: {harness}")
    print(f"  backup: {backup}")
    print(f"  include: {destination_inc}")


def payload_from_log(path: Path) -> dict[str, object]:
    for line in reversed(path.read_text(encoding="utf-8", errors="replace").splitlines()):
        if line.startswith("EXPAL_JSON "):
            return json.loads(line.removeprefix("EXPAL_JSON "))
    raise ValueError(f"EXPAL_JSON 없음: {path}")


def report_text(logs: tuple[Path, Path]) -> tuple[str, bool]:
    payloads = [payload_from_log(path) for path in logs]
    same_image = (
        len({p["srec_sha256"] for p in payloads}) == 1
        and len({p["elf_sha256"] for p in payloads}) == 1
        and len({p["harvester_sha256"] for p in payloads}) == 1
        and len({p["readback_sha256"] for p in payloads}) == 1
        and len({p["readback_bytes"] for p in payloads}) == 1
        and all(p["readback_bytes"] > 0 for p in payloads)
    )
    all_gates = all(bool(p["gate_pass"]) for p in payloads)
    all_positive = True
    reproducible = True

    def triplet(value: dict[str, int]) -> str:
        return f"{value['a']:+,} / {value['b']:+,} / {value['conservative']:+,}"

    lines = [
        "# 실험 AL 결과 — 같은-ELF X/Y/C8 × C9 누적 X-Wing",
        "",
        "> 자동 생성: `expAL_tools.py report`. 보드 실측값 외 추정값 없음.",
        "> 기준선 00은 후보 코드가 ELF에 존재하는 same-ELF runtime scalar path다.",
        "",
        "## 직접 누적 결과 (00→11)",
        "",
        "| run | 연산 | 00a | 11a | 11b | 00b | 절감 a / b / min | min 절감률 |",
        "|---:|---|---:|---:|---:|---:|---:|---:|",
    ]
    for run, payload in enumerate(payloads, 1):
        measurements = payload["measurements"]
        effects = payload["effects"]
        for op in ("keygen", "encaps", "decaps"):
            direct = effects[op]["direct_00_to_11"]
            all_positive &= direct["conservative"] > 0
            lines.append(
                f"| {run} | {op} | {measurements['00a'][op]:,} | "
                f"{measurements['11a'][op]:,} | {measurements['11b'][op]:,} | "
                f"{measurements['00b'][op]:,} | **{triplet(direct)}** | "
                f"**{direct['pct_conservative']:.3f}%** |"
            )

    lines += [
        "",
        "## 요인별 효과와 상호작용",
        "",
        "| run | 연산 | X/Y/C8 @ C9=0 (a/b/min) | X/Y/C8 @ C9=1 (a/b/min) | C9 @ X/Y/C8=0 (a/b/min) | C9 @ X/Y/C8=1 (a/b/min) | synergy a / b / min |",
        "|---:|---|---:|---:|---:|---:|---:|",
    ]
    for run, payload in enumerate(payloads, 1):
        for op in ("keygen", "encaps", "decaps"):
            row = payload["effects"][op]
            lines.append(
                f"| {run} | {op} | {triplet(row['xyc8_at_c9_0'])} | "
                f"{triplet(row['xyc8_at_c9_1'])} | "
                f"{triplet(row['c9_at_xyc8_0'])} | "
                f"{triplet(row['c9_at_xyc8_1'])} | "
                f"{row['synergy']['a']:+,} / {row['synergy']['b']:+,} / "
                f"{row['synergy']['conservative']:+,} |"
            )

    for op in ("keygen", "encaps", "decaps"):
        percentages = [
            p["effects"][op]["direct_00_to_11"]["pct_conservative"]
            for p in payloads
        ]
        reproducible &= abs(percentages[0] - percentages[1]) <= 0.5

    passed = all_gates and same_image and all_positive and reproducible
    if passed:
        verdict = "**대표값 채택 조건 통과.**"
    elif not all_gates or not same_image:
        verdict = "**성능 판정 기각:** gate 실패 또는 두 run의 frozen image/readback 불일치."
    elif not all_positive:
        verdict = "**누적 실패/혼합:** 한 연산 이상 00→11 절감이 양수가 아님."
    else:
        verdict = "**방향 성공·대표값 보류:** run 간 절감률 차이가 0.5%p 초과."

    stack_text = " / ".join(
        f"{value:,}" if isinstance(value, int) else "미확인"
        for value in (payloads[0]["stack_used"], payloads[1]["stack_used"])
    )
    lines += [
        "",
        "## 판정·게이트",
        "",
        verdict,
        "",
        f"- 두 run firmware gate: {'PASS' if all_gates else 'FAIL'}",
        f"- 두 run 동일 frozen ELF/SREC/harvester/readback: {'PASS' if same_image else 'FAIL'}",
        f"- 세 연산 direct 절감 양수: {'PASS' if all_positive else 'FAIL'}",
        f"- run 간 절감률 차이 ≤0.5%p: {'PASS' if reproducible else 'FAIL'}",
        f"- 측정 SREC SHA-256: `{payloads[0]['srec_sha256']}`",
        f"- 측정 ELF run1/run2: `{payloads[0]['elf_sha256']}` / `{payloads[1]['elf_sha256']}`",
        f"- frozen harvester SHA-256: `{payloads[0]['harvester_sha256']}`",
        f"- code-flash readback run1/run2: `{payloads[0]['readback_sha256']}` / `{payloads[1]['readback_sha256']}` ({payloads[0]['readback_bytes']:,} B)",
        f"- stack high-water run1/run2: {stack_text} B",
        "",
        "## 원시 로그",
        "",
        f"- `{logs[0].as_posix()}` — `{sha256(logs[0])}`",
        f"- `{logs[1].as_posix()}` — `{sha256(logs[1])}`",
        "",
    ]
    return "\n".join(lines), passed


def command_report(logs: tuple[Path, Path], output: Path) -> bool:
    text, passed = report_text(logs)
    write_atomic(output, text)
    print(f"expAL report written: {output}")
    print("expAL prereg verdict: " + ("PASS" if passed else "NOT PASS"))
    return passed


def command_self_test() -> None:
    source = (
        "#define REP_SLOTS 309\n"
        "void harness_main(void)\n{\n"
        '    uart_puts("rep arrays ready x100 (309 slots)\\n");\n'
        "}\n"
    )
    patched = patch_harness(source)
    assert "#define REP_SLOTS 333" in patched
    assert patched.count(INCLUDE) == 1 and patched.count(CALL) == 1
    assert patch_harness(patched) == patched

    measurements = {
        condition: {op: value for op in ("keygen", "encaps", "decaps")}
        for condition, value in {
            "00a": 1000, "00b": 1002, "10a": 970, "10b": 972,
            "01a": 960, "01b": 962, "11a": 920, "11b": 922,
        }.items()
    }
    delta = {"a": 80, "b": 80, "conservative": 80, "pct_conservative": 8.0}
    simple = {"a": 30, "b": 30, "conservative": 30, "pct_conservative": 3.0}
    effects = {
        op: {
            "direct_00_to_11": delta,
            "xyc8_at_c9_0": simple,
            "xyc8_at_c9_1": simple,
            "c9_at_xyc8_0": simple,
            "c9_at_xyc8_1": simple,
            "synergy": {"a": 10, "b": 10, "conservative": 10},
        }
        for op in ("keygen", "encaps", "decaps")
    }
    payload = {
        "effects": effects,
        "elf_sha256": "E" * 64,
        "gate_pass": True,
        "harvester_sha256": "H" * 64,
        "measurements": measurements,
        "readback_bytes": 1,
        "readback_sha256": "R" * 64,
        "srec_sha256": "S" * 64,
        "stack_used": 256,
    }
    with tempfile.TemporaryDirectory() as temporary:
        logs = tuple(Path(temporary) / f"run{i}.txt" for i in (1, 2))
        for log in logs:
            log.write_text("EXPAL_JSON " + json.dumps(payload) + "\n", encoding="utf-8")
        _, passed = report_text(logs)
        assert passed
    print("expAL tools self-test PASS")


def copy_project(project: Path, destination: Path) -> None:
    shutil.copytree(
        project,
        destination,
        ignore=shutil.ignore_patterns("Debug", ".git", ".metadata", "JLinkLog.log"),
    )


def manifest_lines(directory: Path, excluded: tuple[str, ...]) -> list[str]:
    return [
        f"{sha256(path)}  {path.relative_to(directory).as_posix()}"
        for path in sorted(p for p in directory.rglob("*") if p.is_file())
        if path.name not in excluded
    ]


def verify_manifest(directory: Path, name: str) -> None:
    manifest = directory / name
    if not manifest.is_file():
        raise FileNotFoundError(manifest)
    for line in manifest.read_text(encoding="utf-8").splitlines():
        expected, relative = line.split("  ", 1)
        path = directory / Path(relative)
        if not path.is_file() or sha256(path) != expected:
            raise ValueError(f"manifest 불일치: {relative}")


def command_stage(
    project: Path,
    destination: Path,
    build_log: Path,
    expected_source_fingerprint: str | None,
) -> None:
    harness = preflight(project)
    text = harness.read_text(encoding="utf-8")
    if CALL not in text or "#define REP_SLOTS 333" not in text:
        raise ValueError("expAL harness가 아직 적용되지 않음")
    installed_inc = project / "src" / INC_SOURCE.name
    if not installed_inc.is_file() or sha256(installed_inc) != sha256(INC_SOURCE):
        raise ValueError("설치된 expAL include와 준비본이 다름")
    if destination.exists():
        raise FileExistsError(f"기존 staging을 덮지 않음: {destination}")
    for path in (build_log, PREREG, INC_SOURCE, HARVESTER, RUNNER, TOOLS):
        if not path.is_file():
            raise FileNotFoundError(path)

    source_fingerprint = project_fingerprint(project)
    if (
        expected_source_fingerprint is not None
        and source_fingerprint != expected_source_fingerprint.upper()
    ):
        raise ValueError("build 전/후 project source fingerprint가 다름")
    destination.mkdir(parents=True)
    copy_project(project, destination / "project")
    frozen_fingerprint = project_fingerprint(destination / "project")
    if frozen_fingerprint != source_fingerprint:
        raise ValueError("staging 복제 중 project source가 바뀌었거나 누락됨")
    (destination / "PROJECT_SOURCE_SHA256.txt").write_text(
        source_fingerprint + "\n", encoding="ascii", newline="\n"
    )
    debug = project / "Debug"
    for name in ("blinky.elf", "blinky.srec", "blinky.map", "blinky.siz"):
        source = debug / name
        if not source.is_file() and name != "blinky.siz":
            raise FileNotFoundError(source)
        if source.is_file():
            shutil.copy2(source, destination / name)
    for source in debug.rglob("*"):
        keep_generated = (
            source.name.startswith("makefile")
            or source.suffix in {".mk", ".ld"}
            or source.name in {"compile_commands.json", "bsp_linker_info.h"}
        )
        if source.is_file() and keep_generated:
            target = destination / "debug-metadata" / source.relative_to(debug)
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, target)
    for source in (
        build_log,
        PREREG,
        INC_SOURCE,
        HARVESTER,
        RUNNER,
        HERE / "run_harvest_logged.py",
        TOOLS,
    ):
        shutil.copy2(source, destination / source.name)

    lines = manifest_lines(destination, ("MEASUREMENT_SHA256SUMS.txt",))
    (destination / "MEASUREMENT_SHA256SUMS.txt").write_text(
        "\n".join(lines) + "\n", encoding="utf-8", newline="\n"
    )
    print(f"expAL measurement image frozen before flash: {destination}")
    print(f"  SOURCE={source_fingerprint}")
    print(f"  ELF={sha256(destination / 'blinky.elf')}")
    print(f"  SREC={sha256(destination / 'blinky.srec')}")


def command_freeze(
    stage: Path, logs: tuple[Path, Path], result: Path, destination: Path
) -> None:
    verify_manifest(stage, "MEASUREMENT_SHA256SUMS.txt")
    for path in (*logs, result):
        if not path.is_file():
            raise FileNotFoundError(path)
    expected_result, _ = report_text(logs)
    if result.read_text(encoding="utf-8") != expected_result:
        raise ValueError("결과 문서가 현재 두 raw log에서 재생성한 내용과 다름")
    payloads = [payload_from_log(path) for path in logs]
    if len({payload["srec_sha256"] for payload in payloads}) != 1:
        raise ValueError("두 run의 SREC 해시가 다름")
    if (
        len({payload["readback_sha256"] for payload in payloads}) != 1
        or len({payload["readback_bytes"] for payload in payloads}) != 1
        or any(payload["readback_bytes"] <= 0 for payload in payloads)
    ):
        raise ValueError("두 run의 code-flash readback 증거가 다르거나 비어 있음")
    if payloads[0]["srec_sha256"] != sha256(stage / "blinky.srec"):
        raise ValueError("실측 SREC과 pre-flash frozen SREC이 다름")
    if any(payload["elf_sha256"] != sha256(stage / "blinky.elf") for payload in payloads):
        raise ValueError("실측 ELF와 pre-flash frozen ELF가 다름")
    frozen_harvester = sha256(stage / HARVESTER.name)
    if any(payload["harvester_sha256"] != frozen_harvester for payload in payloads):
        raise ValueError("실측 회수기와 pre-flash frozen 회수기가 다름")
    if destination.exists():
        raise FileExistsError(f"기존 artifact를 덮지 않음: {destination}")

    shutil.copytree(stage, destination)
    for source in (*logs, result):
        shutil.copy2(source, destination / source.name)

    lines = manifest_lines(destination, ("SHA256SUMS.txt",))
    (destination / "SHA256SUMS.txt").write_text(
        "\n".join(lines) + "\n", encoding="utf-8", newline="\n"
    )
    print(f"expAL clean-room artifact frozen: {destination}")
    print(f"  files={len(lines)}")


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser()
    result.add_argument(
        "command",
        choices=(
            "check", "apply", "fingerprint", "stage", "report", "freeze",
            "self-test",
        ),
        nargs="?",
        default="check",
    )
    result.add_argument("--project", type=Path, default=DEFAULT_PROJECT)
    result.add_argument("--logs", type=Path, nargs=2, default=DEFAULT_LOGS)
    result.add_argument("--result", type=Path, default=DEFAULT_RESULT)
    result.add_argument("--artifact", type=Path, default=DEFAULT_ARTIFACT)
    result.add_argument("--stage", type=Path, default=DEFAULT_STAGE)
    result.add_argument("--build-log", type=Path, default=DEFAULT_BUILD_LOG)
    result.add_argument("--source-fingerprint")
    return result


def main() -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    args = parser().parse_args()
    logs = tuple(args.logs)
    if args.command == "check":
        command_check(args.project)
    elif args.command == "self-test":
        command_self_test()
    elif args.command == "apply":
        command_apply(args.project)
    elif args.command == "fingerprint":
        print(project_fingerprint(args.project))
    elif args.command == "stage":
        command_stage(
            args.project, args.stage, args.build_log, args.source_fingerprint
        )
    elif args.command == "report":
        return 0 if command_report(logs, args.result) else 2
    else:
        command_freeze(args.stage, logs, args.result, args.artifact)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
