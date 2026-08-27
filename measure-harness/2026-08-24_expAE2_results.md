# 실험 AE2 결과 — 실제 U(`yield1+b1`) 직접 통합 재측정

> **후속 정정(실험 AF):** 이 문서의 U assembly는 일반 code flash에 배치되어 있었고,
> 13.3 KiB U8 instruction working set의 큰 fetch 비용이 섞였다. 동일작업 Flash/ITCM
> 통제 뒤 대표 종단간 값은 **−1.98/−3.72/−1.88%**로 교체한다. 본 문서의 큰 악화값은
> 역사적 진단으로만 남긴다. U8-only ITCM 통제에서 `P8−2P4=−3.56~−3.23k/batch`로
> 2-job 고유 추가 손실이 사라져 배치 원인을 확인했다. 현재 정본은
> `2026-08-24_expAF_results.md`다.

## 질문과 비교군

- 질문: 실험 U에서 선택한 `r11-fixed + low-contiguous b1` 스티칭을 임의 피연산자의 실제
  X25519 Montgomery ladder에 넣었을 때도 이득이 남는가?
- `F`: 같은 Fiat 10×25/26 X25519와 같은 x4 Keccak 경로를 순차 실행한다.
- `U`: `F`와 같은 일을 하되 실제 ladder의 곱셈과 b1 조각을 교차 실행한다.
- 주 판정은 구현 차이를 제거한 `F→U`다. `S→U`는 기존 Lenngren/scalar 경로에서 실제 U
  전체로 바꾼 실용 차분이며 보조 결과다.
- 최초 파일럿은 잔여 ladder 곱셈에도 큐 탐색·나머지 연산 dispatcher가 남아 있었으므로
  사전 등록한 단일변수 비교가 아니었다. 이를 제거하는 보정안을 측정 전에 기록한 뒤
  AE2를 두 번 새로 실행했다.

## 주 결과: 동일 Fiat 기준 `F→U`

음수 절감은 성능 악화다. 수치는 AB/BA 중 더 보수적인 차분이다.

| 연산 | run 1 | run 2 | 판정 |
|---|---:|---:|---|
| keygen | −54,814 cyc (−4.14%) | −54,784 cyc (−4.14%) | 실패 |
| encaps | −442,632 cyc (−19.81%) | −441,924 cyc (−19.78%) | 실패 |
| decaps | −55,600 cyc (−3.99%) | −55,620 cyc (−3.99%) | 실패 |

두 run의 부호와 크기가 일치한다. 따라서 매크로커널 U의 8.54/10.32/7.82%(평균
8.89%)는 **실제 U 종단간 결과가 아니라 과거 투영 진단값**으로만 남긴다. 다만 AE2의
전체 차분만으로 ladder 제어·상태·API 비용 각각을 분리했다고 쓰지는 않는다. 현재까지
확정한 원인과 아직 미분해인 잔차는 아래와 같다.

## 보조 결과: 기존 경로 `S→U`

이 비교에는 Fiat X25519 구현 교체, x4 배칭, 실제 U가 함께 들어가므로 원인 귀속에는 쓰지
않는다.

| 연산 | run 1 | run 2 |
|---|---:|---:|
| keygen | −605,943 cyc (−78.37%) | −606,043 cyc (−78.39%) |
| encaps | −1,517,679 cyc (−130.98%) | −1,517,276 cyc (−130.94%) |
| decaps | −607,676 cyc (−72.17%) | −607,630 cyc (−72.17%) |

별도 `S→X` 차분에서 x4 배칭만의 손실은 두 run 모두 약 2.1~3.2%로 재현됐다. 논문에서
채택할 실제 종단간 성능 성과는 이 후보가 아니라 앞서 직접 통합·측정한 X/Y/C8의
keygen **+2.85%**, encaps **+1.54%**, decaps **+3.25%**다.

## 왜 느렸나 — 확정·국소화·미측정의 구분

### 1. 확정: 잔여 scalar dispatcher 세금

최초 AE는 융합 구간이 끝난 뒤 남은 ladder도 매 field multiplication마다 queue 탐색과
나머지 연산 dispatcher를 통과했지만, F는 같은 구간을 direct loop로 실행했다. AE2에서
이를 제거하자 손실이 다음만큼 줄었다. 아래 값은 보존한 AE 로그와 AE2 run 1의 보수적
차분을 비교한 진단값이다.

| 연산 | 최초 AE 손실 | AE2 손실 | 제거된 dispatcher 손실 |
|---|---:|---:|---:|
| keygen | 206,092 cyc | 54,814 cyc | **151,278 cyc** |
| encaps | 730,410 cyc | 442,632 cyc | **287,778 cyc** |
| decaps | 206,994 cyc | 55,600 cyc | **151,394 cyc** |

한 X25519 job인 keygen/decaps에서 약 15.1만 cycles, 두 job인 encaps에서 약 28.8만
cycles가 사라졌다. 따라서 최초 큰 손실의 상당 부분이 스티칭 자체가 아니라 비대칭
dispatcher였다는 점은 실측으로 확정됐다.

### 2. 코드로 확인: 매크로 U가 없던 경계를 실제 U가 반복한다

과거 매크로 U는 `unit * 4/8 + MVE round`를 하나의 wrapper 안에 넣어 144-byte Fiat
frame과 b1 주소 상태를 한 번만 구성했다. 실제 AE2는 데이터 의존성을 지키기 위해 field
multiplication마다 C의 `job_step()`으로 돌아온 뒤 다음 asm fragment를 호출한다.

- 한 Keccak round마다 1-job은 U4 함수 4개, 2-job은 U8 함수 8개를 호출한다.
- 각 fragment는 GP 보존·144-byte frame 진입/이탈을 수행하고 `phase0_setup()`으로
  r11/q7 주소 상태를 다시 만든다.
- 융합 구간은 `fiat_x25519_step(fiat_mul_fn)`의 전역 job 상태와 간접 함수 호출을 거친다.
- 정적 명령 수는 scalar mul 1개가 443개인 데 비해, U4 한 round가 2,447개
  (`4×443` 대비 +675), U8 한 round가 4,279개(`8×443` 대비 +735)다. 이 증가는
  유효한 b1 round 명령도 포함하므로 그 자체를 손실 cycle로 등치하지 않는다.

즉 매크로 투영과 AE2는 산술량만 같고 실행 경계는 같지 않다. 매크로에서 레지스터·frame
상태가 지속되던 구간이 실제 경로에서는 여러 C/asm 경계와 코루틴 상태 전환으로 잘렸다.
이 차이가 존재한다는 것은 코드로 확정했지만 각 항목의 cycle 기여는 아직 따로 측정하지
않았다.

### 3. 확정: x4 배칭만으로는 AE2 손실을 설명할 수 없다

같은 펌웨어의 `S→X` 차분에서 x4 배칭만의 손실은 연산당 약 24.6~25.0k cycles였다.
주 판정 `F→U`는 F와 U 모두 같은 x4 경로와 같은 Fiat 구현을 쓰므로, U의
54.8~442.6k 손실을 x4 자체 탓으로 돌릴 수 없다.

### 4. 국소화됐지만 미분해: encaps 2-job/U8 추가 손실

1-job 잔차는 keygen/decaps에서 약 54.8~55.6k cycles다. 이를 job 두 개로 단순 배수하면
약 110.4k cycles가 예상되지만, encaps 잔차는 441.9~442.6k cycles다. 따라서 단순
2배를 넘는 **추가 331.5~332.2k cycles**가 `pending>=2`의 U8/두-job 교대 경로에
국소화된다.

이 추가 손실의 세부 원인이 fragment별 ABI/setup 반복인지, U8 분할에서의 실제
파이프라인 stall인지, 간접 호출·전역 job 상태 트래픽인지 현재 측정만으로는 확정할 수
없다. 그러므로 현 결론은 다음처럼 제한한다.

> **확정 결론:** 현재의 C-코루틴형 실제 U 구현은 느리다. 매크로 U의 양의 투영은 이
> 통합 경계 비용을 포함하지 않았다. 그러나 이 결과만으로 function stitching 자체가
> 종단간에서 원리적으로 불가능하다고 결론내리지는 않는다.

다음 원인 분해는 (1) 실제 U4/U8 fragment 단독 cycle, (2) encaps에서 1-job U4 두 번과
2-job U8 교대의 단일변수 비교, (3) fragment별 setup 유지/제거 비교 순서로 해야 한다.
이 세 항목은 **미측정**이며 후속 측정 전에는 결과처럼 쓰지 않는다.

## 정확성·측정 조건

- EK-RA8M1 Cortex-M85, ABBA, 각 셀 N=100, 독립 실행 2회.
- RFC 7748 X25519 KAT 4개와 SHA3 KAT 통과.
- x4 primitive KAT 0 fail, true-U primitive KAT 0 fail.
- 8-seed X-Wing full-output/reject byte mismatch 0, smoke/timing mismatch 0.
- stack/canary fail 0, stack high-water 9,012 B, `harness_fails=0`.
- ELF SHA-256: `54448E01EA503E7A3571923CEE3162311080C9C4E6A69AEF6C1C25D355904109`
- SREC SHA-256: `F2C94BB63058FF7B67DCBAD68048D8884BA3620E6C3DB363A400F3C532809FF5`
- 하네스 SHA-256: `751972E64EC02DA14CDCDF25971EF1A7DE15EF69C13FA3460F91ACDB3A086CDF`
- Fiat C SHA-256: `2E0647A4C045F7E260F3633496B1B689A50B472CD8617CDA4AB846E82B565B3E`
- U asm SHA-256: `BD7E5BD9585691E4F4EC3319E9A3C1729D6E07473D402F56B0D506CC7C2CA11A`

원시 로그:

- `logs/2026-08-24_expAE2_true_u_direct_finish_run1.txt`
- `logs/2026-08-24_expAE2_true_u_direct_finish_run2.txt`

사전 등록과 보정 기록:

- `2026-08-24_expAE_true_u_endtoend_prereg.md`
- `2026-08-24_expAE2_direct_finish_amendment.md`
