# 사전등록 — 실험 BG (K22 재도전): absorb 캐시 + **워드 복사**

> 작성 2026-08-26, **측정 전**. 장부 ID **K22**. expBF FAIL 후의 **새 사전등록·새 임계값**이다.
> 규칙 §3-3: 실패한 gate 는 되살리지 않는다. 아래 임계값은 BF 의 것과 다르다.

---

## 1. BF 가 남긴 확정 사실 (실측)

| 조각 | cyc/호출 | cyc/byte |
|---|---:|---:|
| 영점화 200 B (`memset` 계열) | 614.67 | 3.07 |
| `KeccakF1600_StateXORBytes` 34 B | 452.78 | 13.32 |
| **`memcpy` 200 B** | **2,522.75** | **12.61** |
| `KeccakF1600_StateXORBytes` 2 B @32 | 96.77 | — |

BF 의 착안(seed 32 B 가 9회 동일 → 상태를 캐시)은 **비용 구조상 옳았다**(A 경로의 87.4%가
영점화+XOR). 실패는 오직 **libc `memcpy` 가 바이트 루프**라서다.

## 2. 변경점 — 딱 두 줄

BF 구현에서 libc 호출 두 개만 워드 단위로 바꾼다. 알고리즘·캐시 정책·보안 논거(BF §3)는
그대로다.

1. `memcpy(state, &k22_cache, 200)` → **`uint64_t` 25회 복사 루프**
2. `memcmp(k22_cache_seed, seed, 32)` → **`uint32_t` 8회 비교 루프**

`-ftree-loop-distribute-patterns` 가 루프를 다시 `memcpy`/`memcmp` 로 되돌리므로
해당 함수에 `__attribute__((optimize("no-tree-loop-distribute-patterns")))` 를 건다.
**빌드 후 역어셈블로 `bl memcpy` / `bl memcmp` 가 사라졌는지 확인한 뒤 측정한다** (규칙 5).

## 3. 사전 고정 kill gate (**BF 와 다른 값**)

### 3.1 성능 — 셋 다 필요

- **BG-1: `kyber_shake128_absorb` 단가 ≥ 60% 절감** (1,221 → 488 이하).
- **BG-2: full X-Wing 세 연산 중 하나라도 회귀하면 채택 금지.**
- **BG-3: keygen 에서 ≥ 0.50% 개선.**
  (근거: absorb 9회 × 1,221 = 11.0 kcyc, 80% 절감 시 8.8 kcyc, expBC 의 micro→full
  감쇠 70% 를 적용하면 6.2 kcyc = keygen 643 kcyc 의 0.96%. 절반만 실현돼도 넘는 선.)

셋 중 하나라도 못 넘으면 **K22 를 완전히 종료한다.**

### 3.2 정확성 (BF 와 동일, 전부 필수)

- 캐시본 대 원본 state 200 B 완전 일치, **seed 변경(캐시 무효화) 경로 포함**
- FIPS 203 ML-KEM KAT, full X-Wing 8-seed 바이트 동일 + 암묵적 거부 동일
- 기존 전체 하네스 `harness_fails=0`

### 3.3 구현 검증 (측정 전 필수)

- 역어셈블에 `bl memcpy` / `bl memcmp` **없음**
- 진단 슬롯으로 **복사 조각 단가 재측정** — 2,522.75 대비 실제로 내려갔는지 확인

## 4. 위험

1. 컴파일러가 루프를 재-`memcpy` 로 되돌림 → §3.3 이 방어선.
2. `uint64_t` 복사가 M85 에서 `ldrd/strd` 로 안 나오고 두 워드로 쪼개질 수 있다 —
   그래도 바이트 루프보다는 빠르나, **예상치를 결과로 쓰지 않는다.**
3. 절감이 60% 를 넘어도 full 에서 감쇠가 70% 보다 크면 BG-3 에서 걸린다. 그때는 종료다.

## 5. 바꾸지 않는 것

SHAKE128 정의, matacc, rejection sampling, ML-KEM/X-Wing 정의, `kyber_shake256_prf`(비밀 경로).
**libc `memcpy` 자체는 이 실험에서 건드리지 않는다** — 그것은 별도 후보 K31 이다.
