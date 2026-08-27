# 실험 AL 구현 검증

> 2026-08-24. 코드·빌드 검증 기록이며 보드 성능 결과가 아니다.

## 확인됨

- Claude의 별도 full-integration AL 사전등록은 측정 전에 철회되었고, 같은 질문을
  포함하는 2×2 factorial AL이 canonical 설계로 남았다.
- `REP_SLOTS=333`; 신규 X-Wing 8셀은 슬롯 309~332만 사용한다.
- Renesas GCC Arm 13.2.rel1, `make -B -j2 all`: **exit 0**.
  text 691,928 B, data 7,416 B, bss 197,328 B.
- 원시 빌드 로그: `logs/2026-08-24_expAL_implementation_build.txt`.
- 전체 재빌드 경고 295개, 오류 0개. `harness.c` 경고는 기존 두 곳
  (sign conversion, `harness_main` declaration)이며 신규 AL 조각 오류는 없다.
- `rep_cyc=0x22002fe0`, 크기 `0x20850` = 333×100×4 B;
  `log_buf=0x22023830`으로 정확히 인접하며 겹치지 않는다.
- ITCM load limit `0xe970` < 64 KiB.
- SREC code-flash 파싱: 2 segments, 699,328 B,
  `0x02000000..0x020aabc8`.
- harvester/tools self-test, Python compile, PowerShell AST, live preflight,
  streaming logger, pre-flash stage manifest와 generated make/link metadata 20개:
  **PASS**.
- runner의 `DeleteOnClose` 배타 lock과 두 번째 획득 거부: **PASS**.
- Debug 제외 프로젝트 fingerprint의 결정성, staging 복제 일치, 잘못된 pre-build
  fingerprint 거부: **PASS**
  (`F5BD4C84A944D619B8C7EEA658316EEB0476C9F1B26CBB4D9FF6032FBF296FE9`).
- 합성 두-run 로그에서 report/freeze 성공, stale result 거부, Dropbox 잠금 시
  atomic-write retry 경로: **PASS**.

검증 빌드 해시는 ELF
`555777958E99D2871115D2E74035F665239B7363B6091C3311CBC0EF06A4CFE8`, SREC
`23C184F93989B0716F3FA1CB177B9AAF9F63714F75734C8258EAD92DEFAD898E`다.
이는 구현 검증 빌드이며, 실제 측정 이미지는 runner가 다시 강제 빌드한 직후
별도 staging에 동결한다.

## 미측정

- EK-RA8M1 flash/readback, KAT, 8-seed 전 바이트 동등성, stack high-water,
  X-Wing cycle과 2×2 효과는 모두 **미측정**이다.
- 실행 시 `run_expAL.ps1`가 강제 전체 빌드 → pre-flash 동결 → 동일 frozen
  ELF/SREC 두 번 flash/run → report → 최종 manifest 순서로 수행한다.
