# 실험 AF 결과 — B-full 재현과 AE2 U8 손실의 코드 배치 원인

## 결론

1. 현재 B-full 솔버와 수동 v6의 차이는 **656.011 대 662.35 cycles**, 즉 솔버가
   **0.96%** 빠르다. 사전등록 허용오차 ±1% 안이므로 현재 아티팩트에서는 **동률**로
   판정한다. 2026-08-16의 `681→657(−3.5%)`은 같은 세대 역사값으로만 남긴다.
2. AE2 encaps의 설명되지 않던 약 332k cycles는 U8 계산 구조 자체보다 **U assembly를
   일반 code flash에 둔 배치 오류**가 주원인이다. U8은 13.3 KiB instruction working set을
   flash에서 왕복했고, 기존 hot kernel은 ITCM에 있었다.
3. 동일 작업 24-round 배치에서 `P8−2P4`는 flash **114.35~114.75k**에서 all-U ITCM
   **5.96~6.02k cycles**로 약 **95% 감소**했다. 더 엄격하게 U8만 ITCM으로 옮기자
   **−3.56~−3.23k cycles**가 되어, 2-job 고유 추가 손실은 사라졌다. 실제 연산당
   3배치에서 제거된 약 **325k cycles**는 미설명 손실과 일치한다.
4. ITCM에 바로잡은 실제 종단간 `F→U`는 keygen **−1.98%**, encaps **−3.72%**,
   decaps **−1.88%**다. 여전히 성능 실패여서 U는 채택하지 않지만, 과거의
   −4.14/−19.78~−19.81/−3.99%는 **잘못된 flash 배치가 섞인 값**이므로 대표 결과에서
   내린다.

모든 확정 run에서 RFC 7748, SHA3, x4/U primitive, X-Wing full-output/reject,
timing, stack/canary와 실험 AF state/output gate가 통과했고 `harness_fails=0`이었다.

## 1. 진행 순서

### 1.1 AF1 — 현재 B-full 아티팩트 고정

현재 `stitch_zip.py:round_stream6()`의 B 644개와 `exp_b.s` 솔버 입력의 마지막 B 644개를
정규화해 비교했고 **644/644 명령이 완전 일치**했다. 따라서 “솔버가 옛 B를 내장했다”는
가설을 철회했다. 사전등록 뒤 동일 ELF를 변경하지 않고 EK-RA8M1에서 독립 실행 5회를
수집했다. 각 실행은 N=100 중앙값이며 DWT 측정 오버헤드 25 cycles를 차감했다.

### 1.2 AF2 counter pilot — 실제 호출 수 확인

U4/U8 round와 `fiat_x25519_step()`의 real/dummy 경로에 임시 counter를 넣은 진단
펌웨어를 한 번 실행했다. 결과는 다음과 같다.

| 연산 | U4 rounds | U8 rounds | real steps | dummy steps |
|---|---:|---:|---:|---:|
| keygen | 72 | 0 | 288 | 0 |
| encaps | 0 | 72 | 576 | 0 |
| decaps | 72 | 0 | 288 | 0 |

즉 세 연산 모두 24-round 배치 **3개**만 실행하며, ladder 완료 뒤 dummy 곱셈은 없었다.
counter가 들어간 pilot 성능값은 최종값으로 쓰지 않았다.

### 1.3 AF2 동일작업 마이크로벤치

counter를 제거하고 같은 초기 Keccak x4 state와 같은 X25519 job으로 아래를 ABBA,
N=100으로 측정했다.

- 1-job 순차: Keccak 24 rounds + scalar Fiat ladder step 96개
- 1-job U4: 같은 작업을 U4 fragment로 융합
- 2-job 순차: Keccak 24 rounds + scalar Fiat ladder step 192개
- 2-job U8: 같은 작업을 U8 fragment로 융합

queue 준비와 입력 복사는 측정 밖에 두고, pack/unpack, RC staging, q-save/restore와 실제
C/asm 경계는 포함했다. 각 측정 뒤 direct finish한 X25519 출력과 Keccak state 전체를
순차 reference와 비교했다.

### 1.4 AF2-P 코드 배치 단일변수

counter pilot ELF에서 주소와 크기를 확인했다.

| 코드 | 주소 | 전체 크기 |
|---|---:|---:|
| 기존 hot `KeccakF1600_StatePermute` | `0x00003200` | ITCM |
| 기존 hot `mul256_flat6` | `0x0000b110` | ITCM |
| AE U4 p0~p3 | `0x02084310...` | 약 7.9 KiB, flash |
| AE U8 p0~p7 | `0x02086210...0x02089674` | 약 13.3 KiB, flash |

명령열을 바꾸지 않고 U assembly section만 `.itcm_code_from_flash`로 옮겼다. 64 KiB ITCM
공간을 확보하기 위해 이번 질문과 무관한 실험 E 커널만 flash로 이동했다. 최종 map에서
U는 `0x00006610...0x0000be84`, ITCM limit은 `0x0000c6d0`이고 정렬 포함 끝은
`0x0000c800`으로 용량 안이다. Flash와 ITCM 조건을 각각 독립 2회 측정했다.

### 1.5 AF2-P2 — U8-only ITCM 단일변수

all-U ITCM 조건은 공간 확보를 위해 무관한 실험 E를 옮겼으므로, 인과를 한 변수로 더
좁혔다. E는 원래 ITCM으로 복구하고 scalar/U4/qsave는 flash에 그대로 둔 채 U8 p0~p7만
ITCM으로 옮겼다. 최종 map은 E가 `0x000049a0...`, U8이
`0x0000b110...0x0000e574`, scalar/U4가 `0x02087280...`였고 ITCM 정렬 끝은
`0x0000ee00`으로 64 KiB 안이었다. 이 조건도 독립 2회 측정했다.

## 2. AF1 결과 — B-full

5회 모두 다음 중앙값이 정확히 같았고 모든 gate가 통과했다.

| 항목 | cycles |
|---|---:|
| 현재 A(flat6) | 394.76 |
| 현재 B(round6) | 397.13 |
| 수동 v6 stitch | 662.35 |
| B-full 순차 | 726.011 |
| B-full 솔버 | 656.011 |

솔버와 수동 v6의 차이는 `662.35−656.011=6.339 cycles`, 수동 대비 **0.957%**다.
두 경로는 같은 B 명령열과 같은 논리 작업을 수행하지만 A 재료와 wrapper가 다르므로,
이를 순수 스케줄러 우위로 일반화하지 않는다. 현재 판정은 **±1% 안 동률**이다.

함께 재현된 현재 세대 계보는 `round v4 stitch=780.55 cycles`,
`round6 v6 stitch=662.35 cycles`, `k=2 stitch=999.39 cycles`다. 역사값
`799→681`은 현재 `780.55→662.35`로 이동했지만 개선 방향은 같다.

## 3. AF2 결과 — 동일작업 비용

`P4=U4−1-job 순차`, `P8=U8−2-job 순차`다. 아래 범위는 AB/BA 두 방향과 독립 run
두 번의 전체 범위다.

| 배치 | Flash | ITCM | 변화 |
|---|---:|---:|---:|
| 1-job 순차 | 85.388~85.544k | 85.202~85.210k | 기준 |
| U4 | 91.868~91.988k | 87.148~87.168k |  |
| `P4` | **6.334~6.504k** | **1.944~1.964k** | 약 −70% |
| 2-job 순차 | 153.696~153.754k | 153.562~153.580k | 기준 |
| U8 | 281.010~281.120k | 163.472k |  |
| `P8` | **127.256~127.422k** | **9.892~9.910k** | 약 −92% |
| `P8−2P4` | **114.348~114.754k** | **5.964~6.022k** | 약 −95% |

U8 고유분 감소는 배치당 약 108.4k, 실제 3배치에서 약 **325k cycles**다. 따라서
AE2의 추가 약 332k가 fragment ABI, queue search, dummy work 때문이라는 이전 추정은
기각된다. 직접 확인된 주원인은 **큰 U8 instruction working set × code-flash 실행**이다.

all-U ITCM에서도 `P8−2P4≈6k/batch`가 남았다. 이를 U8 자체의 고유 비용으로
해석할 수 있는지 확인하기 위해 P2를 수행했다.

### 3.1 U8-only ITCM 인과 확인

| 항목 | run 1 AB / BA | run 2 AB / BA |
|---|---:|---:|
| `P4` (U4는 flash 유지) | 6,676 / 6,766 | 6,840 / 6,786 |
| `P8` (U8만 ITCM) | 10,124 / 10,126 | 10,122 / 10,128 |
| `P8−2P4` | **−3,228 / −3,406** | **−3,558 / −3,444** |

U4 비용은 flash 조건의 약 6.3~6.5k와 같은 규모에 머문 반면 U8 비용만
127.3k에서 약 10.1k로 내려갔다. `P8−2P4`가 음수가 되었으므로 U8에는 2×U4를 넘는
고유 추가 비용이 없다. 종단간 encaps 손실도 **85.86~85.93k**로 keygen 손실
**43.91~44.17k**의 약 2배가 되어, 기존 약 332k 불균형이 사라졌다. 따라서 큰 추가
손실의 원인은 **U8 instruction fetch 배치 하나로 확정**한다.

all-U ITCM의 `P8−2P4≈6k`는 U4까지 ITCM으로 옮겨 `P4`의 기준 자체가 크게 줄어든
조건에서 나온 차분이다. P2 결과에 따라 이를 U8 고유 구조 비용으로 인용하지 않는다.
all-U 종단간에 남은 1.9~3.7%를 pipeline stall, fragment setup, C 상태 트래픽으로
세분하는 것은 아직 **미측정**이다.

## 4. 종단간 결과 교체

| 배치 | keygen | encaps | decaps |
|---|---:|---:|---:|
| Flash run 1 | −41,566 (−3.14%) | −442,922 (−19.82%) | −43,302 (−3.11%) |
| Flash run 2 | −41,624 (−3.14%) | −442,902 (−19.82%) | −43,180 (−3.10%) |
| ITCM run 1 | −26,291 (−1.98%) | −83,462 (−3.72%) | −26,302 (−1.88%) |
| ITCM run 2 | −26,362 (−1.98%) | −83,434 (−3.72%) | −26,298 (−1.88%) |

음수는 악화다. ITCM 결과도 모두 음수라 사전등록상 **정확성 성공·성능 실패**이며 U는
채택하지 않는다. 다만 실패 폭과 해석은 바뀐다. 실제 구현 경계의 잔여 비용은 약
1.9~3.7%이고, encaps 20% 악화는 U의 본질적 결과가 아니라 배치 오류였다.

## 5. 재현 정보

- 보드: Renesas EK-RA8M1, Cortex-M85, SWD 4 MHz
- compiler: Arm GNU 13.2.1, `-O2`, `-ffixed-r11`
- Flash 확정 ELF: `DC8301FB37992FBA5F72695636A5F2D5D286D42DBFAD3F36AF4C2314CFA1DFC5`
- Flash 확정 SREC: `FA3DE3825CF3EED57E9F7BD749380FCE5178616CB04640E9392D5D43B40EB050`
- ITCM 확정 ELF: `305D7F40F5289852A5F683073B55D75135115BA7E2061379D31A3A3EF5BC9C60`
- ITCM 확정 SREC: `06E4E4434214CB6371CE870E795FA61355174B53C303988B7364BF7B6DE18FE7`
- U8-only 진단 ELF: `D8B65DA532CA37DEA59C817AB6B0F30EC2B6A64D8AB924A3DD5BFBB5D66BCA5D`
- U8-only 진단 SREC: `A9706FCC53411B77E19D91984454D56057B3907EAFEE613286FF201C50E03311`
- 최종 harness SHA-256: `6AD3E85F3F5CFCEC4BC0B4136E36037086E1FE23195337FBAB422A61580CCA0D`
- 최종 U assembly SHA-256: `9E27C8D978D75DD31F713B89453AF5219BB1AF3CFAC0E8D567486887AC36850B`
- U8-only 진단 assembly SHA-256: `E8DB9AE21DC4C819421600330A56EC3F9CD7C50328E822D8E47121E9B48A5B04`

원인 분리 뒤 대표 all-U ITCM 소스를 다시 생성·빌드했고 ELF/SREC가 위 ITCM 확정 해시와
바이트 단위로 일치했다. 따라서 최종 작업 트리는 진단용 U8-only가 아니라 대표 구성이다.

확정 로그:

- `logs/2026-08-24_expAF_bfull_run1.txt` ~ `run5.txt`
- `logs/2026-08-24_expAF_flash_run1.txt`, `run2.txt`
- `logs/2026-08-24_expAF_itcm_run1.txt`, `run2.txt`
- `logs/2026-08-24_expAF_u8only_itcm_run1.txt`, `run2.txt`

진단 전용 로그:

- `logs/2026-08-24_expAF_counter_pilot.txt`
