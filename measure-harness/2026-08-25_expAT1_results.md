# 실험 AT-1 결과 — comb 표 생성기와 정확성 게이트 (호스트)

> 2026-08-25 (심야, 날짜 경계 넘김). 사전등록:
> `2026-08-25_expAT_x06_fixedbase_prereg.md` §7 AT-1. 선행: AT-0.
> 산출물: `expAT-src/at1_comb.py`, `expAT-src/x25519_base_table.h`

---

## 1. 판정 요약

| 게이트 | 결과 |
|---|---|
| RFC 7748 §6.1 KAT (alice·bob public key) | **PASS** |
| 1,000 seed 차분 (comb vs 독립 Montgomery ladder) | **mismatch 0** |
| clamp 경계 4종 (all-zero / all-one / bit254-only / low3-set) | **PASS** |
| 사전등록 §3.1 "madd = 7M + 7add" 가정 | **계수로 확인** |

**보드 단계(AT-2)로 진행한다.**

## 2. 파라미터 확정 — 85가 아니라 86 윈도다

AT-0은 w=3에서 `⌈255/3⌉ = 85` 윈도로 계산했다. 실제 구현에서 **86 윈도**가 필요하다.

signed radix-8 recoding은 자릿수 `e_i > 4`일 때 `e_i − 8`로 바꾸고 다음 자리로 carry를
올린다. clamp된 스칼라는 bit 254가 켜져 있어 최상위 자리(bit 252–254)가 4~7이 되므로
**carry를 흡수할 자리가 하나 더 필요하다.** 86 × 3 = 258 ≥ 255이고, 86번째 자리는
0 또는 1만 갖는다. 생성기가 `assert carry == 0`으로 이를 강제한다.

| | AT-0 계산 | AT-1 확정 |
|---|---:|---:|
| 윈도 수 | 85 | **86** |
| 표 크기 | 32,640 B | **33,024 B** |

## 3. 사전등록 가정이 계수로 확인됐다

`madd`(ref10 `ge_madd` + `p1p1_to_p3` 계보)의 field op를 참조 구현에서 직접 셌다.

```
scalarmult_base 1회 (최종 inversion 제외):
  mul = 602    sqr = 0    add = 344    sub = 258
  madd 1회당:  mul = 7.00,  add+sub = 7.00
```

**사전등록 §3.1의 "7M + 7add" 가정이 정확히 맞았다.** 이제 가정이 아니라 계수다.

부수 확인: comb 경로는 **squaring을 한 번도 쓰지 않는다**(sqr=0). 현행 ladder가
1,274회 쓰는 것과 대조된다. 최종 inversion에만 sqr이 들어간다.

## 4. 투영 — 실측 단가 × **실측 호출 수**

expAR/expAS의 실측 단가(mul 115.005 / sqr 100.006 / add 30.005 / sub 36.002)와
위 계수를 곱한다. 표 조회는 AT-0 실측(N=4, 948.17 cyc/select)이다.

| 항목 | cycles | 근거 |
|---|---:|---|
| 산술 (602 mul + 344 add + 258 sub) | 88,843 | 단가 실측 × 호출 수 계수 |
| 표 조회 (86 × 948.17) | 81,543 | AT-0 실측 |
| 최종 inversion + 변환 (254 sqr + 11 mul) | 26,667 | 단가 실측 × 표준 덧셈사슬 |
| **합계** | **197,052** | |
| 현행 ladder | 357,839 | expAN 실측 |
| **절감** | **−44.9%** | |

### 4.1 아직 안 센 것 — 조건부 negate 상한

digit이 음수일 때 precomp를 `(ypx, ymx, −xy2d)`로 바꿔야 한다. 이 비용은 위 투영에
**포함돼 있지 않다.**

- **최선**: 부호 처리를 표 select 루프 안에 접어 넣는다(마스크 몇 개 추가). 거의 무료.
- **최악**: 윈도마다 별도로 96 B를 조건부 swap + 1회 negate.
  상한 = 86 × (948.17/4 + 36.0) ≈ **23,482 cyc**.

| | 합계 | 절감 | X-Wing keygen | X-Wing encaps |
|---|---:|---:|---:|---:|
| 기본 (negate 무료 가정) | 197,052 | **−44.9%** | −21.1% | −14.2% |
| 최악 (별도 pass) | 220,534 | **−38.4%** | −18.0% | −12.1% |

**최악 가정에서도 AT-2 gate(25%)를 넉넉히 넘는다.** 다만 어느 쪽도 실측이 아니다.

### 4.2 그 밖에 안 센 것

- signed digit recode (스칼라 → 86 digit): 정수 연산 86회 수준, 미측정
- 표 인덱스 계산과 루프 오버헤드
- 항등원(digit=0) 처리: `ct_select`가 4 엔트리를 훑고 아무것도 안 맞으면 (1,1,0)을
  남기도록 했다. 실제 asm에서 같은 구조를 유지해야 상수시간이 보존된다.

## 5. 정확성 게이트 상세

### 5.1 RFC 7748 §6.1

```
alice sk 77076d0a...92c2a  ->  pk 8520f009...9b4e6a   OK
bob   sk 5dab087e...88e0eb ->  pk de9edb7d...f882b4f  OK
```

### 5.2 독립 구현 대조

검증용 Montgomery ladder는 comb 코드와 **공유 코드가 없다** — RFC 7748 §5의 의사코드를
그대로 옮긴 별도 함수다. 같은 버그가 양쪽에 동시에 들어갈 경로가 없다.

무작위 32-byte seed 1,000개에서
`enc(edwards_to_u(scalarmult_base(clamp(sk)))) == x25519(sk, basepoint9)` — **mismatch 0**.

### 5.3 clamp 경계

| 입력 | 결과 |
|---|---|
| 전 바이트 0x00 | OK |
| 전 바이트 0xff | OK |
| bit 254만 1 | OK |
| 하위 3비트 1 (clamp가 지워야 함) | OK |

## 6. 상수시간 설계 요구 (AT-2로 이월)

호스트 참조는 `ct_select`가 **항상 4 엔트리를 전부 훑도록** 짰지만, Python이므로
상수시간을 증명하지 않는다. 보드 구현에서 다음을 지켜야 한다.

1. 표 조회는 AT-0에서 검증된 chunked scalar 커널 형태 — 인덱스별 cycle 차 0
2. 부호 처리도 branch 없이 마스크로 (조건부 swap + 조건부 negate)
3. digit이 0인 윈도도 madd를 **건너뛰지 않는다**
4. `ct-delta` 슬롯으로 digit 패턴 최소/최대에서 cycle 차 0 확인

## 7. 산출물

| 파일 | SHA-256 | 크기 |
|---|---|---:|
| `expAT-src/at1_comb.py` | `6DBFA1B8AB49771A876F4A975DCD93594F46F7620DB87DCBCBB9207F2C078420` | 9,758 B |
| `expAT-src/x25519_base_table.h` | `68C05ED4E7719E790517664D21D8B8796CF71718B01098DAEA75C11087FE52CC` | 104,102 B |

표 데이터 자체는 **33,024 B** (86 × 4 × 96). 헤더 소스가 큰 것은 16진 리터럴 때문이다.

생성기는 결정적이다 — 표는 base point와 곡선 상수에서만 나오므로 재실행하면 같은
바이트가 나온다(검증 실패 시 헤더를 아예 쓰지 않는다).

## 8. 한계

1. **호스트 검증이다.** 보드에서의 정확성·상수시간·cycle은 AT-2 대상이다.
2. §4의 합계는 여전히 **투영**이다 — 조회는 AT-0 실측, 산술은 실측 단가 × 실측 계수지만
   보드에서 실제로 그렇게 나오는지는 미측정이다. 절감률로 인용하지 않는다.
3. 조건부 negate·recode 비용 미측정 (§4.1, §4.2).
4. 표를 flash에 두는 전제다(AT-0 §2.3). 배치가 바뀌면 조회 단가가 달라진다.
5. Python 참조는 상수시간이 아니다 — 알고리즘 구조만 검증한다.

## 9. 다음 — AT-2

1. `x25519_base_table.h`를 보드 프로젝트에 넣고 C로 `curve25519_scalarmult_base` 구현
   (표 조회는 AT-0의 chunked scalar 커널, 부호 처리는 select 루프에 접어 넣기)
2. 보드에서 RFC 7748 KAT + `scalarmult_base` vs `scalarmult(k, 9)` 8-seed 차분
3. keygen `pkX` / encaps `ctX` 두 지점만 교체하고 같은 ELF ABBA
4. gate: fixed-base 단독 25% 미만 절감이면 종료
