"""Run the frozen AF all-U ITCM image with the matching 237-slot harvester."""

from pathlib import Path
import shutil
import sys
import tempfile


HERE = Path(__file__).resolve().parent
HARNESS = HERE.parents[1]
FROZEN = HARNESS / "artifacts" / "2026-08-24_expAI"
sys.path.insert(0, str(HARNESS))

import harvest_ra8m1_expAC as harvest  # noqa: E402


harvest.ELF = str(FROZEN / "pre_expAI_blinky.elf")
STAGED_SREC = Path(tempfile.gettempdir()) / "expCK_frozen_af.srec"
shutil.copyfile(FROZEN / "pre_expAI_blinky.srec", STAGED_SREC)
harvest.SREC = str(STAGED_SREC)
harvest.SLOT_N = 237


if __name__ == "__main__":
    harvest.main()
