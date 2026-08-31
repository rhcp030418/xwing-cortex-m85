# X-Wing on Cortex-M85: Architecture-Aware Integration and End-to-End Evaluation

> 저자: 박도윤 (GitHub: [@rhcp030418](https://github.com/rhcp030418))  
> 상태 기준: 2026-08-31, 한국어 LNCS 원고 v32  
> 성격: 연구 노트, 생성기, 실보드 측정 하네스, 원시 로그, 동결 아티팩트와 논문 원고를 함께 보관한 연구 코퍼스  
> 주 실측 장치: Renesas EK-RA8M1의 Cortex-M85, 480 MHz

이 폴더는 하이브리드 KEM X-Wing의 ML-KEM-768과 X25519를 Cortex-M85의 MVE, 제한된 듀얼이슈 폭, 레지스터와 LSU 제약에 맞춰 공동 최적화하고, 각 함수의 개선이 전체 X-Wing API에서도 유지되는지를 동일 ELF 실보드 비교로 검증한 연구 코퍼스다. 명령 수준 스티칭은 검토한 최적화 후보 중 하나이며 연구 전체를 대표하지 않는다.

단일 명령으로 빌드되는 제품용 X-Wing 라이브러리는 아니다. 실험 세대마다 펌웨어, 메모리 배치, ELF와 측정 목적이 다르므로 결과 문서와 동결 아티팩트를 함께 읽어야 한다.

## 제출용 최신 상태

- 최신 정본은 [`paper/ko/main.tex`](paper/ko/main.tex)과 [`paper/ko/main.pdf`](paper/ko/main.pdf)다.
- 최종 동일-ELF 직접 A/B(expDJ, initial A0 대 final B8)의 개선률은 keygen **19.52%**, encaps **19.75%**, decaps warm **11.66%**, decaps cold **15.48%**다.
- 1단계 11.22--25.96%와 2단계 0.928--4.228%는 변환별 귀속 자료이며 최종 수치에 더하거나 곱하지 않는다.
- 재현 절차와 제출 아티팩트 범위는 [`paper/ARTIFACT_README.md`](paper/ARTIFACT_README.md), 상세 원고 상태는 [`paper/README.md`](paper/README.md)에 있다.

아래 결론은 최종 expDJ에 이르는 단계별 연구 기록이며, 대표 총효과는 위의 동일-ELF 직접 비교를 사용한다.

## 현재 결론

- 최종 동일-ELF draft-10 A/B(expCJ)에서 keygen **25.967%**, encaps **20.249%**,
  decaps **11.224%**(warm) · **18.298%**(cold) 개선을 실측했다. 따라서 keygen/encaps는
  20%를 넘었지만 두 decaps 프로파일까지 모두 20%라는 목표는 달성하지 못했다.
- 현재 legacy wrapper에서 채택한 구성은 M85 forward/inverse NTT `X/Y`, current-order store `C8`, MVE packing·CBD·message `C9 v1`, fixed-base comb `X06`이다.
- 같은 ELF의 2×2 완전요인 실험 expAL에서 `X/Y/C8+C9`는 control 대비 keygen **4.29%**, encaps **4.16%**, decaps **7.71%**를 줄였다. 독립 flash/run 2회와 정확성·readback gate를 통과했다.
- 같은 ELF의 expAX에서 개선된 `X06`은 현행 ladder 대비 keygen **16.11%**, encaps **10.83%**를 추가로 줄였고, 적용 지점이 없는 decaps는 **±0.00%**였다. RFC 7748 KAT, 68-seed 차분, full X-Wing 8-seed 출력과 암묵적 거부 검사를 모두 통과했다.
- expAL cell-00과 expAX를 이어 붙인 누적치는 keygen **19.69%**, encaps **14.51%**, decaps **7.72%**지만 서로 다른 ELF를 결합한 **파생 수치**다. 같은 ELF의 00 대 최종 구성 완전요인을 재측정하기 전에는 대표 실측값으로 쓰지 않는다.
- SLOTHY 2-stream 실험 AG는 순차/수동/솔버가 각각 727.036/662.35/654.036 cyc였고, 솔버가 수동 지퍼보다 **1.255%** 빨랐다.
- U 스티칭, AC x4 통합, C9 v2와 X25519 MVE field-arithmetic AM1/AM1b는 정확성 검사를 통과했지만 성능상 기각됐다.
- 4-way MVE Keccak의 상태당 **18.13%** 개선과 M85 NTT primitive의 forward/inverse **47.44/49.98%** 개선은 하위 계층 또는 throughput 성과다. X-Wing 종단간 개선률로 인용하면 안 된다.
- expBA는 M85에서 `umaal` 1/cycle, `adds`·`ldr` 2/cycle과 `umaal`+ALU/`ldr`의 완전 페어링을 실측했다. 이는 `fe25519_mul`·`sqr` 재스케줄 여지가 실재함을 보였지만, 최적화 자체의 성능 향상은 아직 **미측정**이다.

### expAX 최신 same-ELF 수치

| workload | A: 현행 ladder | B: `X06+AX` | conservative 절감률 |
|---|---:|---:|---:|
| keygen | 762,024~762,026 cyc | 639,278~639,290 cyc | **16.11%** |
| encaps | 1,135,095~1,135,105 cyc | 1,012,204~1,012,208 cyc | **10.83%** |
| decaps | 809,721~809,723 cyc | 809,704~809,711 cyc | **±0.00%** |

이 표는 기존 `X/Y/C8+C9` 구성 위에서 fixed-base 두 지점(keygen `pkX`, encaps `ctX`)만 `X06`으로 바꾼 직접 A/B다. expAL의 cell-00 대비 전체 누적 효과가 아니다. 상세 조건과 동결 해시는 [expAX 결과](measure-harness/2026-08-26_expAX_results.md)에 있다.

### 가장 중요한 준거성 경계

expAL의 대표 수치는 IETF draft-10 준거 구현이 아니라 ePrint 2024/039 §7.3 Figure 12 정의를 따른 동결 legacy wrapper 내부의 상대효과다.

| 경계 | expAL 동결 wrapper | draft-10 목표 경로 |
|---|---|---|
| combiner | label이 입력 선두 | `ssM \|\| ssX \|\| ctX \|\| pkX \|\| label` |
| key 상태 | 구성요소 expanded state 직접 생성 | packed 32-byte key를 `SHAKE256`으로 확장 |
| encapsulation | 내부 난수 사용, ML-KEM encapsulation-key check 없음 | 64-byte seed 분할과 FIPS 203 key check |
| decapsulation | expanded-key warm workload | packed-key cold와 expanded-key warm을 분리해야 함 |

이 경계는 expBU에서 draft-10 절대값과 packed-key cold 성능을, expCJ에서 최종 동일-ELF
누적률을 재측정해 해소했다. expAL 값은 여전히 “ePrint 2024/039 legacy wrapper,
same-ELF 상대효과”로만 인용한다. 최신 수치는 [expCJ 결과](measure-harness/2026-08-27_expCJ_results.md)와
[논문 데이터 표](논문_데이터_표.md) T26이 정본이다.

### expAL 동결 수치

| workload | control 00 | treatment 11 | 대표 절감률 |
|---|---:|---:|---:|
| keygen, expanded state 직접 생성 | 796,007~796,081 cyc | 761,811~761,847 cyc | **4.29%** |
| encaps, encapsulation-key check 없음 | 1,184,040~1,184,056 cyc | 1,134,806~1,134,825 cyc | **4.16%** |
| decaps, expanded-key warm | 877,484~877,526 cyc | 809,797~809,817 cyc | **7.71%** |

상세 계산, run별 conservative 판정과 해시는 [expAL 결과](measure-harness/2026-08-24_expAL_results.md) 및 [동결 아티팩트](measure-harness/artifacts/2026-08-24_expAL/)에 있다.

### 병목 귀속과 X06 이후 재기준화

expAN의 깨끗한 최상위 계측에서 X25519 비중은 keygen **46.96%**, encaps **63.02%**, decaps **44.13%**였다. expAO~AS는 Keccak, ML-KEM 비-Keccak, matacc와 X25519 field operation을 차례로 분해했다. 아래 장부는 **X06 채택 전** 세대다.

encaps 기준 expAN~AS 장부는 다음과 같다.

| 블록 | 비중 | 근거 성격 |
|---|---:|---|
| X25519 `mul` | 26.1% | 문맥 내 호출 수·단가 실측을 깨끗한 분모에 적용한 투영 |
| X25519 `sqr` | 22.5% | 문맥 내 호출 수·단가 실측을 깨끗한 분모에 적용한 투영 |
| ML-KEM Keccak permutation | 22.4% | 문맥 내 직접 누산 |
| X25519 `add+sub` | 10.5% | 문맥 내 호출 수·단가 실측을 깨끗한 분모에 적용한 투영 |
| ML-KEM matacc, permutation 제외 | 8.0% | probe build 내부 귀속 |
| 나머지 ML-KEM | 5.5% | probe build 내부 귀속 |
| X25519 ladder 잔여 | 4.0% | 차분 장부; 내부 세분은 미측정 |
| X-Wing combiner | 0.7% | 직접 계측 |
| 미귀속 | 약 0.3% | probe·세대 결합 뒤 남은 회계 잔차 |

probe wrapper가 수천 번 호출되는 expAR/AS의 총 cycle은 계측 오버헤드가 크므로 성능 기준선으로 사용하지 않는다. 깨끗한 절대 cycle 기준은 expAN이고, expAO~AS는 귀속용이다.

X06 채택 뒤 expAY는 field-op 호출 수를 같은 ELF에서 다시 계측하고, 깨끗한 expAX 총합에 실측 단가를 적용했다.

| workload | 깨끗한 expAX 총합 | `mul+sqr` 투영 | `add+sub` 투영 |
|---|---:|---:|---:|
| keygen | 639,278 cyc | 95,900 cyc (**15.0%**) | 19,676 cyc (**3.1%**) |
| encaps | 1,012,208 cyc | 371,319 cyc (**36.7%**) | 79,352 cyc (**7.8%**) |
| decaps | 809,704 cyc | 275,419 cyc (**34.0%**) | 59,676 cyc (**7.4%**) |

이 표의 호출 수와 단가는 실측이지만, 값은 `호출 수 × 단가`를 깨끗한 총합에 적용한 **투영**이다. inversion 내부 11 mul+4 sqr은 계측 shim을 우회해 소스 계수로 보정했으며, 직접 누산값으로 취급하지 않는다. X06 뒤 주 표적은 encaps·decaps의 variable-base ladder에 남은 `mul`·`sqr`이다. expBA에서 스칼라 듀얼이슈 여지는 확인됐지만 `ldm`/`stm` 차단 폭과 실제 재스케줄 이득은 **미측정**이다.

X06 트랙은 AT-0/AT-1 기능 gate를 통과하고, AT-2의 성능 gate 실패 뒤 AV에서 재설계됐다. AW의 full X-Wing A/B와 AX의 후속 개선이 정확성·성능 gate를 통과해 legacy wrapper 경로에는 **채택**했다. 다만 33,024 B 고정표를 사용하며 draft-10/FIPS 203 준거 경로는 아니다. 준거 대표값 트랙은 baseline을 복구하는 E0이 우선이고, 이후 같은 API profile에서 다시 측정해야 한다.

## 무엇부터 읽을까

문서의 날짜와 실험 세대가 다르다. 충돌할 때는 아래 순서를 따른다.

1. [XWing_CortexM85_통합_variation.md](XWing_CortexM85_통합_variation.md) — 최신 준거성 감사, expAN~AS 귀속, X06 채택과 expAY/BA 후속 판단.
2. 각 실험의 `measure-harness/*_prereg.md` → `*_results.md` → `logs/` → `artifacts/` — 개별 주장에 대한 1차 근거.
3. [A주제_총정리_육하원칙.md](A주제_총정리_육하원칙.md) — 전체 이야기와 expAL까지의 종합. 준거성 경계와 expAN 이후 결과는 1번 문서로 보완한다.
4. [PQC_스티칭_연구_로드맵.md](PQC_스티칭_연구_로드맵.md) — 실험이 바뀐 이유와 시간순 변경 이력. 문서 상단의 오래된 상태 bullet과 존재하지 않는 과거 링크보다 날짜가 붙은 변경 이력을 우선한다.
5. [논문_데이터_표.md](논문_데이터_표.md) — expAL까지의 표·그림 수치. 최신 프로토콜 정정과 expAN 이후 결과는 아직 모두 합쳐져 있지 않다.
6. [공부_가이드.md](공부_가이드.md) — 암호·M85·스티칭·SLOTHY를 기초부터 읽는 안내서. 일부 결과 설명은 2026-08-20 시점이다.

`*.bak-*` 파일은 정본이 아니다. `artifact/README.md`, `measure-harness/README.md`, `paper/README.md`, `slothy-2stream/README.md`에는 각각 2026-08-17~21 시점의 상태가 남아 있으므로 최신 대표 결론의 단독 근거로 사용하지 않는다.

## 디렉터리 구조

| 위치 | 역할 |
|---|---|
| [`measure-harness/`](measure-harness/) | 실보드 하네스, harvester, 사전등록, 결과 문서, 원시 로그와 동결 ELF/SREC/map. 최신 측정 근거의 중심 |
| [`slothy-2stream/`](slothy-2stream/) | Armv8.1-M/M85 SLOTHY 패치, 두 스트림 생성기, 솔버 입력·출력과 실험 로그 |
| [`artifact/`](artifact/) | 2026-08-17 v0.1 조기 재현 패키지. 최신 전체 펌웨어가 아니라 당시 board/host 소스 모음 |
| [`asm-practice/`](asm-practice/) | M4/M55 QEMU 기능·KAT 연습, M85 compile/link 확인 |
| [`paper/`](paper/) | 한국어 작업 정본 `ko/main.tex`, 이전 영문판 `en/main.tex`, 참고문헌과 빌드 스크립트 |
| [`papers/`](papers/) | X-Wing, FIPS 203, RFC 7748, SLOTHY, Keccak 등 외부 참고자료 |
| [`pqmx-mve-ntts/`](pqmx-mve-ntts/) | pqmx `mve-ntts` 작업 스냅샷, commit `1eeaf85` |
| [`pqmx-upstream/`](pqmx-upstream/) | 비교용 pqmx `main` 스냅샷, commit `89465b9` |

`A주제/` 자체는 하나의 독립 Git 저장소가 아니며 두 `pqmx-*` 폴더는 각각 별도 Git 저장소다. 각 폴더의 라이선스와 이력을 따로 확인한다.

## 결과 표기 규칙

이 폴더에서 다음 용어를 구분한다.

| 표기 | 의미 |
|---|---|
| **실측** | EK-RA8M1에서 정확성 gate를 통과한 뒤 DWT CYCCNT로 직접 측정 |
| **투영** | 측정한 커널 단가를 호출 수에 곱해 상위 연산으로 확장 |
| **혼합 장부** | 서로 다른 통합 수준이나 ELF 세대의 절감량을 산술 결합 |
| **상한** | 비용을 모두 숨긴다는 이상적 가정에서의 최대 가능량 |
| **역사값** | 당시 문서에는 있으나 현재 생성물과 같은 모집단으로 재현할 수 없는 값 |
| **미측정** | 현재 보존 자료로 직접 확인하지 못했거나 아직 결과 gate가 닫히지 않은 항목 |

ELF, code/data placement, 입력, wrapper와 API profile 중 하나라도 다르면 같은 세대로 합치지 않는다. QEMU cycle, probe build 총 cycle, primitive 개선률과 종단간 개선률도 서로 대체할 수 없다.

## 환경

| 구분 | 확인된 환경 |
|---|---|
| 실보드 | EK-RA8M1, R7FA8M1AH, Cortex-M85, BSP 기본 CPUCLK 480 MHz |
| 배치 | 대표 hot asm은 ITCM, 데이터·측정 스택은 DTCM; 큰 코드는 실험별로 flash 사용 |
| 측정 | DWT CYCCNT, 반복 N=100 중앙값과 calib 차감; 후기 채택 판정은 ABBA와 독립 flash/run 사용 |
| Windows | e2 studio 2026-04.2, FSP 6.5.0, GNU Arm GCC 13.2.1 |
| 보드 도구 | SEGGER J-Link V9.68 x64, Python 3.14, `pylink-square` |
| WSL | Ubuntu 24.04, GNU make, `arm-none-eabi-gcc`, `qemu-system-arm`, SLOTHY venv |
| 원고 | XeLaTeX+kotex(한국어), pdfLaTeX(영문), Biber |

이 보드 개체는 ITCM 0x18/0xE0 고착 결함을 `itcm_pad.c`로 회피했고 PMU event counter가 반응하지 않아 성능 수치는 DWT로 측정했다. 다른 Cortex-M85 제품이나 보드에 결과를 일반화하지 않는다.

## 빠른 기능 검증

다음 명령은 WSL에서 `A주제/`를 현재 디렉터리로 두고 실행한다.

```bash
# X25519·Keccak M85 compile/link
make -C asm-practice m85-check

# 같은 Armv8.1-M+MVE 프로파일의 M55 QEMU 기능 프록시
make -C asm-practice run-ex2-m55
make -C asm-practice run-ex3-m55

# 초기 측정 하네스의 M85 링크와 M55 구조 실행
make -C measure-harness m85
make -C measure-harness run-m55
```

기대 결과는 `M85 LINK OK`, X25519 `EX2 PASS`, SHA3 `EX3 PASS`, 하네스 `HARNESS DONE`이다. QEMU는 DWT/PMU를 에뮬레이션하지 않으므로 counter가 0이어도 정상이다. QEMU 수치를 성능 결과로 사용하지 않는다.

## SLOTHY 최소 재현

외부 SLOTHY 사본에 멱등 패치를 적용한 뒤 가장 작은 17명령 예제를 실행한다.

```bash
python3 slothy-2stream/patch_slothy_v81m.py /path/to/slothy
cd slothy-2stream
/path/to/slothy/venv/bin/python run_exp_a.py exp_a.s /tmp/exp_a_opt.s
```

기대 결과는 9 cycles, IPC 1.89, `OPTIMAL`, `EXP_A_DONE`이다. 현재 `run_exp_*.py` 일부는 `/home/cnscjs1395/slothy`를 하드코딩하므로 다른 머신에서는 해당 경로 또는 `sys.path`를 먼저 고쳐야 한다. LLVM 도구가 없으면 binary self-test는 비활성화되고, 최종 정확성 근거는 보드 KAT와 differential gate다.

## 원고 빌드

Windows PowerShell에서 다음을 실행한다.

```powershell
cd .\paper
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\build.ps1 ko
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\build.ps1 en
```

2026-08-25 재검증 결과는 한국어 11쪽, 영문 10쪽이며 둘 다 `errors=0`, `undefined=0`이다. 원고 편집 기준은 [paper/ko/main.tex](paper/ko/main.tex)이지만, 이 한국어 원고에도 늦게 확인된 ePrint 2024/039 대 draft-10 준거성 경계가 아직 반영되지 않았다. 영문판은 최신 한국어 수치까지 뒤처져 있으므로 어느 쪽도 현재 상태 그대로 투고용 정본으로 사용하지 않는다.

## 동결 아티팩트 무결성 확인

대표 expAL 패키지는 소스, ELF, SREC, map, 로그, 빌드 메타데이터와 해시 manifest를 포함한다.

```bash
cd measure-harness/artifacts/2026-08-24_expAL
sha256sum -c SHA256SUMS.txt
```

2026-08-26 README 감사에서 expAL~BA의 manifest 16개에 기록된 **381개 파일이 실패 0건**으로 재검증됐다.

## README 감사에서 다시 확인한 것

- `asm-practice`: M85 X25519·Keccak compile/link 통과, M55 QEMU에서 RFC 7748·SHA3 KAT 통과.
- `measure-harness`: M85 링크 통과, M55 QEMU가 `HARNESS DONE`까지 실행됨. counter 0은 QEMU의 정상 한계다.
- `slothy-2stream`: 17명령 예제가 9 cycles, IPC 1.89의 `OPTIMAL`에 도달.
- `paper`: 한국어 11쪽·영문 10쪽, 양쪽 모두 errors 0·undefined 0.
- 2026-08-25: expAL~AT harvester 10개의 parser/layout `--self-test` 전부 통과. 이 검사는 J-Link나 보드를 실행하지 않는다.
- 2026-08-26: AW/AX/AY/BA의 독립 2-run 원시 로그, 결과 문서, 최신 variation 장부에서 판정·수치·한계를 교차 확인.
- 2026-08-26: expAL~BA 동결 manifest 16개, 381개 파일의 SHA-256 전부 일치.

2026-08-26 README 갱신에서는 보드를 새로 플래시하거나 빌드 산출물을 다시 만들지 않았다. 최신 실보드 성능·정확성 판정은 보존된 두-run 원시 로그, readback 해시, 결과 문서와 동결 아티팩트를 교차 확인했다. 위 기능·원고 검증 항목은 2026-08-25 실행 기록이다.

## 실보드 재측정

> 주의: 아래 명령은 연결된 EK-RA8M1의 flash를 실제로 덮어쓴다. e2 studio 디버그 세션을 닫고, 대상 보드와 동결 이미지가 맞는지 확인한 뒤 실행한다.

대표 expAL 동결 이미지를 다시 플래시하고 RAM 로그를 회수하는 명령은 다음과 같다.

```powershell
$Python = 'C:\Users\cnscj\AppData\Local\Programs\Python\Python314\python.exe'
& $Python .\measure-harness\artifacts\2026-08-24_expAL\harvest_ra8m1_expAL.py `
  --elf .\measure-harness\artifacts\2026-08-24_expAL\blinky.elf `
  --srec .\measure-harness\artifacts\2026-08-24_expAL\blinky.srec
```

확인할 출력은 code-flash readback `PASS`, `KAT ALL PASS`, 모든 mismatch/stack gate 0, `harness_fails=0`, `HARNESS DONE`이다.

이 회수기는 이 머신의 GNU Arm `nm`과 J-Link DLL 절대 경로를 포함한다. 다른 설치 경로에서는 상수를 수정해야 한다. `run_expAL.ps1`은 전체 build→freeze→2-run→report 파이프라인이지만 기존 결과 덮어쓰기를 거부하므로 현재 채워진 작업 트리에서 quick start로 실행하면 중단된다. 새 실험은 새 ID·출력 경로와 사전등록을 먼저 만든다.

## 재현성·정확성 원칙

- 새 성능 주장은 사전등록, 같은-ELF 비교, 독립 flash/run 2회, KAT·differential·stack gate와 raw log를 함께 남긴다.
- 결과는 `measure-harness/<experiment>_results.md`, 원시 출력은 `logs/`, 재실행 재료는 `artifacts/`에 둔다. `staging/`과 `__pycache__/`는 근거가 아니다.
- 같은 이름의 커널이라도 날짜, ELF 해시, section 배치나 wrapper가 다르면 별도 세대로 기록한다.
- 실패 run과 음성 결과도 삭제하지 않고 실패 원인과 채택 여부를 남긴다.
- 비밀 의존 branch·주소·table index, decapsulation reject/cmov 생략을 금지한다. 현재 timing evidence는 정적 감사와 제한된 입력 비교이며 전력·EM까지 포함한 완전한 누설 증명은 아니다.

## 알려진 한계와 미측정 항목

- draft-10/FIPS 203 준거 full X-Wing, 외부 draft vector, malformed encapsulation-key 경로
- packed-key cold와 expanded-key warm의 분리 성능 및 메모리·zeroization 비용
- 다른 Cortex-M85 구현, 물리 M55/M52 비교군, 에너지 소비
- 대규모 통계 타이밍 검정, 전력·EM 부채널과 fault-injection 내성
- 2026-08-16~17 일부 원시 로그, 2026-08-21 일부 ELF/map, 최초 AE run1
- 최종 채택 구성 전체의 same-ELF 00 대 treatment 완전요인 재측정
- X25519 variable-base `mul`·`sqr`의 실제 재스케줄 이득과 `ldm`/`stm` 발행 차단 폭
- 머신별 절대 경로를 제거한 완전한 one-command clean-room 빌드

## GitHub 공개 전 확인

- `A주제/` 전체를 포괄하는 단일 라이선스는 현재 없다. 공개·재사용 조건을 정하려면 프로젝트 라이선스를 별도로 추가한다.
- `papers/`의 외부 논문 PDF와 X25519, pqmx, CMSIS, SLOTHY 사본은 각각의 저작권·재배포 조건을 확인한다.
- 두 `pqmx-*` 폴더는 별도 Git 저장소 스냅샷이다. 공개 저장소에 포함할지, submodule이나 출처 링크로 바꿀지 결정한다.
- 로그·스크립트의 사용자명, 절대 경로, 장치 식별 정보와 불필요한 ELF/SREC/PDF 빌드 산출물을 공개 범위에 넣을지 검토한다.

외부 자료는 각 하위 폴더의 원 라이선스를 따른다.
