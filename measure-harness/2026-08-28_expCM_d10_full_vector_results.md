# 실험 CM 결과 — X-Wing draft-10 공식 벡터 전량 대조

## 판정: PASS

IETF `draft-connolly-cfrg-xwing-kem-10` Appendix C vector 1을 자동 파싱해 최종
최적화 모드 B의 EK-RA8M1 실행과 비교했다.

- `pk1216-mm=0`
- `ct1120-mm=0`
- `ss-mm=0`
- 되짚기 decapsulation `dec-mm=0`
- 전체 `harness_fails=0`
- flash code readback PASS: 855,728 B

따라서 이전의 public key 128 B / ciphertext 62 B prefix 검사는 폐기하고, 공식 public
key 1,216 B와 ciphertext 1,120 B 전체를 외부 oracle로 대조한 결과를 정본으로 사용한다.

## 계보

- 공식 draft 텍스트 SHA-256:
  `530900AC0519E28EB1FF50BF80ECDB7648ADD22E500DB72B465BAB4FB6B6A5EC`
- KAT 전용 ELF SHA-256:
  `18C25CA0A42CC8049655D3395E531501DDAA6EA8C689F1AB0D5E97E8804C6FFF`
- KAT 전용 SREC SHA-256:
  `6318AEDC1727D659D272173F8F3A0307CE36924F46BF99D635B24CA626F3FB75`
- code-flash readback SHA-256:
  `90AC3DC118B942F5C219B243B7E761A388DA6BFD1C44B1E373C8EEC3F001DDE0`
- generator SHA-256:
  `B46960886D86D18BEDA8C90491903260440CFEB15B3BD947183D7F58FB378272`
- generated vector include SHA-256:
  `7B3E82525E5E84FB0BF2557F4EC7B1CD8C5FAA27EE132BC0E99CEE82602ECC3F`

Generator는 seed/sk 32 B, eseed 64 B, ss 32 B, pk 1,216 B, ct 1,120 B의 길이와
`seed == sk`를 확인하고 다섯 C 배열을 모두 생성한다. 수동 prefix 또는 수동 전사 배열은
사용하지 않는다.

## 성능 사용 금지

전체 배열을 추가한 KAT 전용 ELF의 text는 848,172 B로 기존 expCJ 성능 ELF보다 2,144 B
크다. 링크 배치가 바뀌었으므로 이 실행에서 함께 출력된 cycle은 논문의 성능 수치에
사용하지 않는다. 성능 정본은 기존 동결 expCJ/AF 결과이며, 이번 실행은 정확성 gate다.

## 원시 파일

- `logs/2026-08-28_expCM_d10_full_vector.txt`
- `2026-08-28_expCM_d10_full_vector_prereg.md`
- `generate_d10_kat.py`
- `expCJ-src/expBW_d10kat.inc`
- `expCJ-src/expBW_d10kat_vectors.inc`
- `artifacts/2026-08-28_expCM_d10_full_vector/`
