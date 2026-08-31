#!/usr/bin/env python3
"""Create and verify the complete, catalogued A-topic research corpus ZIP."""

from __future__ import annotations

import csv
import hashlib
from pathlib import Path
import zipfile


PAPER_ROOT = Path(__file__).resolve().parent
TOPIC_ROOT = PAPER_ROOT.parent
CATALOG_PATH = PAPER_ROOT / "전체_데이터_카탈로그.tsv"
LINEAGE_PATH = PAPER_ROOT / "실험_계보_카탈로그.tsv"
DENOMINATOR_PATH = PAPER_ROOT / "분모_표준화_카탈로그.tsv"
EXCLUSIONS_PATH = PAPER_ROOT / "데이터_패키지_제외목록.tsv"
SUMMARY_PATH = PAPER_ROOT / "데이터_카탈로그_요약.json"
WORKBOOK_PATH = PAPER_ROOT / "데이터_카탈로그.xlsx"
README_PATH = PAPER_ROOT / "전체_데이터_패키지_README.md"
OUTPUT_ZIP = PAPER_ROOT / "all-data-upload.zip"
FIXED_TIME = (2026, 8, 29, 0, 0, 0)


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest().upper()


def sha256_path(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest().upper()


def catalog_rows() -> list[dict[str, str]]:
    with CATALOG_PATH.open("r", encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


def zip_info(name: str, compression: int) -> zipfile.ZipInfo:
    info = zipfile.ZipInfo(name, date_time=FIXED_TIME)
    info.compress_type = compression
    info.external_attr = 0o100644 << 16
    return info


def compression_for(name: str) -> int:
    if Path(name).suffix.lower() in {".zip", ".png", ".pdf", ".gz", ".pack", ".jpg", ".jpeg"}:
        return zipfile.ZIP_STORED
    return zipfile.ZIP_DEFLATED


def add_bytes(
    archive: zipfile.ZipFile,
    name: str,
    data: bytes,
    manifest: dict[str, tuple[int, str]],
) -> None:
    archive.writestr(zip_info(name, compression_for(name)), data, compresslevel=6)
    manifest[name] = (len(data), sha256_bytes(data))


def build_package() -> tuple[int, int, str]:
    required = [
        CATALOG_PATH,
        LINEAGE_PATH,
        DENOMINATOR_PATH,
        EXCLUSIONS_PATH,
        SUMMARY_PATH,
        WORKBOOK_PATH,
        README_PATH,
    ]
    missing = [str(path) for path in required if not path.is_file()]
    if missing:
        raise ValueError("missing catalog/package inputs: " + ", ".join(missing))

    rows = catalog_rows()
    included = [row for row in rows if row["all_data_included"] == "Y"]
    archive_paths = [row["archive_path"] for row in included]
    if len(archive_paths) != len(set(archive_paths)):
        raise ValueError("catalog contains duplicate archive paths")

    # Verify every source immediately before packaging.  A catalog generated
    # before a later source edit must fail instead of silently packaging drift.
    for row in included:
        source = TOPIC_ROOT / Path(row["path"])
        if not source.is_file():
            raise ValueError(f"catalogued source is missing: {row['path']}")
        if source.stat().st_size != int(row["bytes"]):
            raise ValueError(f"catalogued size drift: {row['path']}")
        if sha256_path(source) != row["sha256"]:
            raise ValueError(f"catalogued hash drift: {row['path']}")

    manifest: dict[str, tuple[int, str]] = {}
    with zipfile.ZipFile(OUTPUT_ZIP, "w", allowZip64=True) as archive:
        metadata = {
            "00_metadata/README.md": README_PATH,
            "00_metadata/DATA_CATALOG.tsv": CATALOG_PATH,
            "00_metadata/EXPERIMENT_LINEAGE.tsv": LINEAGE_PATH,
            "00_metadata/DENOMINATOR_CATALOG.tsv": DENOMINATOR_PATH,
            "00_metadata/EXCLUSIONS.tsv": EXCLUSIONS_PATH,
            "00_metadata/SUMMARY.json": SUMMARY_PATH,
            "00_metadata/DATA_CATALOG.xlsx": WORKBOOK_PATH,
            "00_metadata/CUMULATIVE_LEDGER.md": PAPER_ROOT / "데이터_누적_검증대장.md",
            "00_metadata/CURRENT_LINEAGE.md": PAPER_ROOT / "데이터_계보_아티팩트_정합성.md",
        }
        for archive_name, source in metadata.items():
            add_bytes(archive, archive_name, source.read_bytes(), manifest)

        for row in included:
            source = TOPIC_ROOT / Path(row["path"])
            add_bytes(archive, row["archive_path"], source.read_bytes(), manifest)

        manifest_lines = [
            f"{digest.lower()}  {size}  {name}"
            for name, (size, digest) in sorted(manifest.items(), key=lambda item: item[0].casefold())
        ]
        manifest_data = ("\n".join(manifest_lines) + "\n").encode("utf-8")
        archive.writestr(
            zip_info("00_metadata/MANIFEST.sha256", zipfile.ZIP_DEFLATED),
            manifest_data,
            compresslevel=6,
        )

    verify_package(included)
    return len(included), OUTPUT_ZIP.stat().st_size, sha256_path(OUTPUT_ZIP)


def verify_package(included: list[dict[str, str]]) -> None:
    with zipfile.ZipFile(OUTPUT_ZIP) as archive:
        infos = archive.infolist()
        names = [info.filename for info in infos]
        if len(names) != len(set(names)):
            raise ValueError("package ZIP has duplicate member paths")
        bad = archive.testzip()
        if bad is not None:
            raise ValueError(f"package CRC/read failure: {bad}")
        manifest_name = "00_metadata/MANIFEST.sha256"
        if manifest_name not in names:
            raise ValueError("package has no internal manifest")
        recorded: dict[str, tuple[int, str]] = {}
        for line in archive.read(manifest_name).decode("utf-8").splitlines():
            digest, size_text, name = line.split("  ", 2)
            if name in recorded:
                raise ValueError(f"duplicate manifest path: {name}")
            recorded[name] = (int(size_text), digest.upper())
        expected_names = set(names) - {manifest_name}
        if set(recorded) != expected_names:
            raise ValueError("package manifest member set mismatch")
        for name, (size, digest) in recorded.items():
            data = archive.read(name)
            if len(data) != size or sha256_bytes(data) != digest:
                raise ValueError(f"package manifest mismatch: {name}")
        corpus_names = {name for name in names if name.startswith("corpus/A주제/")}
        expected_corpus = {row["archive_path"] for row in included}
        if corpus_names != expected_corpus:
            missing = sorted(expected_corpus - corpus_names)
            extra = sorted(corpus_names - expected_corpus)
            raise ValueError(f"corpus coverage mismatch: missing={missing[:5]} extra={extra[:5]}")


def main() -> int:
    try:
        files, size, digest = build_package()
    except (OSError, ValueError, zipfile.BadZipFile) as error:
        print(f"ALL_DATA_PACKAGE_FAIL: {error}")
        return 1
    print(
        "ALL_DATA_PACKAGE_PASS "
        f"source_files={files} zip_bytes={size} sha256={digest}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
