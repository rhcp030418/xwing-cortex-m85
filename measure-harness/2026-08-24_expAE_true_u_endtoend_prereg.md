# 실험 AE 사전등록 — 실제 Fiat X25519 `yield1+b1` 종단간 통합

## 질문

실험 U에서 선택한 `r11-fixed Fiat carry_mul + low-contiguous b1`을 고정 피연산자
매크로커널이 아니라 실제 X25519 Montgomery ladder의 임의 피연산자에 적용했을 때,
X/Y/C8 X-Wing 종단간 경로에서 순차 실행 대비 이득이 남는가?

기존 AC는 Lenngren 8×32-bit 필드 곱셈과 b0를 사용했으므로 이 질문의 답으로 쓰지
않는다. AE는 U와 동일한 Fiat 10×25/26-bit 표현, `-ffixed-r11` 산출물, b1 주소
정책을 사용한다.

## 구현과 비교 경로

- `X`: X/Y/C8 + 3-real+1-dummy matrix-XOF x4 + 기존 Lenngren X25519.
- `F`: X와 같은 ML-KEM/x4 경로 + 실제 Fiat X25519 ladder를 순차 실행.
- `U`: F와 같은 Fiat ladder의 임의 피연산자 carry-mul을 b1 Keccak round와
  명령 수준으로 교차 배치.

U는 X25519 상태를 작업 구조체에 보존한다. x4 Keccak의 각 round에서 keygen/decaps는
Fiat 곱셈 4회, encaps는 두 X25519 작업을 합쳐 8회 진행하고, ML-KEM이 끝난 뒤 남은
ladder 및 역원 계산을 같은 Fiat scalar 경로로 완료한다. 따라서 실제 데이터 의존성을
지키며 4:1/8:1 정책을 적용한다.

## 측정

- 동일 ELF, 동일 입력, 동일 X/Y/C8 코드에서 N=100 중앙값을 사용한다.
- `F-U-F`/`U-F-U`에 해당하는 ABBA 방향의 보수적 차분으로 스티칭 자체의 효과를
  계산한다.
- 기존 `S-X-S`/`X-S-X` 차분은 x4 배칭 비용 확인용으로 유지한다.
- `S-U-S`/`U-S-U` 종단간 차분도 유지해 현재 scalar X/Y/C8 기준과의 절대 위치를
  함께 제시한다.
- 성능 수치는 keygen/encaps/decaps를 각각 보고하며 평균 하나로 덮지 않는다.

## 정확성 gate

- RFC 7748 X25519 KAT 두 공개키와 양방향 shared secret.
- x4 SHAKE128/SHAKE256 primitive KAT.
- 8개 seed에서 X-Wing pk/sk/ct, valid shared secret, reject shared secret이 기준선과
  바이트 단위로 일치.
- ML-KEM roundtrip/reject, queue 완료, timing-output 일치, stack canary,
  `harness_fails=0`.
- 하나라도 실패하면 성능값을 기각한다.

## 판정

- 1차 판정은 같은 Fiat 구현인 `F→U`다. 세 연산 모두 양수이면 종단간 스티칭 성공,
  일부만 양수이면 부분 성공, 하나라도 음수이면 해당 연산은 실패로 기록한다.
- `X→U`는 현재 최선 대비 실용성 판정이다. Fiat 표현 자체의 비용이 포함되므로
  `F→U`와 분리해 해석한다.
- 매크로 U의 8.89% 투영치는 재사용하지 않고, 이번 직접 측정값으로 대체한다.
