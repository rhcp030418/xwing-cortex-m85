"""Boundary tests for the frozen-AF issue-class mapping."""

import unittest

from jlink_icount_frozen_af import issue_class


class IssueClassTests(unittest.TestCase):
    def test_branch_and_loop_mnemonics(self) -> None:
        for mnemonic in (
            "b", "b.w", "beq", "bne.w", "bl", "blx", "bx", "cbz",
            "cbnz", "tbb", "tbh", "dls", "wls", "le", "le.n",
        ):
            with self.subTest(mnemonic=mnemonic):
                self.assertEqual(issue_class(mnemonic), "branch_loop")

    def test_b_prefixed_nonbranches(self) -> None:
        for mnemonic in ("bic", "bic.w", "bfi", "bfc", "bkpt"):
            with self.subTest(mnemonic=mnemonic):
                expected = "system" if mnemonic == "bkpt" else "scalar_alu_shift"
                self.assertEqual(issue_class(mnemonic), expected)

    def test_representative_other_classes(self) -> None:
        expected = {
            "ldr.w": "scalar_load_store",
            "umaal": "scalar_multiply_mac",
            "vldrw.u32": "mve_load_store",
            "veor": "mve_alu_shift",
        }
        for mnemonic, issue in expected.items():
            with self.subTest(mnemonic=mnemonic):
                self.assertEqual(issue_class(mnemonic), issue)


if __name__ == "__main__":
    unittest.main()
