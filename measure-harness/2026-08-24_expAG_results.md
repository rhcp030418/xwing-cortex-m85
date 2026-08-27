# 실험 AG — 현재 round6 지퍼 대 SLOTHY 재대결

사전등록: `2026-08-24_expAG_current_round6_solver_prereg.md`  
보드: EK-RA8M1 / Cortex-M85  
측정: 독립 flash/run 2회, 각 N=100 중앙값, calib 25 차감

## 판정

**성공.** 두 run 모두 새 솔버 **654.036cyc**, 수동 `stitched-round6`
**662.35cyc**로 정확히 재현됐다. 솔버는 같은 빌드의 수동 지퍼보다 **1.255%**, 순차보다
**10.041%** 빠르다. 사전등록 조건 `solver <= stitched-round6`을 충족하므로 3단계 성공
조건을 유지한다.

08-16의 727/681/657cyc는 역사 세대 비교로만 남긴다. 이번 결과는 현재 재료·현재
ELF 안에서 순차·지퍼·솔버를 직접 비교한 정본이다.

## 입력 재생성과 솔브

- 생성기가 보고한 실제 본문은 A **540** + B **644** = **1,184명령**이다. 프롬프트의
  B 647은 함수 래퍼 3명령을 포함한 수이며 솔버 입력 본문은 644명령이다.
- 현 작업공간에는 `mul256_flatY.s`의 최초 생성 원본이 남아 있지 않았다. 따라서 A는
  동결 백업의 첫 540개 정규화 명령을 재사용했다. 그 이전 A 생성 계보는 **미확인**이다.
- 재생성한 `exp_b.s`의 SHA-256은 백업과 동일했다. 즉 현재 `round_stream6()` B는 이미
  기존 솔버 입력에 들어 있었으며, B 갱신 자체는 음성 결과였다.
- 같은 입력을 새로 푼 결과는 기존 `exp_b_opt.s`와 달랐다. SLOTHY self-check와
  `split_heuristic_full_with_stalls`는 통과했고 모델값은 **599cyc, IPC 1.98, 최소 stall
  7**이었다. 실보드 654.036cyc는 모델보다 **9.188%** 느렸다.

## 실보드 결과

| 항목 | run 1 | run 2 | 솔버 대 기준 |
|---|---:|---:|---:|
| B-full 순차 | 727.036 | 727.036 | −10.041% |
| 수동 `stitched-round6` | 662.35 | 662.35 | −1.255% |
| 새 B-full 솔버 | **654.036** | **654.036** | — |

두 run 모두 다음 정확성 게이트를 통과했다.

- RFC 7748/SHA3 KAT 전체 통과.
- `bfull_slothy` product/lane mismatch 0, `bfull mismatch=0`.
- `stitched-round6`를 포함한 전체 하네스 mismatch 0.
- `harness_fails=0`.

J-Link가 플래시 직후 CPU 저속 경고를 stderr로 냈지만 두 수집기는 끝까지 실행되어
`HARNESS DONE`과 `harness_fails=0`을 기록했다. 경고는 성능 run 제외 조건에 해당하지
않았다.

## 재현 아티팩트와 SHA-256

| 파일 | SHA-256 |
|---|---|
| 솔버 입력 `exp_b.s` | `66DD4835005EFE3571BAD6E20C879AD175C874124FC9CF61E2D8ADA37879EAF2` |
| 이전 솔버 입력 백업 | `66DD4835005EFE3571BAD6E20C879AD175C874124FC9CF61E2D8ADA37879EAF2` |
| 새 솔버 출력 | `D5C69D2F46A8082D62F800E84BEF37111FAEA6FAA187F468BC76327DEAA9DED6` |
| 이전 솔버 출력 백업 | `4F02A36A0E70D3522950095E59531E05CD1B7C7DD89FAEF7C675BCDD851FF9C6` |
| 새 솔브 로그 | `E8B96AD5C16C6B8B66169CE0333AD4738EAC7DB9962685C744BE62816224E169` |
| 보드용 B-full 소스 | `687461C6EEA55BE1CFD57AC37A166525DEEEE81EA04428E5BDC9B3D4C0F7B8B9` |
| 측정 ELF | `4D1AB5EF6CF0271CD9A9176D838D0F818CBFE5692C5963C0E555E52C3BD65F7E` |
| 측정 SREC | `7D46E02FAE596CFEA2E8B4AA2B804150FB36A3BE0F58BEF7304677E0A9D319DC` |
| run 1 원시 로그 | `83D886A2C1338C9BE5B6B64610FEDDB196DC30611375B95283F6240DE32DFE18` |
| run 2 원시 로그 | `C33FE64C47B8954D88B1D3CD083BA24951C9AC4743A34CD429EE3F9CB8217334` |

동결 묶음은 `artifacts/2026-08-24_expAG/`, 원시 로그는 `logs/`에 보존했다.
