# 사전등록 — 실험 AT (X06): basepoint 9 전용 fixed-base X25519

> 작성 2026-08-25. 장부 ID **X06 / E8**. 선행 실측: expAN·AO·AP·AQ·AR·AS.
> 측정 전에 작성했으며, 아래 수치 중 **투영**과 **실측**을 명시적으로 구분한다.
>
> **【AT-0 실행 후 정정 2건 — 원문은 보존하고 아래를 우선한다】**
> 1. **§4의 회계 오류**: "최종 inversion + 변환은 현행 ladder에도 이미 포함돼 있으므로
>    차분에서 상쇄된다"는 **틀렸다**. 새 구현도 inversion이 필요하므로 신규 합계에
>    **더해야 한다**. 정정 회계는 `2026-08-25_expAT0_results.md` §4.
> 2. **§5.1의 MVE 가설 기각**: "MVE가 6~8배 빠를 것"으로 썼으나 실측은 **잘 짠 scalar
>    커널과 동률**이다(둘 다 ≈9.4 cyc/word). X06은 MVE를 쓰지 않는다.
>
> AT-0 판정: **gate PASS**, 최적 w=3, 투영 절감 **−45.9%**. 결과는
> `2026-08-25_expAT0_results.md`.

---

## 1. 왜 이것이 1순위인가 — 실측 근거

expAN이 현행 코드가 basepoint 9 곱셈과 임의점 곱셈에 **같은 `curve25519_scalarmult`**를
쓴다는 것을 실측으로 확인했다.

| 호출 | 종류 | cycles (expAN) |
|---|---|---:|
| keygen `pkX` | fixed-base | 357,839 |
| encaps `ctX` | fixed-base | 357,824 |
| encaps `ssX` | variable-base | 357,324 |
| decaps `ssX` | variable-base | 357,478 |

fixed/variable 차이가 **약 400 cyc(0.1%)뿐**이다 — 고정기저 전용 경로가 없다.

**적용 분모 = 715,663 cyc** (keygen 357,839 + encaps ctX 357,824)
= keygen의 **47.0%**, encaps의 **31.5%**.

## 2. 현행 비용의 실측 분해 (expAR + expAS)

scalarmult 1회 = 357,839 cyc:

| field op | 호출 수 (실측) | cyc/call (실측) | 합 | 비중 |
|---|---:|---:|---:|---:|
| `fe25519_mul` | 1,287 | 115.005 | 148,011 | 41.4% |
| `fe25519_sqr` | 1,274 | 100.006 | 127,408 | 35.6% |
| `fe25519_add` | 765 | 30.005 | 22,954 | 6.4% |
| `fe25519_sub` | 1,020 | 36.002 | 36,722 | 10.3% |
| 잔여 (cswap·비트루프·직렬화·inversion 글루) | — | — | 22,744 | 6.4% |

이 단가들이 아래 투영의 입력이다. **단가는 실측이고 아래 연산 수는 문헌 기준 가정이다.**

## 3. 방식 — Edwards fixed-base comb 후 birational map

X25519의 고정기저 u=9는 Ed25519 base point에 대응한다. 표준 경로는

1. clamp된 스칼라로 **Ed25519 fixed-base scalar multiplication** (precomputed comb)
2. 결과를 Montgomery u로 변환: `u = (1+y)/(1-y)` (inversion 1회 + mul 1회)

libsodium `crypto_scalarmult_base`가 같은 구조(`ge25519_scalarmult_base` →
`edwards_to_montgomery`)를 쓴다. RFC 7748의 출력 정의는 바뀌지 않는다.

### 3.1 연산 수 가정 (문헌, 구현 시 재확인 대상)

extended coordinates, a = −1:

- mixed addition `madd-2008-hwcd-3`: **7M + 7add**
- doubling `dbl-2008-hwcd`: **4M + 4S**

출처: Hisil–Wong–Carter–Dawson 2008 (Explicit-Formulas Database).
**구현 착수 시 EFD에서 다시 세어 확인한다. 지금은 가정이다.**

## 4. 산술 부분 투영 — 실측 단가 × 가정 연산 수

signed w-bit comb, n = ⌈255/w⌉ 윈도, 윈도마다 2^(w−1) 엔트리, 엔트리 96 B
(`y−x`, `y+x`, `2dxy` 각 32 B).

| w | n | mixed add | mul | add | 산술 cycles | 표 크기 |
|---:|---:|---:|---:|---:|---:|---:|
| 2 | 128 | 128 | 896 | 896 | **129,929** | 24,576 B |
| 3 | 85 | 85 | 595 | 595 | **86,281** | 32,640 B |
| 4 | 64 | 64 | 448 | 448 | **64,964** | 49,152 B |
| 5 | 51 | 51 | 357 | 357 | **51,769** | 78,336 B |

최종 inversion + 변환 ≈ 254 sqr + 11 mul ≈ **26,667 cyc**인데 **현행 ladder에도 이미
포함**돼 있으므로 차분에서 상쇄된다.

## 5. ★ 최대 불확실성 — constant-time 표 조회 비용

**산술만 보면 안 된다.** 비밀 스칼라로 표를 인덱싱하므로 매 윈도마다 **모든 엔트리를
훑는 constant-time select**가 필요하고, 이것이 산술과 맞먹을 수 있다.

훑는 총 바이트 = n × 2^(w−1) × 96:

| w | 훑는 바이트 | 32-bit word 수 | scalar 추정 (~4 cyc/word) | MVE 가설 (~6–8× 감소) |
|---:|---:|---:|---:|---:|
| 2 | 24,576 | 6,144 | ~24,600 | ~3,100–4,100 |
| 3 | 32,640 | 8,160 | ~32,600 | ~4,100–5,400 |
| 4 | 49,152 | 12,288 | **~49,200** | ~6,200–8,200 |
| 5 | 78,336 | 19,584 | ~78,300 | ~9,800–13,100 |

**w=4에서 scalar 조회 비용(~49k)이 산술(~65k)과 같은 자릿수다.** w를 키우면 산술은 줄고
조회는 늘어 최적점이 생긴다. 이 값은 **추정이며 반드시 먼저 실측해야 한다.**

### 5.1 MVE가 여기서는 유효할 수 있다

AM1/AM1b는 **field arithmetic**에서 MVE를 기각했다(4-lane 64-bit 누산 구조 불일치,
표현 변환 왕복 1,921 cyc). 그러나 표 조회는 완전히 다른 워크로드다 — 64-bit 누산도,
radix 변환도, carry chain도 없다. 순수 load + select이며 `vldrw`/`vpsel`이 16 B/명령을
처리한다. **AM1/AM1b의 기각은 이 후보에 적용되지 않는다.** 이 구분을 근거 없이
"MVE는 X25519에서 안 된다"로 뭉뚱그리지 않는다.

## 6. 자원 예산 — 실측

| | 값 | 판정 |
|---|---:|---|
| FLASH 총량 | 2,064,384 B | |
| 현재 사용 | 727,464 B | |
| **여유** | **1,336,920 B** | w=5의 78 KB도 여유 |
| ITCM 총량 | 65,536 B | |
| 현재 `__itcm_from_flash$$Limit` | 43,200 B | |
| **ITCM 여유** | **22,336 B** | 표는 flash 상주, 코드만 ITCM 후보 |

**표는 flash에 두고 I-cache/D-cache에 맡긴다.** AF/AK의 교훈대로 ITCM 이동은 별도
후보로 분리하며 이번 실험에서 섞지 않는다.

## 7. 단계 — 측정을 먼저 한다

### AT-0 (선행, 필수) — constant-time 표 조회 단가 실측

전체 구현 전에 §5의 추정을 실측으로 바꾼다. 마이크로 슬롯으로 다음을 잰다.

- scalar cmov 방식: 96 B 엔트리 × {2,4,8,16} 후보 중 1개 select
- MVE `vldrw`/`vpsel` 방식: 같은 조건
- 두 방식 모두 상수시간 확인 (인덱스 0…max에서 cycle 동일)

**이 결과가 w를 결정한다.** AT-0 없이 w를 고르지 않는다.

### AT-1 — 표 생성기와 KAT

호스트에서 comb 표를 생성하고, C 참조 구현으로 RFC 7748 KAT와 8-seed
`scalarmult_base(k) == scalarmult(k, basepoint9)` 차분을 통과시킨다.
**보드에 올리기 전에 통과해야 한다.**

### AT-2 — 보드 실측 A/B

현행 `curve25519_scalarmult(·, k, basepoint)` 대 신규 `curve25519_scalarmult_base(·, k)`를
같은 ELF에서 ABBA로 잰다. 적용 지점은 keygen `pkX`와 encaps `ctX` **둘뿐**이며
variable-base 두 곳에는 적용하지 않는다.

### AT-3 — full X-Wing 통합 판정

## 8. 사전 고정 kill gate

### 8.1 진행 임계값 (측정 전 고정)

- **AT-0**: MVE 또는 scalar 조회 중 하나가 (조회 + 산술) 합계 기준으로 현행 357,839 cyc
  대비 **30% 이상** 절감 투영을 만들지 못하면 AT-1로 가지 않는다.
  (30%는 §4+§5의 가장 비관적 조합인 w=2 scalar(129,929 + 24,600 = 154,529 = −56.8%)조차
  넉넉히 넘으므로, 이 gate를 못 넘으면 §3의 전제 자체가 틀린 것이다.)
- **AT-2**: fixed-base 단독 scalarmult가 현행 대비 **25% 이상** 절감하지 못하면 종료.
- **AT-3**: full X-Wing keygen·encaps 중 **하나라도 회귀**하면 채택하지 않는다.
  decaps는 적용 지점이 없으므로 **±0.3% 이내**여야 한다(넘으면 배치 교란을 의심한다).

### 8.2 정확성 (전부 필수)

- RFC 7748 §6.1 KAT 4종
- `scalarmult_base(k)` == `scalarmult(k, basepoint9)` — 무작위 1,000 seed 차분
- clamp 경계: `k` 전 비트 0 / 전 비트 1 / bit254만 / low-3 clear 확인
- X-Wing 8-seed full-output + implicit rejection
- 기존 전체 하네스 KAT·mismatch 0

### 8.3 상수시간

- 표 조회가 **모든 엔트리를 훑는지** 코드 검토 + 인덱스별 cycle 동일 실측
- 비밀 의존 branch·주소·table index 금지 — comb digit은 비밀이다
- signed digit 처리의 부호 select도 constant-time (조건부 negate)
- `ct-delta` 슬롯으로 인덱스 최소/최대에서 cycle 차 0 확인

### 8.4 자원

- `.text` 증가량, 표 크기, ITCM working set, stack high-water 보고
- **표를 ITCM에 넣지 않는다**(이번 실험에서는). 넣는 변형은 별도 후보.
- 코드 배치 교란 통제: 비처리 코드의 의도치 않은 이동은 통제하고, 표 추가로 인한
  의도된 flash 증가는 효과로 함께 보고한다.

## 9. 상한 회계

절감은 적용 분모를 넘을 수 없다.

| | 최대 절감 | X-Wing 기준 |
|---|---:|---:|
| keygen `pkX` | < 357,839 | < 47.0% |
| encaps `ctX` | < 357,824 | < 31.5% |
| decaps | 0 | 0% (적용 지점 없음) |

§4+§5의 w=4 MVE 조합 투영(64,964 + ~7,000 ≈ 72,000)이 맞다면 절감은
scalarmult당 약 285,800 cyc이고, **keygen −37.5% / encaps −25.2%**다.
이는 **투영이며 실측이 아니다.** AT-2 전까지 어떤 문서에도 절감률로 쓰지 않는다.

## 10. 이 실험이 바꾸지 않는 것

- RFC 7748 X25519의 입출력 정의
- variable-base scalarmult (encaps `ssX`, decaps `ssX`) — 손대지 않는다
- X-Wing combiner, ML-KEM 경로
- legacy wrapper의 draft-10 비준거 상태 (§4.1.1) — 별도 트랙

## 11. 근거

- [RFC 7748 X25519](https://www.rfc-editor.org/rfc/rfc7748.html)
- [How to (pre-)compute a ladder, eprint 2017/264](https://eprint.iacr.org/2017/264.pdf)
- Hisil–Wong–Carter–Dawson 2008, Explicit-Formulas Database (extended coordinates, a=−1)
- `measure-harness/2026-08-25_expAN_results.md` — 적용 분모 715,663 cyc
- `measure-harness/2026-08-25_expAR_results.md` — mul/sqr 단가·호출 수
- `measure-harness/2026-08-25_expAS_results.md` — add/sub 단가·호출 수
- `measure-harness/2026-08-25_expAM1_results.md`, `..._expAM1b_results.md` — MVE field
  arithmetic 기각(이 후보의 표 조회에는 적용되지 않음, §5.1)
