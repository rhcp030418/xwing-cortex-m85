# 실험 AO 결과 — X-Wing 내 Keccak permutation in-context 실측

> 측정 2026-08-25. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, 독립 flash/run 2회.
> 선행: `2026-08-25_expAN_results.md`. 원시 로그: `logs/2026-08-25_expAO_run{1,2}.txt`

---

## 1. 무엇을 닫았나

expAN §5는 `permutation 수(실측) × keccak-f1600 단독 5,504 cyc(실측)`의 **곱**으로
Keccak이 ML-KEM의 54.5~58.8%라고 했다. 곱은 투영이지 실측이 아니다. cache·ITCM·주변
코드 상태가 다르면 in-context 단가가 달라질 수 있다.

이 실험은 permutation이 **실제 X-Wing 실행 문맥에서** 몇 cycle을 쓰는지 직접 누산한다.

## 2. 방법

`fips202.c`에 이미 있던 셈 shim `KeccakF1600_StatePermute_counted`에 누산기를 붙였다.
새 계측 지점을 만들지 않고 기존 지점을 재사용했다.

```c
static void KeccakF1600_StatePermute_counted(uint64_t *state)
{
    g_keccak_perm_calls++;
    if (g_keccak_prof_enable) {
        uint32_t t = EXPAO_CYCCNT;
        KeccakF1600_StatePermute(state);
        g_keccak_perm_cyc += EXPAO_CYCCNT - t;
    } else {
        KeccakF1600_StatePermute(state);
    }
}
```

`prof_enable=0`이면 분기 하나를 지나는 것 말고는 기존과 같은 경로다.

### 2.1 probe 왜곡을 두 층으로 분리해 보고한다

| 층 | 측정법 | 값 (run1 / run2) |
|---|---|---|
| ① probe **활성** 비용 (같은 ELF, off↔on) | 같은 연산을 prof off/on 두 번 측정 | keygen +1,381/+1,361 · encaps +1,453/+1,425 · decaps +1,451/+1,441 cyc<br>= **31~32 cyc/call** |
| ② probe **존재** 비용 (AN ELF ↔ AO ELF) | expAN 빌드의 prof-off 총합과 대조 | keygen +2,077 · encaps +2,724 · decaps +2,507 cyc |

②는 분기·volatile load·코드 배치 변화 때문이며 **비활성 상태에서도 든다**. 따라서
**절대 cycle의 정본은 여전히 expAN(AN 빌드)이고**, 이 문서의 비중 계산은 전부 AO 빌드
안에서 자기일관하게 한다(AN 슬롯 362..375가 같은 ELF에 살아 있으므로 가능하다).
두 빌드의 숫자를 섞지 않는다.

## 3. 핵심 결과 — 투영이 옳았다

| 연산 | permutation 누산 (실측) | calls | **cyc/call** | 단독 참조 | 차이 |
|---|---:|---:|---:|---:|---:|
| keygen | 237,952 | 43 | **5,533.8** | 5,504 | **+0.54%** |
| encaps | 254,526 | 46 | **5,533.2** | 5,504 | **+0.53%** |
| decaps | 254,517 | 46 | **5,533.0** | 5,504 | **+0.53%** |

두 run에서 cyc/call은 소수 첫째 자리까지 동일했다.

누산 창은 `[첫 판독 완료 … 둘째 판독 완료]`라서 **둘째 `EXPAO_CYCCNT` 판독 지연이
누산값 안에 포함돼 있다.** 즉 참값은 5,533보다 조금 더 작고, 단독 5,504에 더 가깝다.

> **결론: X-Wing 문맥에서 Keccak permutation의 in-context 단가는 단독 측정값과
> 측정 오차 수준에서 같다.** cache/ITCM 배치로 인한 페널티가 관측되지 않는다.
> expAN §5의 투영은 **실측으로 확인됐고**, 앞으로 `perms × 5,504`를 쓰는 것은
> 정당하다(이 배치·이 보드에 한해).

## 4. permutation 수의 rejection sampling 변동

| 연산 | calls 중앙값 | calls 산포 (100 rep) | Keccak cyc 산포 |
|---|---:|---:|---:|
| keygen | 43 | **43~45** | 237,892~249,036 |
| encaps | 46 | 46~46 | 254,502~254,589 |
| decaps | 46 | 46~46 | 254,493~254,553 |

keygen만 흔들리고 encaps/decaps는 고정이다. 원인은 명확하다: keygen은 rep마다 새
공개 seed로 행렬 A를 전개하므로 rejection sampling 횟수가 달라지고, encaps/decaps는
100 rep 내내 **같은 pk**를 쓰므로 A 전개가 동일하다. **공개 seed 의존 변동이며 비밀
의존이 아니다.** expAN이 keygen `c1`에서 관측한 산포(402,952~417,489)의 정체가 이것이다.

> **정정**: 하네스가 출력하는 `keccak perms/op: keygen 43 encaps 44 decaps 44`는
> `mlkem_smoke()`가 자기 시드로 **ML-KEM 단독** 호출을 한 번 잰 스냅샷이다. 이 실험의
> 워크로드(시드 `0xa1ab5a5au`)에서 X-Wing 전체 encaps/decaps는 **46**이며, 그 차이는
> ① 다른 공개 seed의 rejection 변동과 ② combiner permutation 1회다. 두 값을 같은
> 것으로 취급하면 안 된다.

## 5. combiner 직접 분해 — expAN 추정의 실측 확인

combiner 단독 슬롯(두 run 동일):

```
total 8,051 cyc = permutation 5,514 + glue 2,537
```

expAN §4.3은 `8,035 − 5,504 = 2,531 cyc`로 glue를 **추정**했다. 직접 측정값은
**2,537 cyc**로 6 cyc 차이다. **W11/W12의 상한이 실측으로 확정됐다.**

## 6. 종합 — AO 빌드 자기일관 분해 (run1)

| 연산 | total | X25519 | ML-KEM Keccak | ML-KEM 비-Keccak | combiner |
|---|---:|---:|---:|---:|---:|
| keygen | 764,020 | 357,834 (**46.8%**) | 237,952 (**31.1%**) | 168,202 (**22.0%**) | — |
| encaps | 1,137,572 | 715,165 (**62.9%**) | 254,526 (**22.4%**) | 159,802 (**14.0%**) | 8,051 (0.7%) |
| decaps | 812,666 | 357,495 (**44.0%**) | 254,517 (**31.3%**) | 192,578 (**23.7%**) | 8,051 (1.0%) |

X-Wing 한 연산을 통틀어 가장 큰 단일 블록 순서:

1. **X25519** — encaps 62.9%, keygen 46.8%, decaps 44.0%
2. **ML-KEM Keccak** — decaps 31.3%, keygen 31.1%, encaps 22.4%
3. **ML-KEM 비-Keccak**(NTT·matacc·basemul·CBD·packing·verify 전부 합쳐서) — 14.0~23.7%
4. **combiner** — 0.7~1.0%

ML-KEM 내부만 보면 Keccak이 **56.9~61.4%**로 과반이다.

## 7. 정확성 게이트 — 전부 PASS (두 run)

```
expAO equiv: bytes-mm=0 checks=40
expAO bench: stack-fails=0 stack-used=7848
harness_fails=0, KAT ALL PASS
```

| 게이트 | 결과 |
|---|---|
| prof on 출력 대 prof off 출력, 8 seed × (pk/sk/ct/ss_e/ss_d) | mismatch 0 |
| 기존 전체 하네스 KAT·mismatch (expX~expAN 포함) | 전부 0 |
| stack canary | 0, high-water 7,848 B |
| code-flash readback run1 = run2 | `9E8FA320…BDBB` (717,704 B) |

## 8. 한계·미측정

1. **ML-KEM 비-Keccak 잔여의 내부 세분은 여전히 미측정이다.** 168k/160k/193k가
   NTT·invNTT·matacc·basemul·CBD·packing·verify로 어떻게 쪼개지는지는 Z2 계보의
   profiler build를 현행 경로에서 다시 돌려야 나온다. Z2(2026-08-21)의 값은 C8/C9
   채택 이전 코드의 것이라 그대로 쓸 수 없다.
2. **절대 cycle 정본은 expAN이다.** AO 빌드는 비활성 probe 때문에 연산당 2.1~2.7 kcyc
   느리다(§2.1 ②). 이 문서의 절대값을 X-Wing 대표값으로 인용하면 안 된다.
3. in-context 단가 결론은 **현재 ITCM/flash 배치**에 한정된다. C9 ITCM 이동이나 AM1b의
   `fiat_u_stitch_m85.o` 퇴거처럼 배치가 바뀌면 다시 재야 한다.
4. legacy wrapper workload 기준이다(combiner 순서 label 선두, ek check 없음,
   decaps expanded-key warm). draft-10 준거 이동 뒤 재측정 대상이다.
5. EK-RA8M1 한 개체다. 다른 Cortex-M85로 일반화하지 않는다.

## 9. 다음 작업

1. **ML-KEM 비-Keccak 내부 재귀속** — Z2 profiler를 현행 X/Y/C8+C9 경로에서 재실행.
   유일하게 남은 큰 미측정 블록이다(14.0~23.7%).
2. **X06 fixed-base ladder** — 분모 715,663 cyc(expAN §4.2-2). 여전히 최대 단일 표적.
3. **K19/K20/K21 Keccak 후보** — 분모가 실측으로 확정됐다(237,952~254,526 cyc,
   X-Wing의 22.4~31.3%). `perms × 5,504` 산수를 이제 정당하게 쓸 수 있다.
4. **W11/W12** — glue 2,537 cyc 실측 확정. 우선도 하향 유지.

## 10. 아티팩트

동결: `artifacts/2026-08-25_expAO/` (+ `SHA256SUMS.txt`)

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` | `38F2E56FF2381EF47BD6E3DA8FF16C43461DB1274C481A9BDED37A5ABFF4EE13` |
| `blinky.srec` | `54800DFDC71442E3925478CE50A6E70985302A2D910DE24B8C2780FBF7F8C9F1` |
| `blinky.map` | `8C00C8F65D18357F315553CE7FEBE2521A304D2014681FA5D06C3AF7E7B5A970` |
| `expAO_slots.inc` | `7219A8C0BB05DBA5F8D1C3EC90EE663B7192C19403141F0C697BA1D97702D6D4` |
| `fips202.c` (누산기 포함) | `33884648028838B3F6BCC4E19A97A18A44F813B967F8340D78F5975C09EF173C` |
| `harvest_ra8m1_expAO.py` | `C0890258DBC04B2489CFCF6387DE66D84E5E5B554D13FA309345B393E82E05AC` |
| code-flash readback (run1=run2) | `9E8FA320B782A8B78384FEBB7EC05DCE13326CA3C0D3350464258E66FAD4BDBB` (717,704 B) |
| `logs/2026-08-25_expAO_run1.txt` | `2E523FE2E2AEAAE93BCB2DD356F21884541C0941C08B3A85E2751B7717E9211B` |
| `logs/2026-08-25_expAO_run2.txt` | `19CE070A1626FC22C5085722BB0E2ADA7D6579043F791B51E5C13E53CD95CB69` |

하네스 변경: `harness.c`에 `REP_SLOTS 376→390`, `#include "expAO_slots.inc"`,
`expao_run_all()` 3줄. `keccak/fips202.c`에 누산기 3 전역 + shim 분기.
백업 `keccak/fips202.c.bak-20260825-expAO`.
