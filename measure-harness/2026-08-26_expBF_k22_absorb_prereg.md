# 사전등록 — 실험 BF (K22): matrix-XOF absorb 상태 캐시

> 작성 2026-08-26, **측정 전**. 장부 ID **K22**(incremental SHAKE state 를 caller 에 유지).
> 선행: expAQ(absorb 11.4 kcyc = 9회 × 1,240), expAO(Keccak 분해), expBE(K19 종료).

---

## 1. 분모와 구조

expAQ 실측: matacc 의 `kyber_shake128_absorb` 가 **연산당 9회, 총 11.4 kcyc**
(호출당 ≈1,240 cyc, permutation 은 여기 포함되지 않는다 — 순수 배관이다).

현재 구현 경로:

```
kyber_shake128_absorb(state, seed, x, y)
  extseed = seed(32) || x || y              memcpy 32B
  shake128_absorb(state, extseed, 34)
    state->ctx[0..24] = 0                    200 B 영점화
    keccak_absorb(..., mlen=34, p=0x1F)
      KeccakF1600_StateXORBytes(s, m, 0, 34)   ← 34 B **비트-인터리브 변환** XOR
      KeccakF1600_StateXORBytes(s, &0x1F, 34, 1)
      KeccakF1600_StateXORBytes(s, &0x80, 167, 1)
```

1,240 cyc 의 대부분은 **200 B 영점화 + 34 B 비트-인터리브 XOR** 이다.

## 2. 착안 — seed 32 B 가 9회 모두 같다

한 연산(keygen/encaps/decaps) 안에서 matacc 는 **같은 공개 seed ρ** 로 9번 absorb 한다.
달라지는 것은 **바이트 32, 33 (x, y) 둘뿐**이며 padding 위치(34, 167)도 고정이다.

따라서 `seed || 0 || 0` 을 흡수하고 padding 까지 넣은 **200 B 상태를 한 번만 만들어
캐시**하고, 매 호출은

```
memcpy(state->ctx, cache, 200)                  /* 25 x 8 B */
KeccakF1600_StateXORBytes(state->ctx, &x, 32, 1)
KeccakF1600_StateXORBytes(state->ctx, &y, 33, 1)
```

로 끝난다. **비트-인터리브 변환 대상이 34 B → 2 B 로 줄고 영점화가 사라진다.**

캐시 무효화는 seed 32 B 비교(워드 8회)로 판단한다.

## 3. 보안 — seed 는 공개값이다

matrix seed ρ 는 **encapsulation key 의 일부로 전송되는 공개값**이다(FIPS 203).
따라서 캐시 적중/미적중이 만드는 타이밍 차는 **공개 입력에 대한 것이며 비밀 누출이
아니다.** 이는 rejection sampling 이 공개 seed 에 따라 변동하는 것과 같은 성질이며,
장부 §11.2 의 "공개 seed 기반 변동과 비밀 의존 동작을 구분한다"에 해당한다.

**비밀값(z, m, 노이즈 seed)은 이 경로를 타지 않는다** — 그쪽은 `kyber_shake256_prf` 다.
이 실험은 `kyber_shake128_absorb` 만 건드린다.

## 4. 사전 고정 kill gate

### 4.1 성능

- **BF gate: `kyber_shake128_absorb` 단가가 50% 이상 줄어야 한다.**
  (1,240 → 620 이하. memcpy 200 B + 2 B XOR 이 그보다 훨씬 싸야 정상이며,
  못 넘으면 비용 구조 가정이 틀린 것이므로 종료한다.)
- full X-Wing 세 연산 중 **하나라도 회귀하면 채택 금지.**

### 4.2 정확성 (전부 필수)

- 캐시본 대 원본: 무작위 200 seed × (x,y) 전 조합 일부에서 **absorb 후 state 200 B
  완전 일치**
- FIPS 203 ML-KEM KAT, full X-Wing 8-seed 바이트 동일 + 암묵적 거부 동일
- 기존 전체 하네스 KAT·mismatch 0
- **seed 가 바뀌는 경우**를 반드시 시험한다(캐시 무효화 경로)

### 4.3 자원

- 캐시 200 B + seed 32 B = 232 B 정적 버퍼. RAM 증가 보고.
- `.text` 변화 보고.

## 5. 위험

1. `xof_state` 가 `shake128ctx`(25 × uint64)와 정확히 같은 레이아웃이어야 한다.
2. 캐시가 **함수 재진입/중첩**에 안전해야 한다. 현재 matacc 는 단일 스레드 순차
   호출이지만, `matacc_*_x4` 경로(`mlkem_keccakx4_mode`)는 4개 상태를 동시에 다룬다 —
   그 경로에서도 absorb 는 순차이므로 문제없지만 **확인이 필요하다.**
3. 캐시 hit 판정이 틀리면 조용히 오답이 난다 → §4.2 의 seed 변경 시험이 방어선이다.
4. 캐시를 static 으로 두면 **비밀이 아닌 값만** 담긴다(§3). zeroization 대상 아님.

## 6. 바꾸지 않는 것

SHAKE128 정의, matacc 알고리즘, rejection sampling, ML-KEM 경로, X-Wing 정의.
`kyber_shake256_prf`(비밀 경로)는 손대지 않는다.
