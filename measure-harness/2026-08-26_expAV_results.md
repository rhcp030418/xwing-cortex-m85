# 실험 AV 결과 — native-ABI fixed-base X25519: **gate PASS (+26.80%)**

> 측정 2026-08-26. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, ABBA, 독립 flash/run 2회.
> 사전등록: `2026-08-26_expAV_x06_native_prereg.md` (측정 전 작성, gate 25% 고정).
> 선행: AT-0/AT-1 통과, **AT-2 gate FAIL(+13.30%)**.

---

## 1. 판정

| 항목 | 결과 |
|---|---|
| 정확성 (RFC 7748 KAT 2종 + base 대 ladder 68종) | **PASS**, mismatch 0 |
| 성능 절감 (fixed-base 단독) | **+26.80%** (357,445 → 261,647) |
| 사전등록 AV gate (**≥25%**) | **PASS** |
| 상수시간 | median delta run1 +4 / run2 0, **두 분포 겹침·최솟값 동일** → §5 |

두 run이 절감률 소수 둘째 자리까지 동일했다(+26.80%).

### 1.1 AT-2 대비

| | AT-2 | AV | 차 |
|---|---:|---:|---:|
| scalarmult | 309,897 | **261,647** | −48,250 |
| 절감률 | +13.30% | **+26.80%** | +13.5%p |

## 2. 무엇을 바꿨나 — 두 가지뿐

사전등록 §2 그대로다. 알고리즘·표·comb 파라미터는 손대지 않았다.

### 2.1 madd를 native ABI asm 루프로 (`gen/x25519_comb_asm.S`)

AAPCS 래퍼(`*_lenn`)를 거치지 않고 Lenngren 함수를 원래 규약(`fe25519_mul`은
`*r1,*r2`, `add/sub`는 `*r8,*r9`)으로 직접 호출한다. 중간값 8개는 자기 스택 프레임에
둔다.

```
madd  148,295 -> 104,418  (−43,877)
```

사전등록 목표 ~105,000과 **0.6% 이내로 일치**한다.

### 2.2 select를 AT-0의 chunked 커널로 되돌리고 부호를 madd 인자 순서로 흡수

```c
for (c = 0; c < 24u; c += 4u) {          /* 4 word 를 레지스터에 누산 */
    uint32_t a0=0,a1=0,a2=0,a3=0;
    for (j = 0; j < 4u; j++) { ... a0 |= m & e[0]; ... }
    sel[c] = a0; ...                      /* 한 번만 store */
}
```

부호는 `pa`/`pb` 포인터의 상수시간 cmov로 흡수한다(표 조회는 그대로).

```
select  129,555 -> 114,743  (−14,812)
```

## 3. 단계별 귀속 (prof 빌드, total 274,647 — 두 run 최대 1 cyc 차)

| 단계 | AV | AT-2 | 차 |
|---|---:|---:|---:|
| 표 select | 114,743 (41.8%) | 129,555 | −14,812 |
| madd | 104,418 (38.0%) | 148,295 | −43,877 |
| inversion + 변환 | 39,792 (14.5%) | 39,614 | +178 |
| recode | 1,286 (0.5%) | 1,164 | +122 |
| 미귀속 | 14,408 (5.2%) | 8,905 | +5,503 |

prof 분기 때문에 B가 261,647 → 274,647(+13,000)로 늘어난 값이다.

**남은 가장 큰 항목은 select 114,743이다.** AT-0의 순수 커널 투영은 86 × 948 = 81,543
이므로 아직 **+33,200**이 붙어 있다 — 조건부 negate(`fe25519_sub_lenn` 86회, 래퍼 포함
~85 cyc = 7,310), 8-word cmov 루프, `ct_eq` 4회/청크, 루프 오버헤드다. 다음 개선 여지다.

## 4. X-Wing 기준 영향 (투영 — AT-3 미실행)

적용 지점은 keygen `pkX`와 encaps `ctX` 둘뿐이다.

| 연산 | 현재 X-Wing | 적용 후(투영) | 절감 |
|---|---:|---:|---:|
| keygen | 762,072 | 666,274 | **−12.57%** |
| encaps | 1,134,709 | 1,038,911 | **−8.44%** |
| decaps | 810,087 | 810,087 | 0% |

**AT-3(wrapper 실제 교체 후 full X-Wing A/B)은 아직 하지 않았다.** 위 값은 투영이며
X-Wing 대표값으로 인용하지 않는다.

## 5. 상수시간 — 사전등록 §5.3 항목의 처리

사전등록은 "스칼라 all-zero / all-ones에서 cycle 차 **정확히 0**"을 요구했다.

| run | A delta | B delta |
|---|---:|---:|
| 1 | 0 | **+4** |
| 2 | 0 | **0** |

median delta가 **재현되지 않는다**. 분포를 보면 이유가 분명하다.

| | min | median | max |
|---|---:|---:|---:|
| B all-zero | 261,385 | 261,389 | 261,688 |
| B all-ones | 261,385~261,393 | 261,389~261,393 | 261,667~261,671 |

**두 분포가 겹치고 최솟값이 같다.** 0~4 cyc의 median 차는 run 간 잡음이다.
코드 검토로도 데이터 의존 분기가 없다(recode는 `(v+3)>>3`, select는 항상 4 엔트리 훑음,
부호는 마스크·포인터 cmov, digit 0 윈도도 madd를 건너뛰지 않음).

> **정직한 처리**: 사전등록 문구("median 차 정확히 0")는 **run1에서 충족되지 않았다.**
> 다만 그 문구가 겨냥한 질문(데이터 의존 타이밍 차가 있는가)에는 **분포 겹침과 동일한
> 최솟값**이라는 부정 증거가 있다. 이것을 "상수시간 증명"으로 부르지 않는다 — DWT
> median 비교는 그런 증명이 아니다. 앞으로의 사전등록에서는 판정 기준을 median 동일이
> 아니라 **분포 겹침**으로 쓰는 것이 맞다.
>
> AT-2에서 미해결로 남겼던 +6 cyc도 같은 성질(잡음)이었음이 이로써 설명된다.

## 6. 구현 과정에서 잡은 버그 3건 — 정직 기록

### 6.1 `ge_madd_native`가 r4–r11을 보존하지 않았다 (LOCKUP)

`fe25519_mul/add/sub`는 r4–r11을 전부 clobber한다. `ge_madd_native`는 **C에서 호출되므로
AAPCS대로 callee-saved를 보존해야** 하는데 `push {lr}`만 했다. 호출자
`curve25519_scalarmult_base`의 루프 카운터·포인터가 파괴돼 CPU가 **LOCKUP**(PC=0xEFFFFFFE,
이중 fault)에 빠졌다. `push {r4-r11, lr}` / `pop {r4-r11, pc}`로 수정.

`*_lenn` 래퍼들이 이미 `push {r4-r11,lr}`을 하고 있었기 때문에 AT-2에서는 드러나지 않았다.

진단 경로: harvester timeout → `diagnose_ra8m1_fault.py`로 PC=0xEFFFFFFE 확인 →
`uart_puts` 마커로 첫 `curve25519_scalarmult_base` 안임을 확정 → asm 본문을 비운
빌드에서 정상 완주(결과만 오답) → 본문이 원인임을 확정.

### 6.2 GCC가 select를 MVE로 자동 벡터화해 UNALIGNED UsageFault

사전등록 §2.2는 이 경로가 **MVE를 쓰지 않는다**(+nomve 이식성)고 못박았는데, GCC가
comb_select의 word 루프를 자동 벡터화했다(objdump가 `stc`로 오독한 것이 MVE `vstrw`).
CFSR=0x01000000(UNALIGNED)로 죽었다. 파일 단위로 벡터화를 껐다.

```c
#pragma GCC optimize ("O2", "no-tree-vectorize")
```

### 6.3 `#pragma GCC optimize` 첫 판이 최적화 수준을 되돌렸다

처음에 `#pragma GCC optimize ("no-tree-vectorize")`만 썼더니 GCC가 해당 파일을 사실상
-O0으로 컴파일해 하네스가 timeout(정지 PC가 `fe_invert`의 254회 sqr 루프 안)이 났다.
`("O2", "no-tree-vectorize")`로 수준을 명시해 해결.

### 6.4 부수 발견 — AT-2의 select 129,555는 MVE 값이었다

§6.2를 끄고 나서 select가 189,788로 **악화**했다. 즉 AT-2의 129,555는 GCC가 몰래 MVE로
벡터화한 결과였고, 벡터화를 끈 뒤의 순수 scalar naive 커널은 그보다 훨씬 느리다.
AT-0이 이미 측정해 둔 대로(naive 18.8 vs chunked 9.4 cyc/word) **chunked 형태**로
다시 쓰자 114,743이 됐다. **AT-0의 커널 형태 선택이 실제로 결정적이었다.**

## 7. 미측정·한계

1. **AT-3 미실행** — X-Wing wrapper의 keygen `pkX` / encaps `ctX`를 실제로 교체한
   full A/B는 하지 않았다. §4는 투영이다.
2. select에 아직 붙어 있는 **+33,200 cyc**(§3)의 세부는 미측정이다.
3. inversion 39,792는 여전히 `*_lenn` 래퍼 경유다(265 호출). native화하면 ~9 kcyc
   여지가 있으나 미측정.
4. 상수시간은 §5대로 **분포 겹침**까지만 확인했다. 형식 검증이 아니다.
5. 표는 flash 상주, `.text` +36,304 B(표 33,024 포함). ITCM 예산은 건드리지 않았다.
6. EK-RA8M1 한 개체, 이 배치 한정.

## 8. 아티팩트

동결: `artifacts/2026-08-26_expAV/` (+ `SHA256SUMS.txt`)

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` | `2D3F514B33A59BBE4D0490B1B5401ED745ABA12F09C16EBB71CF66C035D423BE` |
| `blinky.srec` | `43E349A8410964F5B63601A462C9E084D9A0C17F412EF5EEFC79A7734C43C37B` |
| `blinky.map` | `273B87ABEED8A9BFC326E206E5B3DBC7123AF76F87918872A7E89898C6015519` |
| `x25519_base.c` | `96CC8CF3C671B8C41C1B86EB414ADB211C8AB8C22BA22D6F0F2F714A9F151FD2` |
| `x25519_base.h` | `1A0532909B43B7C6D8E0B6D40092C24EFCC4BBAEC135E04192D5438A8B0638FD` |
| `x25519_comb_asm.S` (native madd) | `46B6902D7B8AC28EE424BE3704B4AB058E865C004C2871313C9957F45790A27F` |
| `x25519_base_shim.S` | `6AA9A53D7ECDFF6386BB36BF8307D9BF48E88A2F35256B699B27452E835ECA1B` |
| `expAU_slots.inc` | `C3F8333FB50D99F87E5A9F07F63EE25CE86E41F059FA22A854E82FFA6CD73C7A` |
| `harvest_ra8m1_expAU.py` | `567841FF6CC81FC1CDFDDF4D0177EF3F81D702F293B47F04570884E183ECF36B` |
| code-flash readback (run1=run2) | `15A6C79639F06DF3ED28EC356B5A6ADFD9E82FC79E014BE2E898869A215229FF` (756,472 B) |
| `logs/2026-08-26_expAV_final_run1.txt` | `A401CC19F27C88A05835DDBCB927EBC82EFD332447BFE3C353ED5025F171F571` |
| `logs/2026-08-26_expAV_final_run2.txt` | `23ABE75563D74F51F68CFAEF784AE066B7D530BBD83F975BCA7A016B952FF960` |

표·생성기는 AT-1 동결본 그대로: `expAT-src/at1_comb.py`, `expAT-src/x25519_base_table.h`.

## 9. 다음 — AT-3

1. X-Wing wrapper의 `xwing_keypair` `pkX`와 `xwing_enc` `ctX`를
   `curve25519_scalarmult_base`로 교체 (variable-base 두 곳은 그대로)
2. 같은 ELF에서 full X-Wing keygen/encaps/decaps ABBA
3. gate(사전등록 §5.1 AT-3 계승): keygen·encaps 중 하나라도 회귀하면 채택 금지,
   decaps는 적용 지점이 없으므로 ±0.3% 이내
4. X-Wing 8-seed full-output + implicit rejection 유지
