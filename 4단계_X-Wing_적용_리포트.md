# 4단계 X-Wing 적용 리포트 — 실비율 매크로 유닛 실측 (2026-08-17)

> 방법: 전체 ML-KEM 재작성 대신 **연산별 실비율의 매크로 유닛**(진짜 fiat 필드곱 ×
> 진짜 MVE 4-way Keccak 라운드, 정답 검증)을 보드 실측 → 유닛 수로 연산 전체 투영.
> 유닛 자체가 플래시 상주(~18KB)·루프 x1000이라 I-캐시/규모 효과 포함.
>
> **최종 선택(2026-08-24):** ITCM에 바로잡은 실제 U 직접 통합은 같은 Fiat 기준으로
> keygen −1.98%, encaps −3.72%, decaps −1.88%여서 채택하지 않는다.
> 과거 U 8.89%와 U+MVE 13.65%는 매크로커널 기반 과거 투영으로만 남긴다. 논문에
> 채택하는 실제 종단간 성과는 X/Y/C8의 2.85/1.54/3.25%다.

## 비율 산출 (게이트 실측 기반)

- 곱 1회 = 324.6 cyc (fiat yield2, 실험 I) · 배치라운드 1회 = 754 cyc (4상태, v0.4)
- encaps: 스칼라곱 2회 ≈ 곱 2,203회 vs 순열 44회 = 배치라운드 264회 → **8:1**
- keygen/decaps: 스칼라곱 1회 ≈ 곱 1,100회 vs 순열 43~44회 → **4:1**

> 326.5cyc는 yield2가 아니라 r10/r11/r12를 양보한 `fiat-yield3` 값이다. 단가 정정은
> 곱 개수 환산만 2,193→2,203으로 바꾸며 8:1/4:1 판정과 아래 실측값에는 영향이 없다.
> 원시 근거는 `measure-harness/logs/2026-08-21_expQ_nostore.txt:100-104`의 Fiat
> base/yield3/yield2 슬롯(약 287.6/326.5/324.6cyc)이다.

## 실측 (EK-RA8M1, N=100 중앙값, 정답 검증 ✓)

| 유닛 | 순차 | 스티칭 | 절감 (**분모 = 유닛 내부**) |
|---|---|---|---|
| 곱8+라운드1 (encaps 비율) | 3,256 | 3,010 | **−7.6%** |
| 곱4+라운드1 (keygen/decaps 비율) | 2,008 | 1,772 | **−11.8%** |
| (참고: 곱1+라운드1, 실험 J) | 1,065 | 979 | −8.1% |

⚠ 이 열의 분모는 **유닛 자신**(2,008 / 3,256)이며 X-Wing 연산 분모가 아니다. 종단간
%와 나란히 인용하지 말 것 — 아래 투영 표가 같은 절감량을 X-Wing 분모로 환산한 값이다.

## 3연산 투영 (분모 = X-Wing 연산 1회 전체 사이클)

> **정정 (2026-08-20) — 재측정 없음, 분모 교체.** 아래 표는 v0.1에서 분모를 **매크로 유닛
> 합계**(keygen 544k / encaps 886k)로 잡고 있었다. 그 분모는 **ML-KEM의 비-Keccak 구간
> (NTT·CBD·인코딩·글루)을 제외**하며, 그 구간은 스티칭 대상이 아니면서 X-Wing 연산의
> 17.8~30.0%를 차지한다. 결과적으로 절감률이 부풀려져 있었고, 무엇보다 **1단계 상한
> (21.2~26.4%)과 서로 다른 자로 잰 수를 비교**하고 있었다. 계획서 정오 E4로 분모를
> X-Wing 연산 전체 사이클로 확정했다 → 근거·전량 재계산: `분모_정의_통일.md`.
> **절감 사이클(분자)은 전부 불변이다. 분모만 바뀐다.**

분모 D (1단계 게이트 리포트 §2 실측 체인, pqm4 스칼라 Keccak 기준):
keygen **794,198** · encaps **1,175,479** · decaps **868,772** cyc.

| 연산 | 유닛 구성 | 절감 (cyc) | 스티칭 절감 | (구) 유닛 분모 |
|---|---|---|---|---|
| keygen | 4:1 × 258 + 잔여 곱 68 | 258 × 236 = **60,888** | **7.7%** | ~~11.4%~~ |
| encaps | 8:1 × 264 + 잔여 곱 81 | 264 × 246 = **64,944** | **5.5%** | ~~7.3%~~ |
| decaps | 4:1 × 264 + 잔여 곱 44 | 264 × 236 = **62,304** | **7.2%** | ~~~11.4%~~ |

유닛 개수 = 순열 수 × 24라운드 ÷ 4상태 (keygen 43×6=258 · encaps/decaps 44×6=264).

**같은 분모라 이제 상한과 나눌 수 있다 — 상한 대비 회수율:**

| 연산 | 상한 (1단계 §3) | 실측 회수 | **회수율** |
|---|---|---|---|
| keygen | 26.4% | 7.7% | **29%** |
| encaps | 21.2% | 5.5% | **26%** |
| decaps | 24.2% | 7.2% | **30%** |
| 평균 | 23.9% | **6.8%** | **28%** |

**4-way MVE Keccak을 함께 채택하는 경우** (같은 분모, 별도 기여이므로 분리 보고):
Keccak 구간이 순열 n회 × 5,526 → 배치라운드 6n회 × 754로 줄어 keygen **+5.4%p** ·
encaps **+3.8%p** · decaps **+5.1%p**. 스티칭과 합산한 종단간 이득 = **13.1 / 9.3 / 12.2%**.
이 절의 합산치는 초기 M/M4 결과다. 논문 대표값은 후속 실험 U 절의 선택 정책으로 갱신한다.

패턴: 두 스트림이 균형(4:1)일수록 절감↑ — 은닉 가능한 B 비중이 커지는 산수와 정합.
분모를 넓혀도 이 순서는 유지된다(keygen 7.7% > decaps 7.2% > encaps 5.5%).

## 결합기 SHA3-256 합승

결합기 = SHA3-256 1회 = 순열 +1회. 4-way 큐 설계에서 44→45번째 순열로 **같은 배치
큐에 합승** — 추가 메커니즘 불필요, 비용 ≤ 754cyc(잔여 레인 활용 시 0에 수렴).
ML-KEM 내부 Keccak과 같은 버스를 타는 것이 큐 구조상 자동.

## 한계 (정직 고지)

- 매크로 유닛 충실도: 진짜 명령 스트림·진짜 비율이나, 실제 스칼라곱의 래더 제어·cswap·
  add/sub 혼합과 ML-KEM의 absorb/squeeze 글루(실험 H: 2.5% 상한)는 유닛 밖.
- 4:1 유닛은 수치 검증 생략(1:1·3:3·8:1과 동일 생성 패턴, 결정적 타이밍) — 8:1은 검증 ✓.
- 분모 정정으로 유닛 밖 구간(ML-KEM 비-Keccak)이 분모에 들어왔다. 이 구간의 스티칭
  가능성은 **검증되지 않은 것이 아니라 설계상 배제**된 것이다(NTT 짝은 곱셈기 쟁탈전,
  T4-d에서 은닉 −1% 실측). 따라서 분모에 넣는 것이 옳고, 넣지 않으면 이득이 부풀려진다.
- 당시 M/M4 판정: **5.5~7.7% = 20% 바 미달, 퇴로 B 서사**. 단 "전 연산에서 이득이
  유지된다"는 4단계 질문의 답은 확보(세 연산 모두 양수, **상한의 26~30% 회수**).
  분모 정정은 판정을 바꾸지 않으며 간극을 **넓힌다** — 정정 방향이 저자에게 불리하다.

## 후속 실험 T — GP 무양보 선택 경로 (2026-08-21)

실험 T는 b2를 위해 r10/r11을 비워 주던 fiat 대신 GP를 양보하지 않는 fiat와, 루프에서
GP 베이스를 쓰지 않는 b0 MVE를 결합했다. EK-RA8M1에서 두 번 독립 실행했고 모든 KAT와
mismatch 검증을 통과했다.

- fiat: yield2 324.620 → no-yield 273.040cyc (**15.89% 개선**)
- MVE: b2 754.053 → b0 967.078cyc (**28.25% 악화**)
- 현재 최선 대비: 1:1 악화, 4:1 **5.25% 악화**, 8:1 **2.62% 개선**

따라서 하나의 새 커널로 전 연산을 바꾸지 않는다. 8:1인 encaps에만 b0+no-yield를 쓰고,
4:1인 keygen/decaps에는 b2+yield2를 유지하는 선택 정책이 현재 후보이다.

이 선택 정책을 기존 전체 연산 분모에 적용하면 encaps **7.65%**, 세 연산 단순 평균
**7.50%**로 계산된다. 이는 매크로 유닛 실측을 이용한 **공학적 투영이며, 완전 통합
X-Wing 보드 결과는 미측정**이다. 이 값은 U 이전의 중간 선택이며 최종 대표값은 아니다.

또한 실측된 일반성은 Cortex-M85 한 보드에 한정된다. 다른 M85 SoC 및 M55/M52 성능은
미측정이고, MVE가 없는 코어에는 b0 경로가 적용되지 않는다. 다음 단계는 b0를 gather
latency에 맞게 재스케줄한 뒤 M85에서 다시 측정하고, 이후 다른 코어에서 별도 측정하는 것이다.

## 후속 실험 U — yield1 + one-GP b1 (2026-08-21)

리서치의 `b2 + no-yield` 제안을 직접 대조한 결과, no-yield는 r10과 `fp`=r11을
모두 쓰므로 두 b2 앵커를 그대로 결합할 수 없었다. 대신 GP 하나만 양보하고
다른 앵커를 q7 gather/scatter로 처리한 기능 등가 b1 중간 게이트를 두 번
독립 실측했다.

- scalar: r10-fixed 266.039cyc, r11-fixed 267.040cyc
- MVE b1: low-contiguous 850.075cyc, high-contiguous 910.077cyc
- 현재 최선 대비: 1:1 8.77% 악화, 4:1 0.68% 개선, 8:1 4.12% 개선
- 정확성: 전체 KAT/ML-KEM/reject/mismatch 통과, `harness_fails=0`

당시 매크로커널 게이트에서 실험 U는 **부분 성공**으로 판정됐다. encaps 8:1은
b0+no-yield를 b1+yield1로 교체하지만, keygen/decaps 4:1은 개선폭이 작았다. 매크로
실측을 기존 전체 분모에 넣은 미통합 투영은 8.54/10.32/7.82%(평균 8.89%)였고 독립
MVE Keccak 투영까지 합치면 13.97/14.07/12.90%(평균 13.65%)였다. 2026-08-24
AE2 직접 통합이 이 양의 투영을 반증했으므로 현재는 과거 진단값으로만 사용한다.

일반화 경계는 T와 같다. 숫자는 EK-RA8M1 Cortex-M85 한 보드에서만 실측되었고,
다른 M85/M55/M52는 미측정이다.

## 후속 실험 V/W — pqmx M85 NTT 직접 이식 (2026-08-21)

V에서 현재 ML-KEM의 forward/inverse를 각각 **5,354.012/6,586.013cyc**로 직접
측정했다. W에서는 pinned pqmx/SLOTHY의 M85 forward 4종과 draft PR #87의 WIP M85
inverse를 같은 EK-RA8M1 ITCM에서 두 번 독립 실행했다. 최선 forward는
**2,814.027cyc(−47.44%)**, inverse는 **3,294.030cyc(−49.98%)**였고, forward 4종·
inverse oracle·forward→inverse roundtrip·기존 KAT가 전부 통과했다.

정적 호출 수를 적용한 raw primitive 절감은 25,115.859/20,787.887/31,699.825cyc로
keygen/encaps/decaps gate를 모두 통과한다. 그러나 후보는 아직 ML-KEM에 연결되지 않았고,
noncanonical 4×4 ordering과 Plantard↔Montgomery domain glue가 남아 있다. scalar `rev4`
실측은 608.032cyc다.

당시 U+독립 MVE Keccak 장부에 raw W를 단순 합산한 임시 값은 평균 16%대였다.
이 값은 ordering/domain glue가 없는 primitive projection이므로 아래 X/Y 실제 통합
차분으로 대체하며 현재 장부에는 다시 더하지 않는다.

## 후속 실험 X/Y — pqmx NTT 실제 ML-KEM 통합 (2026-08-21)

X에서 forward+rev4, Y에서 Plantard-scale inverse+rev4를 실제 ML-KEM wrapper에
연결했다. 동일 함수·stack·RNG의 ABBA N=100으로 두 번 독립 측정했고, 최종 유효
run의 conservative 절감은 다음과 같다.

| 계층 | keygen | encaps | decaps |
|---|---:|---:|---:|
| X forward | 10,467 | 5,220 | 10,614 |
| Y inverse | 8,305 | 10,957 | 13,590 |
| **합계** | **18,772** | **16,177** | **24,204** |

8-seed full ML-KEM pk/sk/ct/valid·reject ss 전 바이트, standalone inverse oracle,
buffer/stack canary, 기존 KAT와 mismatch가 모두 0이고 `harness_fails=0`이다. Y의 두
run은 6k/8k/10k gate를 모두 통과해 **강한 성공**이다.

최초 Y diagnostic run은 기존 `invntt_fast`의 명시 계약(`<0.5q`) 밖인 양의 `q-1`을
oracle에 넣은 시험 설계 오류 때문에 mismatch 10이 발생했다. 이 run은 성능값까지 전부
기각했고, 양쪽 구현에 유효한 centered 입력으로 수정한 뒤 두 번 새로 측정했다.

따라서 W의 raw primitive projection은 더 이상 합산하지 않는다. 정정 U + 독립 MVE
Keccak + 실제 X/Y 차분의 현재 혼합 장부는 **16.33/15.45/15.68%(평균 15.82%)**이며,
20%까지 **29.2k/53.5k/37.5k cycle**이 남는다. NTT 통합은 성공했지만 20%는 아직
아니다. 다음 우선순위는 같은 layout에서 rev4를 없애는 basemul/matacc fusion(C8)과
ML-KEM 비-Keccak 함수별 직접 귀속이다.

## 후속 실험 Z — X+Y 동시 적용과 비-Keccak 직접 귀속 (2026-08-21)

Z1에서 X와 Y를 동시에 켠 candidate를 baseline과 같은 함수·stack·RNG의 ABBA N=100으로
두 번 실측했다. conservative 절감은 keygen **18,851**, encaps **16,155**, decaps
**24,500~24,502 cycles**였고 isolated X+Y 합계의 **99.86~101.23%**를 보존했다.
모든 correctness, alignment, canary, stack 검증과 `harness_fails=0`을 통과했으므로
Z1은 사전 등록상 **강한 성공**이다.

Z2 별도 profiler build는 target assembly와 CBD/packing 함수의 DWT cycle을 직접
귀속했다. 두 run에서 C8은 keygen **67,961~67,988**, encaps **71,586~71,599**,
decaps **81,492~81,514 cycles**, C9는 각각 약 **33.8k/47.4k/59.1k cycles**였다.
동일 8-seed profiler OFF/ON 출력은 모두 일치했다.

따라서 10k gate를 크게 넘은 **C8 basemul/matacc fusion을 다음 구현으로 채택**한다.
이 값은 제거 가능한 구간의 귀속량이지 실제 절감량이 아니다. C8을 구현한 뒤 전체
파이프라인 ABBA에서 다시 재기 전에는 20% 달성으로 표현하지 않는다. 결과의 실측 범위는
EK-RA8M1 Cortex-M85 한 보드이며 다른 M85/M55/M52 수치는 아직 일반화하지 않는다.

## 후속 실험 AA/AB — C8와 실제 X-Wing 종단간 (2026-08-21)

C8은 pqmx의 기존 current-order M85 structure-store 커널을 재사용하는 최소 변경으로
forward 뒤 scalar `rev4`를 제거했다. 두 독립 run의 full ML-KEM conservative 절감은
keygen **3,908~3,952**, encaps **1,858~1,866**, decaps **3,906~3,937 cycles**로
사전 gate를 모두 통과해 **강한 성공**이다.

이어 ML-KEM-768 + X25519 + X-Wing SHA3-256 combiner를 실제 wrapper로 조립하고,
기존 NTT와 X/Y/C8을 ABBA N=100으로 비교했다. 두 run의 conservative 절감은
**22,637~22,651/18,046~18,052/28,280 cycles**, X-Wing 전체 대비
**2.85/1.54/3.25%**였다. 8-seed pk/sk/ct/valid·reject ss, stack/canary와 기존
KAT가 모두 통과했고 `harness_fails=0`이었다.

다만 U와 MVE Keccak은 아직 완전한 X25519/Keccak API가 아니라 고정 operand의 field-mul
× Iota=1 단일-round 매크로커널이다. 같은 ELF에 포함되어 독립 검증된 것과 실제 X-Wing
호출 경로에 통합된 것은 다르다. 따라서 혼합 장부 **16.82/15.61/16.13%(평균 16.19%)**는
여전히 투영이며, 20%까지 **25.2k/51.6k/33.6k cycles**가 남는다. 다음 구현은 완전한
X25519 ladder의 stitched field-mul과 24-round Keccak-f1600x4/ML-KEM x4 배칭이다.

## 후속 실험 AC — b0 기반 실제 ladder + Keccak-f1600x4/SHAKE x4 통합 (2026-08-21)

Lenngren X25519 ladder의 임의 `fe25519_mul` 피연산자를 처리하는 b0 기반 스티칭
후보를 구현했다. MVE 쪽은 24-round
Keccak-f1600x4, SHAKE128x4 absorb/squeezeblocks, one-shot SHAKE128x4/SHAKE256x4
API이며, ML-KEM-768 matrix-XOF의 독립 3스트림을 3 lane+dummy로 묶었다. 이는 여러
독립 ML-KEM 요청 네 개를 배칭한 것이 아니라 단일 X-Wing 요청 내부 배칭이다.

두 독립 ABBA N=100 run의 conservative 결과는 다음과 같다.

| 연산 | run 1 | run 2 | 판정 |
|---|---:|---:|---|
| keygen | −57,274cyc (−7.30%) | −57,322cyc (−7.30%) | 실패 |
| encaps | −90,318cyc (−7.64%) | −90,325cyc (−7.64%) | 실패 |
| decaps | −57,473cyc (−6.73%) | −57,463cyc (−6.73%) | 실패 |

x4/AC-stitch KAT, 8-seed X-Wing full output와 reject, timing workload, stack/canary는 모두
mismatch 0이고 두 run 모두 `harness_fails=0`이었다. 즉 구현은 기능적으로 맞지만
기존 X/Y/C8보다 세 연산 모두 느리다. 사전 등록상 **성능 실패**이며 AC candidate는
채택하지 않는다. 앞서 적은 16.19% 전 스택 혼합 장부는 성능 주장에 쓰지 않는다.
사후 코드 감사 결과 AC 생성기는 `round_mve4_b0()`를 사용하며 논문 대표 U의
`yield1+b1`을 실제 ladder에 옮긴 구현은 아니다. 따라서 AC를 U의 종단간 실측값으로
인용하지 않는다. 다만 후속 AE2가 선택 U 자체를 실제 ladder에 옮겨 별도로 측정했고,
그 결과는 아래와 같이 성능 실패였다.
20% 목표는 여전히 미달이다.

최초 진단 2회는 scalar A에도 `fe25519_mul` dispatcher 비용이 섞인 것을 사후 감사에서
발견해 기각했다. scalar direct-call과 AC clone을 분리한 뒤 위 두 run을 새로 측정했다.
후속 AD 단일변수 ABBA에서 x4 배칭은 약 25k cycles/연산, AC b0 스티칭은 X25519
1회당 약 32.4k cycles의 손실로 분리됐다. 이 중 약 25.3~25.5k가 dispatcher
세금이고 나머지는 약 6.9~7.3k다. 상세와 빌드 해시는
`measure-harness/2026-08-22_expAD_results.md`에 기록했다.

## 후속 실험 AE/AE2 — 선택 U의 실제 ladder 직접 통합 (2026-08-24)

AC가 b0였다는 감사 결과에 따라, 실험 U의 실제 선택인 `r11-fixed + low-contiguous b1`을
Fiat 10×25/26 X25519 Montgomery ladder의 임의 피연산자 경로에 새로 넣었다. 비교군 `F`와
후보 `U`는 같은 Fiat X25519와 같은 x4 Keccak을 사용하며, `F→U`가 스티칭 자체의
단일변수 차분이다.

최초 파일럿에는 스티칭 뒤 잔여 곱셈에도 queue search/modulo dispatcher가 남아 `F`에 없는
세금이 섞였다. 이를 사후 결과로 채택하지 않고, 잔여 ladder를 direct finish로 바꾸는
보정안을 측정 전에 기록한 뒤 독립 ABBA N=100 run 두 번을 새로 실행했다.

| 연산 | AF ITCM run 1 | AF ITCM run 2 | 판정 |
|---|---:|---:|---|
| keygen | −26,291cyc (−1.98%) | −26,362cyc (−1.98%) | 실패 |
| encaps | −83,462cyc (−3.72%) | −83,434cyc (−3.72%) | 실패 |
| decaps | −26,302cyc (−1.88%) | −26,298cyc (−1.88%) | 실패 |

음수 절감은 악화다. 후속 AF 감사에서 기존 AE2 U assembly가 hot kernel과 달리 일반
code flash에 놓였음을 발견했다. 실제 호출은 연산당 3배치이고 dummy step은 0이었다.
동일작업 `P8−2P4`는 flash 114.35~114.75k에서 ITCM 5.96~6.02k cycles/batch로
약 95% 줄었고, 3배 감소 약 325k가 기존 미설명 약 332k와 일치했다. 따라서 AE2의
−19.8% encaps는 **13.3 KiB U8 instruction working set × flash 배치 오류**가 섞인
값이며 대표 결과에서 제외한다. E와 U4는 원래 배치에 둔 채 U8만 ITCM으로 옮긴 추가
단일변수에서도 `P8−2P4=−3.56~−3.23k/batch`가 되어 2-job 고유 추가 손실은 사라졌다.
ITCM 교정 뒤에도 세 연산이 모두 느려 U는 채택하지 않지만, 실제 구현 경계의 잔여 손실은
약 1.9~3.7%다. 이 전체 잔여분의 세부 원인은 미측정이다.

두 run 모두 RFC 7748 KAT 4개, SHA3 KAT, x4/U primitive KAT, 8-seed X-Wing
full-output/reject, timing, stack/canary를 통과했고 `harness_fails=0`이었다. 따라서 이는
**정확성 성공·성능 실패**다. U는 채택하지 않으며 8.89/13.65%는 실제 종단간 결과가 아닌
과거 투영 진단값으로만 남긴다. 상세는 `measure-harness/2026-08-24_expAF_results.md`다.
