# 실험 DB 결과 — 전체 solver 후보는 별칭 정확성 게이트에서 기각

> 실행 2026-08-28. 사전등록: `2026-08-28_expDB_full_solver_prereg.md`.  
> 성능 결론이 아니라 **정확성 실패에 따른 후보 폐기 결과**다.

## 판정

네 phase 전체와 r2–r9 재할당을 푼 solver 산출물은 생성·어셈블·링크까지 성공했지만 실제 X25519 별칭 계약을 보존하지 못했다. 전체 보드 실행에서 `KAT ALL PASS`였음에도 expDB 전용 비교가 실패했으므로, 사전등록 §3에 따라 **F/U/Ut/Us cycle은 전부 폐기한다.** 독립 2회 측정 조건은 정확성 게이트 실패로 진행하지 않았다.

## solver·정적 게이트

- p0–p3 각각 607명령(phase 0은 606), 각 36개 창: 총 **144/144 `OPTIMAL`**, **144/144 내부 selfcheck 통과**.
- LLVM 도구가 없어 solver의 외부 LLVM selftest는 비활성화됐다. 대신 GNU assembler/linker와 실보드 게이트를 사용했다.
- Armv8.1-M `LSLL/LSRL` 허용쌍 모델을 추가하고 r2–r9 추가 예약을 제거했다.
- 최종 네 출력의 `LSLL/LSRL` 짝 위반: **0건**. 실제 출력에서 `(r2,r3)`, `(r4,r5)`, `(r6,r7)`, `(r8,r9)` 재할당을 확인했다.
- p1 첫 시도는 무자료형 `vorr` 별칭 파싱 실패로 solver 실행 전에 중단됐다. 의미가 같은 `vorr.i32`로 정규화한 보정은 `2026-08-28_expDB_protocol_amendment.md`에 사전 기록했다.

## 보드 실패와 원인 분리

첫 전체 이미지(ELF `FEEF7EF5…`)는 code flash 886,200 B를 되읽어 `75BE7B68…`로 일치했고 전체 KAT를 통과했지만 `expDB mismatch=12800`, `harness_fails=12800`이었다.

phase별 진단 결과:

| 비교 | Ut p0/p1/p2/p3 | Us p0/p1/p2/p3 |
|---|---|---|
| 비별칭 10-limb 출력 | 0/0/0/0 | 0/0/0/0 |
| q0–q7 + 508-word MVE 상태 | 0/0/0/0 | 0/0/0/0 |
| 출력/입력 별칭 | 0/0/0/0 | **64/96/94/32** |

즉 안전변환 원순서 대조군 `Ut`는 맞았으나 solver본만 별칭에서 틀렸다. SLOTHY가 r0/r1/r2의 서로 다른 base pointer가 가리키는 메모리의 상호 별칭을 모델링하지 않아 출력 store를 필요한 입력 load보다 앞당긴 것이 원인이다. 내부 selfcheck는 모델에 없는 별칭 의존성을 검출하지 못했다.

조건부 입력 복사 후보도 mismatch 12,800, 항상 입력 복사 후보도 mismatch 12,743으로 실패했다. 이 두 보정 후보 역시 cycle 값을 폐기했다. 따라서 현 산출물로는 **정확한 전체 solver 후보의 속도는 미측정**이다.

## 보존 로그

- parser 실패: `slothy-2stream/expDB/p1_solver_parse_failure.log`
- phase 진단: `logs/2026-08-28_expDB_phase_diagnostic{,2,3,4,5}.txt`
- 원 solver 실패: `logs/2026-08-28_expDB_run1_alias_unsafe_FAILED.txt`
- 조건부 복사 실패: `logs/2026-08-28_expDB_run1_conditional_copy_FAILED.txt`
- 항상 복사 실패: `logs/2026-08-28_expDB_run1.txt`

## 논문에 허용되는 결론

“네 조각 전체를 solver로 재스케줄해도 느리다”고 쓸 수 없다. 허용되는 결론은 다음뿐이다: **전체 조각과 r2–r9 재할당을 포함한 현 solver 후보는 보드 정확성 게이트를 통과하지 못했으며, 정확한 성능 비교에는 포인터 별칭을 보존하는 메모리 모델 또는 별칭 안전한 재생성이 필요하다.**
