# 실험 CM 사전등록 — X-Wing draft-10 공식 벡터 전량 대조

## 질문

동결 expCJ 구현의 최종 최적화 모드 B가 공식
`draft-connolly-cfrg-xwing-kem-10` Appendix C vector 1의 전체 출력을 재현하는가.

## 준거와 입력

- 공식 텍스트: `draft-connolly-cfrg-xwing-kem-10.txt`
- SHA-256: `530900AC0519E28EB1FF50BF80ECDB7648ADD22E500DB72B465BAB4FB6B6A5EC`
- seed/sk 32 B, eseed 64 B, public key 1,216 B, ciphertext 1,120 B, shared secret 32 B.
- `generate_d10_kat.py`가 vector 1을 파싱하며 길이와 `seed == sk`를 검사한 뒤 C 배열을
  생성한다.

## 실행과 게이트

1. expCJ와 같은 구현 소스에서 KAT 배열만 prefix에서 전량 배열로 교체해 새 ELF를 빌드한다.
2. EK-RA8M1에 플래시해 최종 최적화 모드 B로 derandomized key generation,
   encapsulation, decapsulation을 실행한다.
3. `pk1216-mm=0`, `ct1120-mm=0`, `ss-mm=0`, `dec-mm=0`,
   `harness_fails=0`을 모두 통과해야 성공이다.
4. 성능 수치는 다시 주장하지 않는다. 배열 추가에 따른 링크 배치 변화가 있으므로 이 빌드의
   cycle은 expCJ 성능 결과에 사용하지 않는다.
5. 실패하면 어느 필드가 몇 바이트 다른지 그대로 기록한다.
