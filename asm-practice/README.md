# asm-practice — ARM 어셈블리 연습장 (보드 불필요, QEMU)

0단계 체크박스 "ARM 어셈블리 기초" 용 연습 환경. WSL 터미널에서:

```bash
cd /mnt/d/dropbox/박도윤개인과제/asm-practice
make run-ex1    # 배열 합 어셈블리 (연습용)
make run-ex2    # X25519 KAT — 스트림 A 재료 검증 (참고용)
```

## 파일 구성

| 파일 | 역할 |
|---|---|
| `startup.s` | 벡터 테이블 + 리셋 핸들러 (CPU가 켜지면 제일 먼저 도는 코드) |
| `link.ld` | 메모리 배치도 (코드 0x0, RAM 0x2000_0000 — QEMU mps2-an386 기준) |
| `uart.c/.h` | 출력(printf 대용) + QEMU 종료 |
| `ex1_sum.s` | **네가 고칠 파일.** 배열 합 루프 + 과제 3개 |
| `ex1_main.c` | ex1 채점기 (C 정답과 비교, PASS/FAIL) |
| `x25519/` | Lenngren의 X25519 Cortex-M4 어셈블리 (2단계 스티칭 재료, 원본: github.com/Emill/X25519-Cortex-M4) |
| `ex2_x25519_main.c` | RFC 7748 §6.1 공식 벡터로 X25519 검증 |

## 과제 (ex1_sum.s 주석에도 있음)

1. **명령 4개 루프**: 지금 루프는 원소당 5명령(cbz/ldr/add/subs/b). `subs`가 남긴 플래그로 분기하는 `bne`를 써서 4개로 줄여라. 고친 뒤 `make run-ex1`이 여전히 PASS여야 함.
2. **2개씩 언롤**: `ldrd r3, r4, [r0], #8`로 원소 2개씩 처리. r4를 쓰면 `push {r4}`/`pop {r4}` 필수 — 안 하면 왜 터지는지도 직접 겪어봐라 (n=100은 짝수라 홀수 처리 생략 가능).
3. **생각 문제**: M4(싱글이슈)는 명령 수 ≈ 사이클 수. M85(듀얼이슈, 2인승)에서는 이 등식이 왜 깨지나? 이 루프에서 어떤 두 명령이 같은 사이클에 나란히 탈 수 있을까?

고치다 막히면 에러/출력 그대로 들고 올 것.

## 주의

- QEMU는 **기능만** 검증한다 (사이클 수 무의미). 사이클 측정은 보드(EK-RA8M1) 도착 후 DWT/PMU로.
- 지금은 `-mcpu=cortex-m4`로 빌드. 보드 오면 `-mcpu=cortex-m85`로 재빌드해 같은 코드를 실기에서 돌린다.

## M85 크로스컴파일 + M55 QEMU 실행 검증 (2026-08-13 — 보드 도착 전 선검증)

- `make m85-check`: ex2(X25519)·ex3(Keccak)을 **-mcpu=cortex-m85로 컴파일+링크 통과** (GCC 13.2.1). QEMU에 M85 머신이 없어 실행은 불가 — 실행 검증은 아래 M55 프록시로 대체.
- `make run-ex2-m55` / `run-ex3-m55`: **mps3-an547(Cortex-M55)에서 KAT 전부 PASS**. M55는 M85와 같은 Armv8.1-M+MVE 프로파일이라 기능 프록시로 유효 (마이크로아키텍처는 다름 — 성능 수치는 여전히 무의미). 부수 효과: MVE 명령을 돌릴 수 있는 실험장이 생김 → 2단계 플랜 B(스칼라×MVE) 예행 가능.
- 구현 메모: an547은 UART 주소가 an386과 달라 `-DSEMIHOST`(uart.c의 세미호스팅 콘솔)로 우회. link.ld RAM은 an547 DTCM(512KB)에 맞춰 512K로 축소 — an386과 겸용, 스크립트 1개 유지. 벡터 테이블 0x0 그대로 부팅됨.
- X-Wing 레퍼런스는 M85 크로스컴파일 **생략**: ref 구현이 호스트 라이브러리 lib25519에 링크되는 구조라 무의미. M85용 X-Wing은 어차피 우리 조립(스트림 A+B+결합기)이고, ref는 테스트 벡터 정답지 역할만.

## 스트림 B 플래그(APSR) 안전성 검사 결과 (2026-08-13 — 2단계 선행 조건 통과)

로드맵 2단계 첫 항목 "플래그 안전성 확인"을 보드 없이 선실행. 방법: `arm-none-eabi-objdump -d ex3.elf`에서 `KeccakF1600_StatePermute` 본체(0xa00~0x219a, 명령 1,532개)만 잘라 니모닉 집계.

- **S-형 데이터 처리 명령 0개.** 본체는 eor.w(608)·ldr(437)·str(226)·bic.w(200)·mov.w(54) 등 전부 플래그 중립 — X25519의 adds/adcs 캐리 체인 사이에 끼워도 합법.
- **유일한 APSR 접촉 = 라운드 루프 제어 1쌍**: 라운드 말미의 `cmp r7, #255`(라운드 상수 종결자 검사) + `bne.w` — 라운드당 1회, 본체 1,532개 중 2개.
- **스티처에 넘길 제약**: X25519 캐리 체인이 라운드 경계를 넘어 살아 있으면 안 됨 (경계 정렬 또는 라운드 언롤로 해결). 그 외 제약 없음.
- 치환 작업 불필요 → KAT 재통과만 재확인 (`make run-ex3` PASS, 2026-08-13).
- 부수 관찰: 본체가 r0~r9, sl, fp, ip (GP 13개)를 전부 사용 → 플랜 A의 레지스터 압박 우려 실증. 플랜 B(스칼라×MVE) 승격 판단과 부합.
- 재현: `make ex3.elf && arm-none-eabi-objdump -d ex3.elf | awk '/<KeccakF1600_StatePermute>:/,/<keccak_inc_finalize>:/' | grep -E '\b(adds|subs|movs|eors|ands|orrs|bics|orns|mvns|lsls|lsrs|asrs|rors|rsbs|adcs|sbcs|muls|teq|tst|cmn|cmp)\b'`
