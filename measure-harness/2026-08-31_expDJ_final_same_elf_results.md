# expDJ 결과: 최초 A0 대 2단계 최종 B8의 단일 동일-ELF 비교

## 판정

**PASS.** 사전등록한 독립 재플래시 5회가 모두 RFC 7748/SHA3 KAT, 8-input
draft-10 전체 바이트 동치, 정상·거부 warm/cold 일치, 저차점 3종, timing equality와
stack guard를 통과했다. 네 연산 모두 모든 인접 A0/B8 대응에서 B8이 빨랐다.

- ELF SHA-256: `C9B7BFC5044B09FF5E22894BE631B8A1668F75443D3212B2E07FEF7204780886`
- SREC SHA-256: `BE9B0D50312D059B71FAFFC8062769A12CB1FCA381E2840EF4A7F88CB64118B1`
- flash readback: 5회 모두 116,960 B, normalized data SHA-256
  `884531E285B15A1E1FE808510320C7CA2562C8F16C3B240E54783CCBDC983CD5`

## 직접 최종 성능

각 재플래시에서 A0--B8와 뒤집힌 B8--A0 인접 두 쌍을 사용했다. 아래 범위는 5회 ×
2쌍의 10개 대응효과다.

| 연산 | A0 범위 (cycle) | B8 범위 (cycle) | 직접 개선률 범위 | 보수적 값 |
|---|---:|---:|---:|---:|
| keygen | 870,869--870,970 | 700,834--700,865 | 19.521191--19.534083% | **19.52%** |
| encaps | 1,326,924--1,326,931 | 1,064,853--1,064,862 | 19.749828--19.750688% | **19.75%** |
| decaps-warm | 934,803--934,837 | 825,746--825,793 | 11.661494--11.669521% | **11.66%** |
| decaps-cold | 1,802,626--1,802,655 | 1,523,463--1,523,502 | 15.484299--15.487822% | **15.48%** |

이 표가 최초 구현과 최종 구현 사이의 직접 headline이다. expCY 1단계와 expDH 2단계는
각 축과 잔여 병목의 진단·귀속 자료로 유지하지만, 그 개선률을 이 표에 더하거나 곱하지
않는다. expDJ에는 양쪽에 공통인 비교용 mode 조회와 두 경로 코드가 함께 들어 있으므로
절대 cycle은 dispatcher-free 배포값이 아니다. 특히 코드 배치가 다른 expCY의 B와
expDJ의 B8 차이를 어느 변환의 회귀로 귀속하지 않는다.

## 동일 비교 ELF의 경로별 stack

별도 canary 호출의 high-water이며 하단 64 B guard 훼손은 모든 셀에서 0이었다.

| 연산 | A0 | B8 | B8-A0 |
|---|---:|---:|---:|
| keygen | 10,360 B | 10,360 B | 0 B |
| encaps | 7,848 B | 7,848 B | 0 B |
| decaps-warm | 7,784 B | 7,784 B | 0 B |
| decaps-cold | 11,448 B | 11,448 B | 0 B |

이 값은 비교 wrapper의 공통 프레임을 포함한다. expDE dispatcher-free B의 10,264 B와
직접 대체하지 않으며, 최종 배포형 footprint/stack을 과장해 주장하지 않는다.

결합 expDJ ELF의 Berkeley size는 text/data/bss
113,908/3,068/354,596 B다. A0와 B8 및 시험 배열을 함께 링크한 계측 이미지이므로
경로별 배포 footprint로 해석하지 않는다.

## 로그 SHA-256

| run | SHA-256 |
|---|---|
| 1 | `208719E0A3694802D9D2695C0EEC9FE2B2625975AE8A743FE7564B6B2CD1A390` |
| 2 | `E0D17B55B004B0C6A6034637F71D711D1A3B66F1589541F6FA91527EF8AF64CC` |
| 3 | `C0D4B6B8376995A162FE353C80A17C0442EB876A3D643721D893521B9CF2456A` |
| 4 | `955A0F127C65B8E27DB9AE4E6877B11E0C58A859D4F2494FC6AC7B8A9BDC9042` |
| 5 | `DF0942D8EF80267DDBE16ABDABA5DFBCCB903B9D01E8420CAB3606E8E24288A8` |

측정 뒤 활성 프로젝트는 expDH로 복구했고, 재빌드 ELF SHA-256
`98D620B64816AE63ACFB80FA98A2428FD8AFE12D698E7E08729A2AD29907FA51`로 원상복구를
확인했다.

