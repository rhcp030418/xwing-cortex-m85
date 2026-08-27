# 사전등록 — 실험 BS (K21): matrix-XOF x4 배칭 재판정

> 작성 2026-08-26, **측정 전**. 장부 ID **K21**.
> 과거 "AC x4 Keccak 통합 실패"는 **다른 baseline**(X06/X02/X01/K31 채택 이전)에서의 판정이다.
> 그 gate 를 되살리지 않는다 — **새 사전등록·새 임계값**이다(규칙 3).

---

## 1. 무엇이 이미 있는가

`mlkem/matacc.c` 에 **런타임 토글 `mlkem_keccakx4_mode`** 와 x4 경로가 이미 있다.

```c
void matacc_cache32(...) {
  if (mlkem_keccakx4_mode != 0u) { matacc_cache32_x4(...); return; }
  ...
}
```

x4 경로(`xof_batch3`)는 **4-way SHAKE128 로 흡수하고 첫 블록을 한꺼번에 압출**한 뒤
각 상태를 개별 `xof_state` 로 복사한다. ML-KEM-768 은 행당 3개만 필요하므로
**4번째 lane 은 dummy** 다(장부 위험란의 "dummy·pack" 문제).

**따라서 이 실험은 새 커널을 만드는 것이 아니라 기존 경로를 현행 baseline 에서 재판정한다.**

## 2. 분모 (실측)

| | 값 | 근거 |
|---|---:|---|
| permutation 단가 | 5,505.81 cyc | expBJ §1 |
| 연산당 permutation | keygen 43 / encaps 44 / decaps 44 | expAO 하네스 |
| Keccak 블록 | 237.9 ~ 254.5 kcyc = **평균 29.0%** | expAO |
| 그중 matrix-XOF absorb | 11.4 kcyc (9회) | expAQ |
| 그중 matrix-XOF squeeze | 28.7 kcyc (28회) | expAQ |

x4 가 칠 수 있는 것은 **absorb 9회와 초기 squeeze 9회**다.
나머지 19회 squeeze 는 rejection 재충전이라 asm 안에서 순차로 일어나며 x4 밖이다.

```
표적 = absorb 11.4k + 초기 squeeze 9/28 x 28.7k = 11.4k + 9.2k = 20.6 kcyc / 연산
     keygen 3.32% / encaps 2.11% / decaps 2.62%   (평균 2.68%)
```

x4 가 그 20.6 k 를 **완벽히 4-way 로 겹쳐도** 3개만 쓰므로 이론 상한은 2/3 절감,
즉 **평균 1.79%** 다. dummy lane·pack·복사 비용이 그것을 깎는다.

## 3. 사전 고정 kill gate

- **BS-1: full X-Wing 세 연산 중 하나라도 회귀하면 채택 금지.**
- **BS-2: 세 연산 중 최소 두 곳에서 ≥ 0.50% 개선.**

둘 다 넘어야 채택한다. 못 넘으면 **K21 의 "기존 x4 경로" 접근을 종료한다.**
(K20 = MVE 2-way permutation 자체를 새로 쓰는 것은 별개 가족으로 남는다.)

## 4. 정확성 (전부 필수)

- full X-Wing 8-seed 바이트 동일 + 암묵적 거부 동일
- FIPS 203 ML-KEM KAT, `harness_fails = 0`
- **x4 경로는 dummy lane 을 쓰므로 행 인덱스 (i,j) 매핑이 정확해야 한다** — 8-seed 동일성이 방어선이다.

## 5. 위험

1. x4 상태 복사(`memcpy(states[j].ctx, batch.ctx[j], 200)`)가 3회 발생한다.
   K31 채택으로 워드 복사이지만 여전히 비용이다.
2. dummy lane 이 25% 를 버린다.
3. 이 경로는 `matacc_cache32`/`matacc_opt32` 양쪽에 있다 — 둘 다 켜진다.

## 6. 바꾸지 않는 것

SHAKE128 정의, matacc 알고리즘, rejection sampling, ML-KEM/X-Wing 정의,
현행 채택본(X06/X01/X02/K31).
