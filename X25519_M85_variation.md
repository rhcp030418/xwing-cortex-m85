# Cortex-M85 X25519 추가 최적화 variation 장부

- 작성일: 2026-08-25
- 대상: **MVE 탑재 여부와 메모리 구성이 서로 다른 Cortex-M85 구현 전체**의 X-Wing 내부 X25519
- 현재 실측 기준 장치: EK-RA8M1. 이 장치의 수치는 출발점일 뿐 Cortex-M85 전체의 결과로 일반화하지 않는다.
- 상위 통합 장부: ML-KEM-768·combiner·교차 스케줄까지 포함한 `XWing_CortexM85_통합_variation.md`
- 목적: 다음 실험의 후보를 빠짐없이 모으되, 문헌 근거·아키텍처 사실·실측 결과·미측정 가정을 분리한다.
- 주의: 이 문서는 아이디어 장부다. 아래 후보의 성능은 별도 표기가 없으면 모두 **미측정**이며, 결과로 인용하면 안 된다.

## 1. 먼저 내리는 결론

후보는 충분히 많다. 중복 조합을 제외해도 이 문서에는 baseline과 필수 통제를 포함한 **53개의 원자적 design entry**가 있다. 다만 서로 강하게 겹치는 항목이 많아서 53개를 모두 독립 연구로 볼 수는 없다. 실험 가족으로 압축하면 약 12개이고, 당장 우선할 만한 것은 7개다.

가장 현실적인 방향은 “X25519와 Keccak이 GP 레지스터를 다시 나눠 쓰게 하는 것”이 아니다. 현재 Cortex-M4용 8×32 X25519를 M85에 맞게 다시 스케줄하고, `mul/sqr` 쌍과 ladder step을 묶고, keygen의 고정기저 및 encaps의 두 X25519라는 **X-Wing 자체 구조**를 이용하는 쪽이다. MVE가 빠진 Cortex-M85 구성에는 scalar 재스케줄 경로를, MVE가 있는 구성에는 scalar/MVE runtime 또는 build-time 선택 경로를 둔다.

우선순위는 다음과 같다.

1. 현재 8×32 `mul/sqr/sqr_many`를 Cortex-M85용으로 재스케줄
2. 전용 square와 `mul2/sqr2` 쌍 커널
3. 한 ladder step의 `AA/BB`, `DA/CB` 병렬 스케줄 및 함수 융합
4. keygen 전용 고정기저 X25519 사전계산 ladder
5. encaps 두 작업의 스칼라 lockstep 및 안전한 배치 역원
6. `vmullb/vmullt` 기반 2-job MVE 최소 커널
7. 16-bit 또는 radix-2^29 표현의 최소 곱셈 feasibility probe

## 2. 방금 설명에서 바로잡을 점

### 2.1 MVE lane 수

MVE의 128-bit `u32` 벡터는 **4 lane**이다. 따라서 “lane 0~3은 첫 번째 X25519, lane 4~7은 두 번째 X25519”라는 설명은 틀렸다. 8 lane을 얻는 것은 16-bit 원소를 쓸 때이며, 이 경우 25519 곱셈의 carry·범위·누산 설계를 새로 해야 한다.

또한 `vmlaldava.u32` 계열은 네 lane의 곱을 job별로 남기는 명령이 아니라, 전 lane을 하나의 64-bit GP 누산기로 환원한다. 그러므로 이 명령을 그대로 쓰는 2-job job-parallel은 성립하지 않는다. 후보가 되려면 다음 중 하나가 필요하다.

- `vmullb.u32`/`vmullt.u32`로 독립 64-bit 결과를 만들고 job별로 유지
- job마다 별도 Q 레지스터를 쓰는 SoA 배치
- 16-bit 8-lane 표현으로 변경
- MVE를 포기하고 두 스칼라 job의 독립 명령을 교차 스케줄

Arm은 MVE가 widening 결과를 벡터의 독립 64-bit lane에 계속 쌓는 Neon 방식과 다르게 GP 레지스터 누산을 활용하며, 벡터 레지스터도 제한적이라고 설명한다. Cortex-M85의 공식 처리율 상한도 최대 2×32-bit, 4×16-bit, 8×8-bit MAC/cycle이다. 이것은 “4개의 32-bit 곱이 매 cycle 공짜”라는 뜻이 아니다.

근거: [Arm Helium 설계 설명](https://developer.arm.com/community/arm-research/b/articles/posts/making-helium-why-not-just-add-neon), [Cortex-M85 공식 사양](https://developer.arm.com/compute-ip/cortex-m85)

### 2.2 레지스터를 나눠 쓰지 않았던 기존 결과

기존 T 실험의 no-yield/b0가 사실상 “Fiat과 MVE가 GP 레지스터를 나눠 쓰지 않게 한” 방향이었다.

- Fiat scalar: 324.620 → 273.040cyc, **15.89% 개선**
- MVE b2 → b0: 754.053 → 967.078cyc, **28.25% 악화**
- 원인: scalar의 레지스터 양보 비용은 없어졌지만 MVE 쪽 gather/scatter와 주소 복구 비용이 커졌다.
- 종합: 4:1 비율에서는 악화했고, 8:1에서만 작은 개선이었다. 당시 사전등록 장부는 +3.20%, 후속 동일 분모 정리는 +2.62%로 기록되어 있으므로 세대·분모를 붙이지 않은 단일 숫자로 합치면 안 된다.

U의 “GP 1개만 공유” 절충안은 매크로에서 4:1 +0.68%, 8:1 +4.11~4.12%였지만, 실제 X-Wing 통합 F→U는 ITCM 교정 후에도 keygen/encaps/decaps가 **1.98/3.72/1.88% 악화**했다. 따라서 “레지스터를 아예 안 나누면 해결된다”는 가설은 현재 데이터로는 기각이다.

근거 문서: `A주제_총정리_육하원칙.md`, `measure-harness/2026-08-21_expT_b0_noyield_prereg.md`, `measure-harness/2026-08-21_expU_yield1_b1_prereg.md`

### 2.3 두 X25519의 배치 역원

두 projective Z가 모두 0이 아닐 때는 Montgomery's trick으로 역원 2회를 역원 1회와 곱셈 3회로 바꿀 수 있다. 수학적으로는 유효하지만 X25519의 임의 입력에서는 Z=0이 나올 수 있다. 한 job의 Z=0이 곱 `Z1*Z2`를 0으로 만들면 순진한 구현은 정상인 다른 job까지 오염시킨다.

따라서 이 후보는 다음 조건을 모두 만족할 때만 유효하다.

- constant-time으로 각 Z의 zero mask 계산
- zero인 Z는 곱 전에 1로 치환
- 역원 후 각 원래 zero job의 출력만 다시 0으로 복구
- RFC KAT뿐 아니라 low-order·all-zero·임의 입력 differential test 통과
- 기존 API의 all-zero 처리 의미를 바꾸지 않음

이 조건이 없으면 배치 역원은 **기각 후보**다. RFC 7748은 X25519의 ladder와 입력·출력 처리를 정의하며, 구현은 비밀값에 따른 분기·주소 변화를 만들면 안 된다.

근거: [RFC 7748](https://www.rfc-editor.org/rfc/rfc7748.html)

### 2.4 고정기저 최적화

keygen의 X25519 basepoint 9는 고정점이므로 사전계산 가능한 right-to-left Montgomery ladder가 정당한 후보다. 실제 X25519/X448 연구에서 8 KiB 사전계산표와 key-generation 가속이 보고됐다. 다만 그 논문의 CPU 수치를 M85 예상치로 옮기면 안 되며, M85 결과는 **미측정**이다.

Ed25519 고정기저 곱을 호출한 뒤 좌표를 변환하는 우회안은 별도 문제다. scalar clamp, subgroup/torsion, 키 생성 파생 방식, 출력 직렬화와 API 의미를 모두 증명해야 하므로 첫 후보로 삼지 않는다. 전용 X25519 고정기저 ladder가 더 직접적이다.

근거: [How to (pre-)compute a ladder](https://eprint.iacr.org/2017/264.pdf), [RFC 7748](https://www.rfc-editor.org/rfc/rfc7748.html), [libsodium 변환 주의사항](https://github.com/jedisct1/libsodium-doc/blob/master/advanced/ed25519-curve25519.md)

## 3. 현재 기준선과 해석 경계

- 현재 대표 X25519: Cortex-M4 계보의 handwritten 8×32 assembly, RA8M1 hot code ITCM, 단독 **357,474cyc 실측**
- 현재 대표 X-Wing 개선: RA8M1 X/Y/C8 keygen/encaps/decaps **2.85/1.54/3.25% 실측**
- Fiat 10×25/26 no-yield `carry_mul`: 273.040cyc는 별도 미세커널 결과이며, 현재 8×32 whole ladder와 직접 합산할 수 없음
- ladder 1 step의 표준 구조: 5M+4S로 셀 수 있으나, 이를 255회 곱한 2,295회는 호출 구조를 설명하기 위한 **추정 회계**이지 실측 profiler 값이 아님
- 현재 `fe25519_mul`, `fe25519_sqr`, `fe25519_sqr_many`가 이미 상당히 손으로 최적화돼 있으므로 “Karatsuba를 넣으면 당연히 빨라진다”는 표현은 금지

2026-08-25 현재 소스 정적 감사에서는 `fe25519_mul`에 `umull` 4개와 `umaal` 68개, `fe25519_sqr`에 `umull` 6개와 `umaal` 46개가 보인다. 별도 대칭 square는 이미 존재하고, mul은 명시적인 operand 반분 Karatsuba보다 column/product-scanning 계열로 보인다. 이는 **정적 소스 관찰**이며 M85 cycle 결론은 아니다. 따라서 M02와 “전용 square의 존재”는 새 아이디어가 아니고, 새 후보는 M85 재스케줄·paired square·융합 범위다.

8×32와 Karatsuba/product-scanning은 Cortex-M 계열에서 이미 검증된 설계 계보다. 문헌은 Cortex-M4 이상에서 dense radix-2^32와 약한 reduction을 사용하고, Cortex-M0 구현에서는 3-level refined subtractive Karatsuba를 사용한다. 어느 변형이 M85에서 이기는지는 직접 측정해야 한다.

근거: [Curve25519 for Cortex-M4 and Beyond](https://www.cs.haifa.ac.il/~orrd/LC17/paper39.pdf), [High-speed Curve25519 on microcontrollers](https://eprint.iacr.org/2015/343.pdf)

## 4. Variation 전체 목록

표의 상태는 다음 의미다.

- **실측 근거**: 이 프로젝트 보드 결과가 있음
- **문헌 근거**: 다른 플랫폼에서 성립함
- **ISA 근거**: 명령·처리율·lane 구조가 공식 문서상 존재함
- **가정/미측정**: M85에서 이득인지 아직 모름
- **조건부**: 정확성·API·메모리 등의 선행 조건이 있음

### 4.1 병렬화 축 — P01~P09

| ID | variation | 적용 | 상태 | 핵심 위험 | 우선도 |
|---|---|---|---|---|---|
| P01 | 한 job의 limb를 4×u32 lane에 배치 | 전부 | ISA 근거, 미측정 | carry와 cross-lane shuffle | 중 |
| P02 | 두 job을 별도 Q 레지스터에 둔 u32 SoA | encaps | 가정, 미측정 | 2/4 lane 이용률, Q 레지스터 부족 | 중 |
| P03 | `vmullb/t.u32`로 두 job의 64-bit 곱을 독립 유지 | encaps | ISA 근거, AM0 필요 | 누산·shuffle·spill | **상** |
| P04 | 네 독립 X25519를 4 lane에 배치 | 별도 throughput API | 문헌 근거, 미측정 | X-Wing 단일 요청 latency와 무관 | 하/별도 |
| P05 | MVE 없이 두 scalar ladder를 lockstep 교차 스케줄 | encaps | M85 dual-issue 근거, 미측정 | 같은 곱셈 파이프 경합, GP spill | **상** |
| P06 | 한 xDBLADD의 `AA/BB`, `DA/CB`, 마지막 두 square를 MVE pair 처리 | 전부 | 수식상 독립, 미측정 | 전체 field state를 Q에 유지 불가 가능성 | **상** |
| P07 | P06을 scalar dual-stream 명령 스케줄로 처리 | 전부 | 수식상 독립, 미측정 | carry dependency와 register pressure | **상** |
| P08 | MVE는 partial product, scalar는 carry/reduction을 담당 | 전부 | ISA 근거, 미측정 | 파이프 겹침보다 이동 비용이 클 수 있음 | 중 |
| P09 | ladder·inversion·serialization마다 다른 backend 사용 | 전부 | 가정, 미측정 | 표현 변환 비용 | 중 |

P04와 유사한 “여러 독립 scalar multiplication을 SIMD lane에 하나씩 넣는” 방식은 AVX2 Curve25519 구현에서 문헌 근거가 있다. 그러나 MVE는 AVX2와 레지스터·widening 누산 구조가 다르므로 가능성의 근거일 뿐 성능의 근거는 아니다.

근거: [High-Throughput ECC on AVX2](https://orbilu.uni.lu/bitstream/10993/48810/1/SAC2020.pdf), [Sandy2x](https://eprint.iacr.org/2015/943.pdf)

### 4.2 field 표현과 메모리 배치 — R01~R08

| ID | variation | 상태 | 장점 후보 | 핵심 위험 | 우선도 |
|---|---|---|---|---|---|
| R01 | 현재 8×32 dense radix 유지 | 실측 기준선 | 변환 없음, 검증된 asm | 기존 최적화 여지가 작을 수 있음 | **최우선 기준선** |
| R02 | signed-centered 8×32 | 문헌 근거, 미측정 | subtractive Karatsuba·carry 완화 | 범위 증명 재작성 | 중 |
| R03 | Fiat 10×25/26 유지 | 미세커널 실측 | 64-bit 누산 여유 | limb 수·GP 압박·whole-ladder 회귀 | 중 |
| R04 | 9×29 또는 유사 radix-2^29 | SIMD 문헌 근거, 미측정 | 32-bit SIMD headroom | MVE에서 최적 radix라는 보장 없음 | 중 |
| R05 | 16×16 또는 유사 16-bit radix | ISA·마이크로컨트롤러 문헌 근거 | 8 lane, 4×16 MAC/cycle | partial product 수와 carry 증가 | **상, 최소 probe** |
| R06 | redundant/lazy range 표현 | 문헌 근거, 미측정 | carry/reduction 횟수 감소 | overflow·최종 canonicalization 증명 | 중 |
| R07 | 기존 AoS, 호출 때마다 pack/unpack | 구현 단순 | 기존 API 유지 | 전치 비용 반복 | 기준 |
| R08 | ladder 동안 지속되는 SoA/persistent packed layout | 가정, 미측정 | 전치 1회로 상각 | 함수 경계·stack·ABI 변경 | **상** |

radix-2^29는 4-way AVX2 구현의 선택이지 MVE의 정답이 아니다. 16-bit radix는 lane 수를 늘리지만 Cortex-M85의 공식 상한은 4×16-bit MAC/cycle이고, 곱 항 개수와 carry가 늘어난다. 두 표현 모두 먼저 `mul+carry` 하나만 만들어야 한다.

### 4.3 곱셈·제곱·reduction — M01~M11

| ID | variation | 상태 | 핵심 질문 | 우선도 |
|---|---|---|---|---|
| M01 | 현재 8×32 asm을 M85 latency/dual-issue에 재스케줄 | 미측정 | Cortex-M4 schedule의 stall을 줄이는가 | **최상** |
| M02 | schoolbook/Comba product-scanning | 문헌 근거 | load/store와 accumulator 수가 M85에 맞는가 | 중 |
| M03 | 2-level Karatsuba | 문헌 근거 | 현재 소스가 이미 쓰는 범위와 차이가 있는가 | 상, 정적 감사 후 |
| M04 | 3-level refined subtractive Karatsuba | Cortex-M0 문헌 근거 | 감소한 MUL이 추가 add/sub보다 큰가 | 중 |
| M05 | 현재 대칭 전용 square의 M85 재스케줄·paired square화 | 기존 함수 정적 확인, M85 미측정 | 현재 115cyc 주석 경로보다 실제 M85 명령·spill이 줄어드는가 | **최상** |
| M06 | 곱셈과 mod `2^255-19` reduction 융합 | 문헌 근거 | 중간 저장과 carry를 줄이는가 | 상 |
| M07 | 매 field op마다 weak reduction, 마지막만 strong reduction | 문헌 근거 | 범위가 255-step 동안 안전한가 | 상 |
| M08 | reduction/carry를 N개 연산마다 수행 | 가정, 미측정 | N=2/4에서 overflow 없이 이기는가 | 중 |
| M09 | `mul121666` 전용 상수곱+reduction | 수식 근거, 미측정 | `z2` 갱신의 호출·메모리를 줄이는가 | **상** |
| M10 | add/sub 결과를 저장하지 않고 다음 mul 입력으로 직접 소비 | 가정, 미측정 | load/store 절감이 spill보다 큰가 | **상** |
| M11 | `mul2`/`sqr2` 인터페이스로 독립 두 연산을 한 커널에서 수행 | 수식·SIMD 문헌 근거 | shared load/reduction과 scheduling 이득이 있는가 | **최상** |

M03은 구현 전에 현재 `x25519-cortex-m4-gcc.s`의 partial-product 계보를 명령 단위로 확인해야 한다. 이미 포함된 기법을 새 variation으로 잘못 세면 안 된다.

### 4.4 ladder 융합·제어 — L01~L08

| ID | variation | 상태 | 핵심 위험 | 우선도 |
|---|---|---|---|---|
| L01 | `fe25519_*` 호출을 없앤 fused xDBLADD step | 가정, 미측정 | 코드 크기와 spill | **최상** |
| L02 | 중간 field element store 지연 | 가정, 미측정 | Q/GP live set 폭발 | 상 |
| L03 | X25519 전용 custom ABI로 callee-save를 ladder 입출구 1회만 처리 | 가정, 미측정 | 호출 규약·unwind·통합 복잡도 | 상 |
| L04 | bit loop 2/4/8-step unroll | 미측정 | bit 간 데이터 의존성은 그대로, ITCM 증가 | 중 |
| L05 | low-overhead loop 명령 사용 | ISA 근거, 미측정 | 분기 비용 비중이 작을 수 있음 | 중 |
| L06 | 8×32 scalar XOR-mask cswap 재스케줄 | 상수시간 구조, 미측정 | 얻을 수 있는 비중이 작음 | 중 |
| L07 | MVE load/xor/and/store cswap | ISA 근거, 미측정 | vector state 전환·LSU 비용 | 중 |
| L08 | RFC식 `swap ^= bit` 상태와 최종 swap의 제어 최소화 | 일부 기존 구현 가능 | 이미 적용됐을 수 있음 | 정적 감사 후 |

bit loop는 다음 bit가 현재 step 결과에 의존하므로 여러 bit를 진짜 병렬 실행할 수 없다. unroll은 분기·주소 계산·schedule window를 줄이거나 넓힐 뿐이며, 병렬성 자체를 새로 만들지는 않는다.

### 4.5 inversion·마무리 — I01~I05

| ID | variation | 적용 | 상태 | 핵심 위험 | 우선도 |
|---|---|---|---|---|---|
| I01 | 현재 FLT addition chain을 M85용으로 재스케줄 | 전부 | 미측정 | ladder 대비 비중 확인 필요 | **상** |
| I02 | `sqr_many` 2/4회 unroll 및 low-overhead loop | 전부 | 미측정 | code size와 dependency | **상** |
| I03 | encaps 두 job의 addition chain을 lockstep/vector 처리 | encaps | 가정, 미측정 | Q/GP spill | 상 |
| I04 | zero-safe Montgomery batch inversion | encaps | 수학적 근거, **조건부** | 한 Z=0이 다른 job을 오염 | **상, 안전 설계 후** |
| I05 | divstep/jumpdivstep 계열 역원 | 전부 | 문헌 근거, M85 미측정 | 32-bit M85에서 FLT보다 느릴 수 있음 | 하 |

현재 소스 주석의 inversion 구간은 약 33,412cyc이지만, 이 값은 같은 현재 ELF에서 checkpoint로 다시 재야 한다. 다른 64-bit 플랫폼에서 divstep보다 FLT+assembly가 빨랐다는 결과도 있으므로 “새 역원 알고리즘이면 당연히 개선”이라고 가정하지 않는다.

근거: [High-assurance field inversion](https://eprint.iacr.org/2021/549.pdf), [addchain](https://github.com/mmcloughlin/addchain)

### 4.6 keygen 고정기저 — F01~F03

| ID | variation | 상태 | 핵심 위험 | 우선도 |
|---|---|---|---|---|
| F01 | basepoint 9 전용 precomputed right-to-left X25519 ladder | X25519 문헌 근거, M85 미측정 | 8 KiB급 table, flash/ITCM/DTCM 위치 | **최상** |
| F02 | table 크기·window·배치 variation | 조건부 | memory와 cycle의 trade-off | 상 |
| F03 | Ed25519 fixed-base 곱 후 X25519 변환 | 변환은 가능, drop-in 미증명 | scalar·torsion·API 의미 | **하/보류** |

F01은 keygen만 개선하며 encaps/decaps의 variable-base shared-secret에는 직접 적용되지 않는다. 따라서 논문에서는 operation별 결과를 분리해야 한다.

### 4.7 도구·코드 배치와 M85 구현 프로파일 — T01~T09

| ID | variation | 상태 | 핵심 질문 | 우선도 |
|---|---|---|---|---|
| T01 | intrinsics prototype → handwritten asm | 기존 경험 근거 | compiler spill을 제거하는가 | 상 |
| T02 | SLOTHY로 M85 `mul/sqr/xDBLADD` 재스케줄 | 프로젝트 AG 실측 근거 | 모델 오차를 보드 피드백으로 줄일 수 있는가 | **최상** |
| T03 | hot kernel만 ITCM overlay | 프로젝트 AF 실측 근거 | working set을 제한하면서 fetch 손실을 없애는가 | **필수 통제** |
| T04 | 함수 정렬·branch target·code ordering | 미측정 | 같은 명령열에서도 fetch가 달라지는가 | 중 |
| T05 | LTO/force-inline/noinline variation | 미측정 | 호출 제거와 code bloat 중 무엇이 큰가 | 중 |
| T06 | speed형/size형 두 asm 버전 | 미측정 | ITCM 용량 경계를 넘는가 | 중 |
| T07 | MVE build와 `+nomve` scalar build를 분리·선택 | MVE optional 공식 근거 | 서로 다른 M85 구성에서 같은 API를 유지하는가 | **필수 이식성** |
| T08 | DTCM 4-bank를 고려한 operand/stack 정렬·bank 배치 | Arm 최적화 지침, 미측정 | 동시 scalar/MVE access의 bank conflict를 줄이는가 | 상 |
| T09 | CDE/ACI custom field-mul 명령 사용 | M85 optional extension 근거, 별도 범위 | 표준 M85 portability를 잃고 SoC 종속이 되는가 | 하/별도 트랙 |

T03은 독립 성능 아이디어라기보다 모든 비교의 필수 통제다. AF에서 동일 계열 코드의 flash/ITCM 차이가 매우 컸으므로 A/B의 section 배치가 다르면 결과를 인정하면 안 된다. 단, ITCM과 cache는 Cortex-M85에서 선택 구성이다. 따라서 “항상 ITCM”으로 고정하지 않고 아래 실행 프로파일을 분리한다.

- **P-TCM**: code=ITCM, data/stack=DTCM
- **P-CACHE**: code=AXI/main memory+I-cache, data=D-cache 또는 SRAM
- **P-NOCACHE**: code=flash/main memory, cache 없음
- **P-NOMVE**: MVE가 빠진 Cortex-M85의 scalar 전용 경로

Arm 공식 자료에 따르면 Cortex-M85의 MVE, I/D cache, ITCM/DTCM, coprocessor/custom instruction은 선택 구성이다. 또한 M55/M85 DTCM은 bit 2·3으로 interleave된 4-bank 구조이며, low-overhead loop 안의 Helium 명령은 32-bit 정렬이 권장된다. 따라서 RA8M1의 ITCM 결과는 P-TCM 한 점일 뿐이다.

근거: [Cortex-M85 공식 구성 옵션](https://developer.arm.com/compute-ip/cortex-m85), [Armv8.1-M/M85 소프트웨어 최적화 지침](https://developer.arm.com/community/arm-community-blogs/b/architectures-and-processors-blog/posts/armv8_2d00_m-based-processor-software-development-hints-and-tips)

## 5. 53개 design entry 중 실제로 먼저 할 7개

### 1순위: M01 + M05 + T02

현재 8×32 표현과 API를 유지하고 `mul`, 전용 `sqr`, `sqr_many`만 M85에 맞게 재스케줄한다. 변환 비용이 없고 실패해도 원인 분해가 쉽다.

최소 산출물:

- 동일 피연산자·동일 ITCM의 기존/후보 `mul+carry`
- 정적 instruction, `umull/umaal`, load/store, spill 수
- 실보드 random operand 1,000회 이상 differential test
- AM1 기준: 15% 이상이면 whole-ladder 진행, 5~15%면 병목 1회 수정, 5% 미만이면 종료

### 2순위: M11 + P07

`AA/BB`, `DA/CB`, 마지막 두 square처럼 실제로 독립인 연산 둘을 `mul2/sqr2`로 묶는다. 먼저 scalar dual-stream으로 시험하고, 그다음 MVE를 비교한다. 이것이 “두 알고리즘이 레지스터를 나눠 쓰는” 문제가 아니라 **같은 X25519 내부의 독립 field operation을 함께 스케줄하는** 방향이다.

### 3순위: L01 + L02 + L03

한 xDBLADD를 융합하여 호출·중간 store·callee-save를 줄인다. 다만 한 번에 모든 X2/Z2/X3/Z3와 임시값을 Q 레지스터에 유지할 수 있다고 가정하지 않는다. 융합 범위를 `mul2` → 반 step → full step 순으로 늘린다.

### 4순위: F01 + F02

keygen 전용 고정기저 ladder다. X-Wing 전체 평균이 아니라 keygen 한 operation에서 큰 별도 레버가 될 수 있다. table은 flash, DTCM, ITCM별로 동일 코드와 함께 측정한다.

### 5순위: P05 + I03 + I04

encaps의 독립 두 X25519를 scalar lockstep으로 먼저 실행한다. ladder 이득이 작더라도 inversion을 zero-safe batch로 묶을 여지가 있다. MVE보다 구현 위험이 낮고 M85의 dual-issue schedule window를 직접 시험할 수 있다.

### 6순위: P03

`vmullb/t.u32`가 실제로 job별 64-bit partial product를 얼마나 싸게 유지하는지 4-limb toy kernel로 확인한다. `vmlaldava`는 2-job 후보에서 제외한다. assembler/disassembly, 정확성, 실보드 cycle 중 하나라도 실패하면 확대하지 않는다.

### 7순위: R05와 R04의 최소 경쟁

16-bit radix 한 개와 radix-2^29 한 개만 골라 `mul+carry`를 만든다. 범용 field library나 whole ladder부터 작성하지 않는다. 둘 다 현재 8×32보다 15% 이상 빠르지 않으면 새 표현 계열을 종료한다.

## 6. 추가로 찾았지만 우선순위를 낮춘 후보

다음 항목도 variation은 맞지만, 현재 목표인 “실제 X-Wing 단일 요청 성능”과 거리가 있거나 위험이 크다.

- 4-job/8-job 서버형 throughput API: batch 처리에는 유효하지만 현재 단일 X-Wing latency 분모와 다름
- Edwards 좌표·Ed25519 backend 재사용: 변환과 protocol 의미 증명이 커서 독립 프로젝트가 됨
- divstep/jumpdivstep: M85에서 current FLT chain보다 빠르다는 근거가 없음
- 전 ladder를 완전히 Q 레지스터 resident로 유지: MVE Q 레지스터 수와 field state 크기상 spill 가능성이 매우 큼
- 64-bit limb를 MVE에서 에뮬레이션: native 64×64 multiply가 없어 우선순위가 낮음
- 여러 bit를 병렬 실행: Montgomery ladder의 bit 간 데이터 의존 때문에 불가
- 단순 `-O3` 또는 auto-vectorize만 적용: assembly와 실제 lane/reduction 구조를 통제하지 못함
- 다시 X25519/Keccak 레지스터 양보 스티칭: T/U/실통합에서 이미 비용 구조가 확인돼 우선순위가 낮음

## 7. 조합 수를 과장하지 않는 방법

53개를 서로 곱하면 수천 조합처럼 보이지만 그렇게 세면 안 된다. 예를 들어 `R05 16-bit radix + P03 vmull + M06 fused reduction + L01 fused step + T02 SLOTHY`는 하나의 구현 계보다. 논문 기여 후보는 다음 12개 가족으로 세는 편이 정직하다.

1. 현재 8×32의 M85 재스케줄
2. 전용 square와 paired field operations
3. fused xDBLADD/custom ABI
4. two-job scalar lockstep
5. two-job MVE
6. one-job limb-parallel MVE
7. 16-bit MVE radix
8. radix-2^29 MVE
9. lazy/integrated reduction
10. inversion 최적화와 zero-safe batch inversion
11. fixed-base keygen
12. ITCM·code-size·자동 스케줄 공동설계

이 12개면 후속 연구 주제로는 충분히 많다. 문제는 아이디어 부족이 아니라, 각 가족을 작은 kill gate로 빨리 탈락시키고 실제 wrapper까지 살아남는 1~2개를 찾는 것이다.

## 8. 실험 공통 gate

모든 후보는 다음 순서로 판정한다.

1. **정적 확인**: 실제 명령 인코딩, lane 의미, register/spill, section 주소
2. **field 정확성**: random/adversarial operand differential test와 범위 invariant
3. **X25519 정확성**: RFC 7748 KAT, random differential, low-order/all-zero 입력
4. **상수시간**: 비밀 의존 branch·address·table index가 없는지 disassembly 확인
5. **실기기 성능**: 같은 Cortex-M85 구현·ELF 세대·메모리 프로파일에서 ABBA, 독립 flash/run 2회
6. **자원**: `.text`, ITCM working set, stack high-water, spill 수
7. **통합**: standalone X25519가 아니라 실제 keygen/encaps/decaps wrapper에서 재측정

한 장치에서 얻은 cycle과 비율은 그 장치의 결과다. Cortex-M85 공통 결론으로 올리려면 최소한 feature set(MVE/cache/TCM), clock/wait-state, code/data placement를 함께 적고, 다른 구현에서는 같은 절차로 다시 측정한다. FVP는 기능·명령 확인에는 쓸 수 있지만 실제 cycle을 대신하지 않는다.

AM1의 기존 kill gate를 그대로 사용한다.

- `mul+carry` 15% 이상 개선: whole-ladder 후보로 진행
- 5~15%: 정적 병목 하나만 수정하고 한 번 재시험
- 5% 미만 또는 회귀: 해당 계열 종료

whole-ladder와 X-Wing 통합에서는 projection을 실제 결과로 쓰지 않는다. 호출 수를 곱한 값은 “추정”으로만 기록한다.

## 9. 추천 실험 순서

```text
AM0  현재 asm의 mul/sqr/inversion/cswap cycle과 명령 구조 분해
 ├─ AM1-S  현재 8×32 M85 scalar 재스케줄 + 전용 square
 │   └─ 성공 → AM2-S mul2/sqr2 → fused xDBLADD
 ├─ AM1-2  두 scalar job lockstep
 │   └─ 성공 → zero-safe batch inversion 포함 encaps 통합
 ├─ AM1-V  vmullb/t 2-job 4-limb probe
 │   └─ 성공 → 8×32 full mul2 → encaps ladder
 ├─ AM1-R  16-bit 대 radix-2^29 mul+carry 경쟁
 │   └─ 승자만 whole ladder
 └─ AFIX   basepoint 9 fixed-base keygen 별도 트랙

각 트랙의 생존 후보만 실제 X-Wing keygen/encaps/decaps에 통합
```

이 순서는 새로운 radix 전체 구현부터 시작하는 일을 피하고, 현재 구현을 활용하는 저위험 후보부터 검증한다.

## 10. 최종 판정

- **variation이 충분히 많은가?** 그렇다. baseline·통제를 포함한 원자적 design entry 53개, 현실적인 실험 가족 12개다.
- **다 유망한가?** 아니다. 직접 우선할 것은 7개이며 나머지는 조건부·후순위다.
- **가장 큰 정정은?** MVE u32는 4 lane이고 `vmlaldava`는 전 lane을 한 scalar 누산기로 합치므로, 단순한 2-job 반반 배치는 틀렸다.
- **레지스터를 안 나누면 되는가?** 기존 T에서 scalar만 15.89% 빨라지고 MVE가 28.25% 느려졌으며, 실제 U 통합도 1.98~3.72% 악화했다. 해결책으로 확인되지 않았다.
- **현재 가장 합리적인 다음 수는?** 8×32 M85 재스케줄, 전용 square, paired field operation, fused xDBLADD를 먼저 하고, fixed-base keygen과 two-job encaps를 별도 트랙으로 시험하는 것이다.

## 11. 주요 외부 근거

- [RFC 7748: Elliptic Curves for Security](https://www.rfc-editor.org/rfc/rfc7748.html)
- [Arm Cortex-M85 공식 제품 사양](https://developer.arm.com/compute-ip/cortex-m85)
- [Armv8.1-M/M85 소프트웨어 최적화 지침](https://developer.arm.com/community/arm-community-blogs/b/architectures-and-processors-blog/posts/armv8_2d00_m-based-processor-software-development-hints-and-tips)
- [Arm: Making Helium — Why not just add Neon?](https://developer.arm.com/community/arm-research/b/articles/posts/making-helium-why-not-just-add-neon)
- [Arm: Helium memory access와 four-beat 구조](https://developer.arm.com/community/arm-research/b/articles/posts/making-helium-going-around-in-circles)
- [Curve25519 for Cortex-M4 and Beyond](https://www.cs.haifa.ac.il/~orrd/LC17/paper39.pdf)
- [High-speed Curve25519 on 8/16/32-bit microcontrollers](https://eprint.iacr.org/2015/343.pdf)
- [Sandy2x: New Curve25519 Speed Records](https://eprint.iacr.org/2015/943.pdf)
- [High-Throughput ECC on AVX2](https://orbilu.uni.lu/bitstream/10993/48810/1/SAC2020.pdf)
- [How to (pre-)compute a ladder](https://eprint.iacr.org/2017/264.pdf)
- [Fiat-Crypto](https://github.com/mit-plv/fiat-crypto)
- [High-assurance field inversion](https://eprint.iacr.org/2021/549.pdf)
- [addchain](https://github.com/mmcloughlin/addchain)
