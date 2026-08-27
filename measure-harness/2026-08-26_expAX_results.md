# 실험 AX 결과 — X06 잔여 개선: **scalarmult +34.56%, X-Wing keygen −16.11% / encaps −10.83%**

> 측정 2026-08-26. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, 같은 ELF ABBA, 독립 flash/run 2회.
> 사전등록 보정: `2026-08-26_expAX_x06_refine_amendment.md` (측정 전 작성).
> 선행: AV(+26.80%), AW/AT-3(keygen −12.46% / encaps −8.38%).

---

## 1. 판정

| 게이트 | 결과 |
|---|---|
| AV(261,647) 대비 회귀 없음 | **PASS** (233,919, −27,728) |
| 정확성 (RFC 7748 KAT + 68 seed 차분 + full X-Wing 8-seed + 암묵적 거부) | **PASS**, 전부 0 |
| 상수시간 (분포 겹침) | **PASS** |
| keygen·encaps 회귀 없음 / decaps ±0.3% | **PASS** |

## 2. 결과

### 2.1 scalarmult 단독

| | AV | **AX** | 개선 |
|---|---:|---:|---:|
| cycles | 261,647 | **233,919** | −27,728 |
| 현행 ladder(357,448) 대비 | +26.80% | **+34.56%** | +7.76%p |

두 run에서 233,919로 동일했다.

### 2.2 full X-Wing (같은 ELF ABBA)

| 연산 | A 현행 | B X06+AX | conservative 절감 |
|---|---:|---:|---:|
| keygen | 762,026 / 762,024 | **639,278 / 639,290** | **+16.11%** |
| encaps | 1,135,095 / 1,135,105 | **1,012,208 / 1,012,204** | **+10.83%** |
| decaps | 809,723 / 809,721 | 809,704 / 809,711 | ±0.00% (통제) |

| | AW (AV 기반) | **AX** |
|---|---:|---:|
| keygen | −12.46% | **−16.11%** |
| encaps | −8.38% | **−10.83%** |

### 2.3 단계별 귀속 (prof 빌드)

| 단계 | AV | **AX** | 차 |
|---|---:|---:|---:|
| 표 select | 114,743 | **97,559** | **−17,184** |
| madd | 104,418 | 105,108 | +690 |
| inversion + 변환 | 39,792 | **28,376** | **−11,416** |
| recode | 1,286 | 1,278 | −8 |
| 미귀속 | 14,408 | 14,454 | +46 |
| total(prof) | 274,647 | **246,775** | −27,872 |

madd의 +690은 z3/t3 포인터 선택 6명령이 들어간 몫이며, 그 대가로 select에서
17,184를 뺐다.

## 3. 무엇을 바꿨나 — field 연산 수를 줄인 두 가지

### 3.1 조건부 negate 제거 → z3/t3 swap (−17,184)

madd 안에서 `c = xy2d·T`, `z3 = d + c`, `t3 = d − c` 이므로

```
c' = −c   ⟹   z3' = d − c = t3,   t3' = d + c = z3
```

**c의 부호 반전과 z3/t3 맞바꿈이 정확히 같다.** 최종 4곱 중 `Z = z3·t3`는 대칭이고
`T = x3·y3`은 무관하므로 **X와 Y가 쓰는 포인터만** 상수시간으로 바꾸면 된다.

```asm
	ldr	r12, [r12, #140]	/* sign: all-ones or 0 */
	add	r10, sp, #FZ3
	add	r11, sp, #FT3
	eor	r9, r10, r11
	and	r9, r9, r12
	eor	r10, r10, r9		/* pz */
	eor	r11, r11, r9		/* pt */
```

제거된 것: 윈도당 `fe25519_sub_lenn` 1회(래퍼 포함)와 8-word cmov 1회 × 86 윈도.
**field 연산이 하나도 늘지 않았다.**

### 3.2 inversion의 squaring 사슬을 native로 (−11,416)

`fe25519_sqr`는 **입출력이 모두 r0–r7**이다. AV는 AAPCS 래퍼로 254회 불러 매번 8 word를
저장하고 다시 읽었다. 값을 레지스터에 둔 채 n회 도는 asm 루프를 넣었다.

```asm
fe25519_sqr_chain:            /* void (uint32_t r[8], const uint32_t a[8], uint32_t n) */
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp, #0]      /* dst — fe25519_sqr 이 r8-r12 를 clobber 하므로 스택에 */
	str	r2, [sp, #4]      /* n */
	mov	r12, r1
	ldm	r12, {r0-r7}
1:	bl	fe25519_sqr
	ldr	r12, [sp, #4]
	subs	r12, r12, #1
	str	r12, [sp, #4]
	bne	1b
	ldr	r12, [sp, #0]
	stm	r12, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
```

254회 squaring의 중간 store/load가 **전부 사라졌다**. 11회의 mul은 그대로 래퍼를 쓴다.

## 4. 정확성

```
expAU correctness: kat-fails=0 diff-mm=0 checks=70
expAW equiv: bytes-mm=0 smoke-fails=0 reject-mm=0 checks=48
harness_fails=0, KAT ALL PASS
```

- RFC 7748 §6.1 KAT 2종
- clamp 경계 4종 + 무작위 64 seed에서 `scalarmult_base` 대 현행 ladder mismatch 0
- full X-Wing 8-seed: pk/sk/ct/ss_e/ss_d **바이트 동일**, **암묵적 거부 동일**
- 기존 전체 하네스 KAT·mismatch 0

§3.1의 z3/t3 swap이 대수적으로 틀렸다면 KAT이 즉시 깨진다 — 통과가 유도의 검증이다.

상수시간: all-zero 대 all-ones 분포 **겹침**(B low/high 모두 median 233,753,
min 233,747~233,753). delta 0.

## 5. 누적 위치 (파생 수치)

| 기준 | keygen | encaps | decaps |
|---|---:|---:|---:|
| expAL cell-00 | 796,007 | 1,184,040 | 877,484 |
| expAL cell-11 (X/Y/C8+C9) | 761,811 | 1,134,806 | 809,797 |
| **+ X06 (AX)** | **639,278** | **1,012,208** | **809,704** |
| 00 대비 누적 | **−19.69%** | **−14.51%** | **−7.72%** |

> **주의**: 마지막 줄은 서로 다른 ELF의 값을 이어 붙인 **파생 수치**다. 이번 A 셀
> (762,026 / 1,135,095 / 809,723)이 expAL cell-11과 0.03% 이내로 맞아 사슬은 일관되지만,
> **정본으로 쓰려면 같은 ELF에서 00 대 X06 완전요인을 다시 돌려야 한다.**

## 6. 자원

`.text` 750,412 B (AW 750,428 대비 −16 B). 표 33,024 B 불변, ITCM 미사용.

## 7. 미측정·한계

1. **누적 대표값은 §5대로 재측정 대상**이다.
2. select에 아직 **97,559 − 81,543(AT-0 커널 투영) = 약 16,000 cyc**가 남아 있다.
   AT-0의 마이크로 벤치는 표가 1.5 KB라 D-cache에 상주했지만 실제 표는 33 KB를
   윈도마다 새로 훑는다 — **이 차이는 캐시 효과로 보이며 미측정**이다. 표를 줄이면
   (w=2) 조회는 줄지만 madd가 더 늘어 손해다(AT-0 §4).
3. inversion 28,376 중 11회 mul은 여전히 래퍼 경유(소액).
4. 상수시간은 분포 겹침까지만 확인했다(형식 증명 아님).
5. legacy wrapper workload 기준, EK-RA8M1 한 개체, 이 배치 한정.

## 8. 아티팩트

동결: `artifacts/2026-08-26_expAX/` (+ `SHA256SUMS.txt`)

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` | `A319CC5C3B903B4B0EA2FE4014B5FD7C2153179F8D9244A3DE10354A2694FE3D` |
| `blinky.srec` | `9F8FA47078279C01646EDDEAB8E7AF9F407F2A7AC352416822BBF2CD70A93F80` |
| `blinky.map` | `2261E8E6C01D6926891AB971A5E7B66B53954CFDB7EBD11A2233B3B89D0FB8F3` |
| `x25519_base.c` | `274715D027030EB90D79BD9C5C9ED5481D6B29F656FA994E7162398BA7733E2C` |
| `x25519_comb_asm.S` (z3/t3 swap + sqr_chain) | `6184FFEDA047BFA033D9AEDA02B8062DAE9C00AF25C2A4166C3279CBE70F7E6D` |
| `expAW_slots.inc` | `38F62CBCE4CC118E22B6A0F5747C836AF870229FC39A21992C6DBF03ED229D58` |
| `expAU_slots.inc` | `C3F8333FB50D99F87E5A9F07F63EE25CE86E41F059FA22A854E82FFA6CD73C7A` |
| code-flash readback (run1=run2) | `6028ED0B9539C9F81B7C52F41DE876662F6CA847DF4CEF7119CA10ADDE16D059` (757,892 B) |
| `logs/2026-08-26_expAX_au_run{1,2}.txt` | `6E25F11F…6732` / `3B4D424D…F849` |
| `logs/2026-08-26_expAX_aw_run{1,2}.txt` | `AC598FF7…F6F0` / `2F083DEB…4812` |

## 9. X06 트랙 최종 요약

| 단계 | 내용 | scalarmult | X-Wing keygen / encaps |
|---|---|---:|---|
| AT-2 | C + AAPCS 래퍼 | 309,897 (+13.30%) | — (gate FAIL) |
| AV | native ABI madd + chunked select | 261,647 (+26.80%) | −12.46% / −8.38% |
| **AX** | **z3/t3 swap + native sqr chain** | **233,919 (+34.56%)** | **−16.11% / −10.83%** |
