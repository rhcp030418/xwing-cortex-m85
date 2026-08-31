"""Run a harvester and save its complete stdout/stderr as UTF-8."""

from pathlib import Path
import subprocess
import sys


def main() -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    if len(sys.argv) < 3:
        raise SystemExit(
            "usage: run_harvest_logged.py HARVESTER.py OUTPUT.txt [HARVESTER_ARGS...]"
        )
    harvester = Path(sys.argv[1]).resolve()
    output = Path(sys.argv[2]).resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    with output.open("w", encoding="utf-8", newline="\n") as log:
        process = subprocess.Popen(
            [sys.executable, str(harvester), *sys.argv[3:]],
            cwd=harvester.parent,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            encoding="utf-8",
            errors="replace",
            bufsize=1,
        )
        assert process.stdout is not None
        for line in process.stdout:
            log.write(line)
            log.flush()
            sys.stdout.write(line)
            sys.stdout.flush()
        return process.wait()


if __name__ == "__main__":
    raise SystemExit(main())
