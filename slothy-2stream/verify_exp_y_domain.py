"""Host oracle for Experiment Y's Plantard-domain inverse-NTT adapter.

This is deliberately independent of the target firmware.  It checks the exact
16-bit MVE arithmetic used by the pqmx inverse prologue, emulates the current
32-bit Plantard reduction, and verifies the complete Kyber polynomial-product
contract modulo q with deterministic exhaustive and random tests.
"""

from __future__ import annotations

import hashlib
import json
import random
from typing import Iterable


Q = 3329
R = (1 << 16) % Q
P = (-(1 << 32)) % Q
R_INV = pow(R, -1, Q)
P_INV = pow(P, -1, Q)
INV128 = pow(128, -1, Q)
PLANTARD_QINV32 = 0x6BA8F301

UPSTREAM_SCALE = 512
UPSTREAM_SCALE_TWISTED = 5040
PLANTARD_SCALE = 1888
PLANTARD_SCALE_TWISTED = 18584

ZETAS = (
    -1044, -758, -359, -1517, 1493, 1422, 287, 202,
    -171, 622, 1577, 182, 962, -1202, -1474, 1468,
    573, -1325, 264, 383, -829, 1458, -1602, -130,
    -681, 1017, 732, 608, -1542, 411, -205, -1571,
    1223, 652, -552, 1015, -1293, 1491, -282, -1544,
    516, -8, -320, -666, -1618, -1162, 126, 1469,
    -853, -90, -271, 830, 107, -1421, -247, -951,
    -398, 961, -1508, -725, 448, -1065, 677, -1275,
    -1103, 430, 555, 843, -1251, 871, 1550, 105,
    422, 587, 177, -235, -291, -460, 1574, 1653,
    -246, 778, 1159, -147, -777, 1483, -602, 1119,
    -1590, 644, -872, 349, 418, 329, -156, -75,
    817, 1097, 603, 610, 1322, -1285, -1465, 384,
    -1215, -136, 1218, -1335, -874, 220, -1187, -1659,
    -1185, -1530, -1278, 794, -1510, -854, -870, 478,
    -108, -308, 996, 991, 958, -1460, 1522, 1628,
)


def signed16(value: int) -> int:
    value &= 0xFFFF
    return value - 0x10000 if value >= 0x8000 else value


def signed32(value: int) -> int:
    value &= 0xFFFFFFFF
    return value - 0x100000000 if value >= 0x80000000 else value


def vqrdmulh_s16(a: int, b: int) -> int:
    """Exact signed VQRDMULH lane behavior for the non-saturating constants here."""
    value = (a * b + (1 << 14)) >> 15
    return max(-32768, min(32767, value))


def mve_barrett_mulmod(value: int, constant: int, twisted: int) -> int:
    """Emulate VMUL.S16 + VQRDMULH.S16 + VMLA.S16 with modulus=-q."""
    low_product = signed16(value * constant)
    quotient = vqrdmulh_s16(value, twisted)
    return signed16(low_product - quotient * Q)


def plantard_reduce_current(value: int) -> int:
    """Emulate plant_red from the current Cortex-M4/M85 firmware."""
    product_low = (value * PLANTARD_QINV32) & 0xFFFFFFFF
    product_high = signed16(product_low >> 16)
    accumulator = signed32(product_high * Q + 8 * Q)
    return signed16(accumulator >> 16)


def rev4(values: list[int]) -> list[int]:
    """Transpose every 4x4 block of int32 coefficient pairs (an involution)."""
    pairs = [(values[2 * i], values[2 * i + 1]) for i in range(128)]
    for base in range(0, 128, 16):
        block = pairs[base : base + 16]
        for row in range(4):
            for col in range(4):
                pairs[base + row * 4 + col] = block[col * 4 + row]
    return [coefficient for pair in pairs for coefficient in pair]


def ntt_mod_q(source: list[int]) -> list[int]:
    result = [value % Q for value in source]
    k = 1
    length = 128
    while length >= 2:
        for start in range(0, 256, 2 * length):
            zeta = ZETAS[k] * R_INV % Q
            k += 1
            for j in range(start, start + length):
                product = zeta * result[j + length] % Q
                low = result[j]
                result[j] = (low + product) % Q
                result[j + length] = (low - product) % Q
        length //= 2
    return result


def invntt_mod_q(source: list[int], final_factor: int) -> list[int]:
    """Kyber incomplete inverse with an explicit total-domain final factor/128."""
    result = [value % Q for value in source]
    k = 127
    length = 2
    while length <= 128:
        for start in range(0, 256, 2 * length):
            zeta = ZETAS[k] * R_INV % Q
            k -= 1
            for j in range(start, start + length):
                low = result[j]
                high = result[j + length]
                result[j] = (low + high) % Q
                result[j + length] = (high - low) * zeta % Q
        length *= 2
    return [value * final_factor % Q for value in result]


def basemul_plantard(a: list[int], b: list[int]) -> list[int]:
    """Current pointwise contract: each incomplete-NTT product carries P^-1."""
    result = [0] * 256
    for block in range(64):
        zeta = ZETAS[64 + block] * R_INV % Q
        for offset, signed_zeta in ((0, zeta), (2, -zeta % Q)):
            index = 4 * block + offset
            a0, a1 = a[index], a[index + 1]
            b0, b1 = b[index], b[index + 1]
            result[index] = (a0 * b0 + signed_zeta * a1 * b1) * P_INV % Q
            result[index + 1] = (a0 * b1 + a1 * b0) * P_INV % Q
    return result


def negacyclic_schoolbook(a: list[int], b: list[int]) -> list[int]:
    result = [0] * 256
    for i, left in enumerate(a):
        for j, right in enumerate(b):
            index = i + j
            if index < 256:
                result[index] += left * right
            else:
                result[index - 256] -= left * right
    return [value % Q for value in result]


def candidate_polymul(a: list[int], b: list[int]) -> list[int]:
    pointwise = basemul_plantard(ntt_mod_q(a), ntt_mod_q(b))
    return invntt_mod_q(pointwise, PLANTARD_SCALE)


def _update_digest(digest: "hashlib._Hash", values: Iterable[int]) -> None:
    for value in values:
        digest.update((value % Q).to_bytes(2, "little"))


def run_all() -> dict[str, int | str]:
    assert PLANTARD_QINV32 * Q % (1 << 32) == 1
    assert UPSTREAM_SCALE == R * INV128 % Q
    assert PLANTARD_SCALE == P * INV128 % Q
    assert PLANTARD_SCALE == UPSTREAM_SCALE * P * R_INV % Q
    assert UPSTREAM_SCALE_TWISTED == round(UPSTREAM_SCALE * (1 << 15) / Q)
    assert PLANTARD_SCALE_TWISTED == round(PLANTARD_SCALE * (1 << 15) / Q)

    upstream_min, upstream_max = 32767, -32768
    candidate_min, candidate_max = 32767, -32768
    ratio = P * R_INV % Q
    for raw in range(1 << 16):
        value = signed16(raw)
        upstream = mve_barrett_mulmod(
            value, UPSTREAM_SCALE, UPSTREAM_SCALE_TWISTED
        )
        candidate = mve_barrett_mulmod(
            value, PLANTARD_SCALE, PLANTARD_SCALE_TWISTED
        )
        assert (upstream - value * UPSTREAM_SCALE) % Q == 0
        assert (candidate - value * PLANTARD_SCALE) % Q == 0
        assert (candidate - upstream * ratio) % Q == 0
        upstream_min = min(upstream_min, upstream)
        upstream_max = max(upstream_max, upstream)
        candidate_min = min(candidate_min, candidate)
        candidate_max = max(candidate_max, candidate)

    for value in range(-32768, 32768):
        assert (plantard_reduce_current(value) - value * P_INV) % Q == 0

    # plant_red has an explicit bounded-input precondition; INT32_MIN is not a
    # valid product accumulator.  Cover every pair of centered Zq operands,
    # then stress a much wider conservative accumulator interval.
    centered_low = -(Q // 2)
    centered_high = Q // 2 + 1
    centered_product_checks = 0
    for left in range(centered_low, centered_high):
        for right in range(centered_low, centered_high):
            value = left * right
            assert (plantard_reduce_current(value) - value * P_INV) % Q == 0
            centered_product_checks += 1

    rng = random.Random(0x45585059)
    accumulator_limit = 1 << 30
    boundaries = (
        -accumulator_limit, -accumulator_limit + 1, -Q, -1,
        0, 1, Q, accumulator_limit - 2, accumulator_limit - 1,
    )
    for value in boundaries:
        assert (plantard_reduce_current(value) - value * P_INV) % Q == 0
    random_i32_checks = 250_000
    for _ in range(random_i32_checks):
        value = rng.randrange(-accumulator_limit, accumulator_limit)
        assert (plantard_reduce_current(value) - value * P_INV) % Q == 0

    layout_probe = list(range(256))
    assert rev4(rev4(layout_probe)) == layout_probe

    digest = hashlib.sha256()
    basis_checks = 0
    inverse_ratio = P * R_INV % Q
    for index in range(256):
        basis = [0] * 256
        basis[index] = 1
        upstream = invntt_mod_q(basis, UPSTREAM_SCALE)
        candidate = invntt_mod_q(basis, PLANTARD_SCALE)
        assert candidate == [value * inverse_ratio % Q for value in upstream]
        _update_digest(digest, candidate)
        basis_checks += 1

    structured_cases: list[tuple[list[int], list[int]]] = []
    zero = [0] * 256
    one = [0] * 256
    one[0] = 1
    ramp = [i % Q for i in range(256)]
    alternating = [(Q - 1 if i & 1 else 1) for i in range(256)]
    structured_cases.extend(((zero, zero), (one, one), (ramp, alternating)))
    for index in range(256):
        left = [0] * 256
        right = [0] * 256
        left[index] = (17 * index + 1) % Q
        right[255 - index] = (29 * index + 3) % Q
        structured_cases.append((left, right))

    random_polymul_checks = 64
    polymul_cases = structured_cases[:]
    for _ in range(random_polymul_checks):
        polymul_cases.append(
            (
                [rng.randrange(Q) for _ in range(256)],
                [rng.randrange(Q) for _ in range(256)],
            )
        )
    for left, right in polymul_cases:
        candidate = candidate_polymul(left, right)
        expected = negacyclic_schoolbook(left, right)
        assert candidate == expected
        _update_digest(digest, candidate)

    return {
        "status": "PASS",
        "q": Q,
        "montgomery_R": R,
        "plantard_P": P,
        "plantard_reduction_factor": P_INV,
        "inverse_adjustment_P_over_R": ratio,
        "upstream_scale": UPSTREAM_SCALE,
        "upstream_scale_twisted": UPSTREAM_SCALE_TWISTED,
        "plantard_scale": PLANTARD_SCALE,
        "plantard_scale_twisted": PLANTARD_SCALE_TWISTED,
        "mve_signed16_exhaustive": 1 << 16,
        "upstream_lane_min": upstream_min,
        "upstream_lane_max": upstream_max,
        "candidate_lane_min": candidate_min,
        "candidate_lane_max": candidate_max,
        "plantard_signed16_exhaustive": 1 << 16,
        "plantard_centered_product_pairs_exhaustive": centered_product_checks,
        "plantard_accumulator_abs_limit": accumulator_limit,
        "plantard_accumulator_boundaries": len(boundaries),
        "plantard_accumulator_random": random_i32_checks,
        "rev4_involution_coefficients": 256,
        "inverse_basis_vectors": basis_checks,
        "polymul_structured_cases": len(structured_cases),
        "polymul_random_cases": random_polymul_checks,
        "oracle_sha256": digest.hexdigest().upper(),
    }


def main() -> None:
    print(json.dumps(run_all(), indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
