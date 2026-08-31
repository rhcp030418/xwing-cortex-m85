#!/usr/bin/env python3
"""Audit every physical file under A주제 and verify a SHA-256 manifest.

The manifest excludes only itself because a file cannot contain its own stable
cryptographic digest.  Everything else, including Git metadata, backups,
vendor trees, binaries, archives, the paper, and this verifier, is covered.
"""

from __future__ import annotations

import argparse
from collections import Counter
import hashlib
from pathlib import Path
import sys
import zipfile


TOPIC_ROOT = Path(__file__).resolve().parent.parent
MANIFEST = Path(__file__).resolve().parent / "전체_파일_SHA256.tsv"
HEADER = "path\tbytes\tsha256"


def relative(path: Path) -> str:
    return path.relative_to(TOPIC_ROOT).as_posix()


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest().upper()


def physical_files() -> list[Path]:
    return sorted(
        (
            path
            for path in TOPIC_ROOT.rglob("*")
            if path.is_file() and path.resolve() != MANIFEST.resolve()
        ),
        key=lambda path: relative(path).casefold(),
    )


def current_rows(files: list[Path]) -> dict[str, tuple[int, str]]:
    rows: dict[str, tuple[int, str]] = {}
    for path in files:
        rows[relative(path)] = (path.stat().st_size, sha256(path))
    return rows


def write_manifest(rows: dict[str, tuple[int, str]]) -> None:
    lines = [HEADER]
    lines.extend(
        f"{path}\t{size}\t{digest}"
        for path, (size, digest) in sorted(rows.items(), key=lambda item: item[0].casefold())
    )
    MANIFEST.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")


def read_manifest() -> dict[str, tuple[int, str]]:
    if not MANIFEST.is_file():
        raise ValueError(f"manifest does not exist: {MANIFEST}")
    lines = MANIFEST.read_text(encoding="utf-8").splitlines()
    if not lines or lines[0] != HEADER:
        raise ValueError("manifest header mismatch")
    rows: dict[str, tuple[int, str]] = {}
    for line_number, line in enumerate(lines[1:], 2):
        parts = line.split("\t")
        if len(parts) != 3:
            raise ValueError(f"manifest line {line_number}: expected 3 tab-separated fields")
        path, size_text, digest = parts
        if path in rows:
            raise ValueError(f"manifest line {line_number}: duplicate path {path!r}")
        if not size_text.isdigit() or len(digest) != 64:
            raise ValueError(f"manifest line {line_number}: invalid size or SHA-256")
        int(digest, 16)
        rows[path] = (int(size_text), digest.upper())
    return rows


def verify_manifest(actual: dict[str, tuple[int, str]]) -> None:
    recorded = read_manifest()
    added = sorted(actual.keys() - recorded.keys())
    missing = sorted(recorded.keys() - actual.keys())
    changed = sorted(path for path in actual.keys() & recorded.keys() if actual[path] != recorded[path])
    if added or missing or changed:
        details = []
        if added:
            details.append("added=" + ", ".join(added[:10]))
        if missing:
            details.append("missing=" + ", ".join(missing[:10]))
        if changed:
            details.append("changed=" + ", ".join(changed[:10]))
        raise ValueError("manifest mismatch: " + "; ".join(details))


def verify_magic(files: list[Path]) -> Counter[str]:
    signatures = {
        ".elf": b"\x7fELF",
        ".o": b"\x7fELF",
        ".png": b"\x89PNG\r\n\x1a\n",
        ".pdf": b"%PDF-",
    }
    counts: Counter[str] = Counter()
    for path in files:
        suffix = path.suffix.lower()
        signature = signatures.get(suffix)
        if signature is None:
            continue
        with path.open("rb") as handle:
            observed = handle.read(len(signature))
        if observed != signature:
            raise ValueError(f"bad {suffix} signature: {relative(path)}")
        if suffix == ".pdf":
            size = path.stat().st_size
            with path.open("rb") as handle:
                handle.seek(max(0, size - 1024))
                if b"%%EOF" not in handle.read():
                    raise ValueError(f"PDF has no trailing %%EOF marker: {relative(path)}")
        counts[suffix] += 1
    return counts


def verify_srec(path: Path) -> tuple[int, int]:
    address_lengths = {1: 2, 2: 3, 3: 4}
    records = 0
    data_bytes = 0
    segments: list[tuple[int, int, int]] = []
    for line_number, source in enumerate(path.read_text(encoding="ascii").splitlines(), 1):
        line = source.strip()
        if not line:
            continue
        if len(line) < 4 or line[0] != "S" or not line[1].isdigit():
            raise ValueError(f"{relative(path)}:{line_number}: S-record syntax")
        try:
            record = bytes.fromhex(line[2:])
        except ValueError as error:
            raise ValueError(f"{relative(path)}:{line_number}: non-hex S-record") from error
        if not record or record[0] != len(record) - 1:
            raise ValueError(f"{relative(path)}:{line_number}: byte-count mismatch")
        if sum(record) & 0xFF != 0xFF:
            raise ValueError(f"{relative(path)}:{line_number}: checksum mismatch")
        records += 1
        record_type = int(line[1])
        if record_type in address_lengths:
            address_length = address_lengths[record_type]
            address = int.from_bytes(record[1 : 1 + address_length], "big")
            length = len(record) - address_length - 2
            segments.append((address, address + length, line_number))
            data_bytes += length
    segments.sort()
    for left, right in zip(segments, segments[1:]):
        if right[0] < left[1]:
            raise ValueError(
                f"{relative(path)}:{right[2]}: data record overlaps line {left[2]}"
            )
    return records, data_bytes


def verify_archives(files: list[Path]) -> tuple[Counter[str], Counter[str]]:
    archives: Counter[str] = Counter()
    entries: Counter[str] = Counter()
    for path in files:
        suffix = path.suffix.lower()
        if suffix not in {".zip", ".xlsx"}:
            continue
        archives[suffix] += 1
        with zipfile.ZipFile(path) as archive:
            names = [item.filename for item in archive.infolist()]
            if len(names) != len(set(names)):
                raise ValueError(f"duplicate member path in ZIP: {relative(path)}")
            bad_member = archive.testzip()
            if bad_member is not None:
                raise ValueError(f"CRC/read failure in {relative(path)}: {bad_member}")
            entries[suffix] += len(names)
    return archives, entries


def audit(refresh_manifest: bool) -> None:
    files = physical_files()
    rows = current_rows(files)
    if refresh_manifest:
        write_manifest(rows)
    verify_manifest(rows)

    magic = verify_magic(files)
    srec_records = 0
    srec_bytes = 0
    srec_count = 0
    for path in files:
        if path.suffix.lower() == ".srec":
            records, data_bytes = verify_srec(path)
            srec_count += 1
            srec_records += records
            srec_bytes += data_bytes
    archive_counts, archive_entries = verify_archives(files)

    zero_files = [path for path in files if path.stat().st_size == 0]
    unexpected_zero = [
        relative(path)
        for path in zero_files
        if not relative(path).startswith(("pqmx-upstream/", "pqmx-mve-ntts/"))
    ]
    if unexpected_zero:
        raise ValueError("unexpected zero-length files: " + ", ".join(unexpected_zero))

    total_bytes = sum(size for size, _ in rows.values())
    unique_contents = len(set(rows.values()))
    print(
        "ALL_FILE_AUDIT_PASS "
        f"manifest_targets={len(rows)} bytes={total_bytes} unique_content={unique_contents} "
        f"zero_vendor_placeholders={len(zero_files)} "
        f"elf={magic['.elf']} object={magic['.o']} png={magic['.png']} pdf={magic['.pdf']} "
        f"srec={srec_count} srec_records={srec_records} srec_data_bytes={srec_bytes} "
        f"zip={archive_counts['.zip']} zip_entries={archive_entries['.zip']} "
        f"xlsx={archive_counts['.xlsx']} xlsx_entries={archive_entries['.xlsx']}"
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--refresh-manifest",
        action="store_true",
        help="rewrite the manifest from the current tree before verifying it",
    )
    args = parser.parse_args()
    try:
        audit(args.refresh_manifest)
    except (OSError, ValueError, zipfile.BadZipFile) as error:
        print(f"ALL_FILE_AUDIT_FAIL: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
