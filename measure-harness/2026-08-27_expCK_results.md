# 실험 CK 결과 — 동일 Fiat+x4 기준 슬롯 회계

- 측정일: 2026-08-27
- 보드: EK-RA8M1, Cortex-M85
- 판정: **빈 총용량은 실재하지만 같은 작업 U는 국소·종단간 모두 회귀**

## 1. 동결 대상

- ELF: `artifacts/2026-08-24_expAI/pre_expAI_blinky.elf`
  - SHA-256 `305D7F40F5289852A5F683073B55D75135115BA7E2061379D31A3A3EF5BC9C60`
- SREC: `artifacts/2026-08-24_expAI/pre_expAI_blinky.srec`
  - SHA-256 `06E4E4434214CB6371CE870E795FA61355174B53C303988B7364BF7B6DE18FE7`

기존 F→U 대표 결과를 만든 all-U ITCM 확정본을 수정하지 않고 그대로 사용했다.

## 2. 사전등록 대비 계측 변경

사전등록은 PMU가 동작하지 않는 조건에서 같은 컴파일러 산출물을 에뮬레이션해 명령 수를
셀 예정이었다. 실제 실행에서는 더 직접적인 방법을 사용했다.

- 함수 입구에 hardware breakpoint를 걸고 실제 Cortex-M85를 복귀까지 한 명령씩
  J-Link single-step했다.
- 매 step의 실행 PC를 같은 ELF의 disassembly와 대조해 동적 명령 수와 클래스를 셌다.
- 따라서 cycle만 보드이고 명령 수는 에뮬레이터인 혼합 계측이 아니라, 둘 다 같은 보드·ELF다.
- 대신 single-step trace는 고정 입력 한 경로씩이다. 함수의 컴파일된 분기는 고정 loop와
  job-count dispatch뿐이고 KAT·출력 동등성은 별도 두 flash에서 통과했지만, 사전등록의
  “에뮬레이터 두 입력 출력 대조”를 수행한 것은 아니다.

이 변경은 결과를 본 뒤 판정식을 바꾼 것이 아니라 계측을 더 직접적으로 만든 방법 변경이다.
IPC와 빈 슬롯 정의는 사전등록 그대로다.

## 3. 정확성 게이트와 종단간 재측정

독립 2회 flash 모두 다음을 통과했다.

- `harness_fails=0`
- x4 KAT, U KAT, X-Wing byte/smoke/timing mismatch 0
- stack/canary failure 0, stack 사용 9,028 B
- F/U 같은 ELF, 같은 wrapper와 ITCM 배치

두 run의 네 ABBA pair에서 얻은 보정 중앙값 범위다.

| 연산 | F 범위 (cyc) | U 범위 (cyc) | 보수적 F→U |
|---|---:|---:|---:|
| keygen | 1,329,386–1,329,489 | 1,355,772–1,355,812 | **−26,426 cyc (−1.99%)** |
| encaps | 2,245,430–2,245,453 | 2,328,878–2,328,900 | **−83,469 cyc (−3.72%)** |
| decaps | 1,398,492–1,398,544 | 1,424,780–1,424,782 | **−26,290 cyc (−1.88%)** |

원시 로그: `logs/2026-08-27_expCK_run{1,2}.txt`.

## 4. 같은 작업 F/U 구간

1-job은 x4 Keccak 24 rounds 뒤 Fiat step 96회, 2-job은 같은 x4 뒤 step 192회다.
setup·queue는 DWT 구간 밖이다.

| 구간 | F cyc | U cyc | U−F | U 회귀 |
|---|---:|---:|---:|---:|
| 1-job | 85,196–85,210 | 87,138–87,168 | +1,942–1,958 | **+2.28–2.30%** |
| 2-job | 153,562–153,576 | 163,472–163,480 | +9,900–9,914 | **+6.45–6.46%** |

세 배치로 환산한 local U 회귀는 1-job 5.83–5.87k, 2-job 29.70–29.74k cyc다.
이는 종단간 손실의 약 22%/36%만 설명한다. 나머지는 wrapper 문맥·상태 전이·호출
경계의 합성 잔차이며 이 실험만으로 개별 원인에 귀속하지 않는다.

## 5. 실제 보드 동적 명령 수와 클래스

| 구간 | 동적 명령 | cycle | IPC | `2×cycle−instruction` | 빈 용량 |
|---|---:|---:|---:|---:|---:|
| 1-job F | 105,310 | 85,196–85,210 | 1.2359–1.2361 | 65,082–65,110 | 38.20% |
| 2-job F | 195,900 | 153,562–153,576 | 1.2756–1.2757 | 111,224–111,252 | 36.22% |

| 실행 명령 클래스 | 1-job | 2-job |
|---|---:|---:|
| scalar load/store | 43,656 | 86,884 |
| scalar ALU/shift | 27,804 | 55,814 |
| scalar multiply/MAC | 15,574 | 31,532 |
| MVE load/store | 7,392 | 7,392 |
| MVE ALU/shift | 7,416 | 7,416 |
| branch/loop | 3,468 | 6,862 |
| **합계** | **105,310** | **195,900** |

두 trace 모두 `completed=True`, 미분류 PC 0이다. 실제 사용한 Binutils 2.41이 일부 MVE
load/store를 legacy `ldc`/`stc` alias로 표시하므로 원 MVE 소스와 주소를 대조해
MVE load/store로 분류했다.

원시 로그:

- `logs/2026-08-27_expCK_icount_seq4.txt` (653.182 s)
- `logs/2026-08-27_expCK_icount_seq8.txt` (1,281.020 s)

## 6. x4 공통 구간과 debugger bracket

1-job F의 입구부터 `unpack4` 복귀 직후까지 직접 추적했다.

- x4 공통 prefix: **16,445 instruction**
- 클래스: branch 266, MVE ALU/shift 7,416, MVE load/store 7,392,
  scalar ALU/shift 369, scalar load/store 1,002
- 미분류 PC 0
- hardware-breakpoint DWT: 첫 회 22,520, 이후 9회 모두 **22,460 cyc**

한 개의 32-bit `push`만 사이에 둔 대조도 첫 회 112, 이후 9회 모두 76 cyc였다.
따라서 22,460에는 debugger 재개·정지 고정비가 있다. 이를 정확한 커널 시간으로 부르지
않고, 빼지 않은 raw 값을 사용해 파트너 길이와 상한을 관대하게 잡았다.

원시 로그:

- `logs/2026-08-27_expCK_icount_seq4_x4prefix.txt`
- `logs/2026-08-27_expCK_prefix_cycles.txt`
- `logs/2026-08-27_expCK_breakpoint_overhead.txt`

## 7. 동결 U의 실제 배치 수

동결 ELF를 수정하지 않고 U 연산 함수의 mode 1 입구부터 복귀까지 hardware breakpoint로
동적 호출을 셌다.

| 연산 | `permute4` 24R 호출 | `x25519_u_enqueue` |
|---|---:|---:|
| keygen | 3 | 1 |
| encaps | 3 | 2 |
| decaps | 3 | 1 |

최초 probe는 벤치 전용 `keccak4_round_b2_rc`에 breakpoint를 걸어 round call 0을 얻었다.
실제 U는 `permute4` 안의 fused round 경로를 쓰므로 그 probe는 배치 수 자료에서 제외했다.
정정 probe는 `permute4` 자체를 직접 세었다.

원시 로그:

- 채택: `logs/2026-08-27_expCK_frozen_path_counts.txt`
- 제외 probe: `logs/2026-08-27_expCK_frozen_path_count_round_probe.txt`

## 8. 같은-F 슬롯 상한

x4 공통 스트림을 B로 두면 `I_B=16,445`, 관대한 raw `C_B=22,460`이다.

| 구간 | `I_A` | `C_A` | `S_A=2C_A−I_A` | `S_A×C_B/I_B` |
|---|---:|---:|---:|---:|
| 1-job | 88,865 | 62,736–62,750 | 36,607–36,635 | 49,997–50,035 |
| 2-job | 179,455 | 131,102–131,116 | 82,749–82,777 | 113,016–113,054 |

두 경우 모두

```text
O = min(C_B, C_A, S_A × C_B / I_B) = 22,460 cyc/batch
```

로 파트너 길이에 막힌다. 동결 U에서 직접 센 배치가 연산당 3개이므로 종단간 낙관 상한은
`3×22,460/F`다.

| 연산 | 같은-F 슬롯 상한 | 실제 F→U |
|---|---:|---:|
| keygen | **+5.07%** | **−1.99%** |
| encaps | **+3.00%** | **−3.72%** |
| decaps | **+4.82%** | **−1.88%** |

`2×cycle−instruction`은 MVE 다중사이클 점유와 금지된 발행쌍을 공제하지 않은 구조적
2-issue 용량이다. PMU event counter가 0만 반환하므로 클래스별 빈 슬롯·stall cycle은
측정하지 못했다. 실행 명령 클래스와 총 용량을 보고할 뿐, 빈 슬롯 전부를 합법적 동시발행
슬롯이라고 주장하지 않는다.

## 9. 제외한 계측 시도

- 비 ASCII SREC 경로 때문에 flash 전에 실패한 최초 실행: 보드 측정으로 세지 않음.
- `restart(num_instructions=N)` batch probe 두 번: J-Link가 N개 뒤 정지하지 않고 return
  breakpoint까지 실행해 명령 수 자료에서 제외.
- `keccak4_round_b2_rc` path-count probe: 실제 U fused 경로의 심볼이 아니어서 0회;
  `permute4` 정정 측정으로 대체.

실패한 시도를 성공 자료로 재해석하지 않았고 가능한 로그는 그대로 보존했다.
