# 실험 DC 결과 — Lenngren y1 기반 종단간 U′

## 결론

U′는 정확했지만 S′보다 세 연산 모두 느렸다. 따라서 U′는 채택하지 않는다.
두 독립 flash의 AB와 BA 순서 모두에서 `U′−S′ > 0`이므로 사전등록한 이득
조건을 한 번도 만족하지 못했다.

| flash | 연산 | AB `U′−S′` | BA `U′−S′` | 판정 |
|---|---|---:|---:|---|
| 1 | keygen | +34,650 cyc (+4.282245%) | +34,686 cyc (+4.286684%) | 악화 |
| 1 | encaps | +69,344 cyc (+5.753046%) | +69,348 cyc (+5.753436%) | 악화 |
| 1 | decaps | +34,620 cyc (+3.941629%) | +34,624 cyc (+3.942121%) | 악화 |
| 2 | keygen | +34,666 cyc (+4.284106%) | +34,726 cyc (+4.291712%) | 악화 |
| 2 | encaps | +69,318 cyc (+5.750880%) | +69,338 cyc (+5.752606%) | 악화 |
| 2 | decaps | +34,636 cyc (+3.943523%) | +34,614 cyc (+3.940955%) | 악화 |

S′와 U′는 모두 동일한 x4 batching 경로를 사용한다. 차이는 Lenngren y1
field-multiply가 b1 Keccak 조각을 수행하는지뿐이다. 값은 DWT CYCCNT,
`REP_N=100` 중앙값이며 빈 측정 25 cycles는 양쪽에 공통이라 차분에는 영향을
주지 않는다.

## 구현·정확성

- expCR의 r11-free Lenngren y1 본문을 실제 X25519 ladder의 모든 field multiply에
  넣었다. 정적 검사에서 y1 scalar 본문의 r11 사용은 0건이다.
- U′는 one-base b1 Keccak-f1600x4 한 round를 8개 연속 field multiply에 균등
  분할했다. 각 경계에서 r11/q7 base를 다시 만들고, callee-saved r11은 저장·복원했다.
- 현 GCC 13.2에서 어셈블·링크 성공: text 660,988 B, data 7,376 B,
  bss 146,952 B.
- 두 최종 flash 모두 RFC 7748 및 SHA3 KAT, SHAKE x4 대 scalar,
  8-seed X-Wing valid/reject, ML-KEM roundtrip/reject를 통과했다.
- 두 flash 모두 `x4-kat-fails=0`, `u-kat-fails=0`, `bytes-mm=0`,
  `smoke-fails=0`, `timing-mm=0`, `stack-fails=0`, `harness_fails=0`.
- stack high-water는 9,208 B였다.

사전 기준선 확인용 별도 flash에서도 기존 expAC staged 빌드가 KAT와 모든
동등성 gate를 통과했다. 이 확인 flash는 위의 두 최종 반복 수에 포함하지 않았다.

## 식별자와 재현물

- ELF SHA-256: `183B89746A9A1748E96639F0324290BC6F421421852513029C11BE1930C29CA9`
- SREC SHA-256: `080BAF51C7872B56BBD9E135FFA4B9C93A34AEEFC0A5B3B262C7AE97DB5AEBBA`
- code-flash readback: 668,348 B, SHA-256
  `2483BF9AFCE93862456472DA4C3FC6C8EEB66B9FF83E9C95F1CA9E88EAF59BE2`
- run 1 log SHA-256:
  `875B068970A3B89BEA8DE1D875BD589A84C65A0F8513CB1F07D248624A6EDECD`
- run 2 log SHA-256:
  `E940D92E8B177B651415BAE1DD84C80EE2DD2C371A065E03EF5A1F3889BA211D`
- 사전등록: `2026-08-28_expDC_lenngren_uprime_prereg.md`
- 생성기: `../slothy-2stream/gen_exp_dc.py`
- 생성 소스: `expDC-src/x25519-cortex-m4-gcc.s`,
  `expDC-src/keccakx4_round_m85.S`
- 최종 로그: `logs/2026-08-28_expDC_run1.txt`,
  `logs/2026-08-28_expDC_run2.txt`

## 남은 미측정

보드는 EK-RA8M1 한 대만 사용했다. 두 번째 보드와 제어 가능한 전원 차단기를
확보하지 못했으므로 보드 간 재현성과 완전 전원 재인가 재현성은 미측정이다.
