# expDE 사전등록: A/B 최소 배포 프록시 footprint와 스택

- 등록 시각: 2026-08-30, 빌드·보드 실행 전
- 대상: expCJ의 기준형 A와 최종형 B
- 목적: 동일 ELF의 런타임 디스패치 때문에 섞여 있던 자원 비용을, 경로별 독립 이미지로 분리한다.

## 1. 고정 비교 단위

두 이미지에 공통으로 EK-RA8M1 BSP 시작 코드, 동일 링커 스크립트, 동일 컴파일·링크 옵션,
동일 draft-10 API 네 개(`keypair`, `encaps`, `decaps-warm`, `decaps-cold`)와 API 루트 테이블만 둔다.
시험·계측 배열, 동일 ELF A/B 디스패처, 장시간 측정 하네스는 footprint 이미지에서 제외한다.
따라서 이 값은 순수 라이브러리 파일 크기가 아니라 **동일 BSP 위 최소 배포 프록시 이미지**의
`text/data/bss`이며, A/B 분모와 공통 오버헤드는 완전히 같다.

## 2. 경로 고정

- A: pqm4 NTT/INTT, 스칼라 C9, ladder fixed-base, 원래 field mul/sqr, newlib-nano memcpy/memset.
- B: 채택 NTT/INTT, MVE C9, comb fixed-base, 채택 field mul/sqr, word-loop memcpy/memset.
- 런타임 모드 변수 분기는 컴파일 시간 상수 또는 직접 branch로 치환한다.
- `-ffunction-sections`, `-fdata-sections`, `--gc-sections`를 유지한다.
- B의 fixed-base 표는 실제로 링크된 심볼 크기와 MAP에서 확인한다.

## 3. footprint 판정

각 모드는 독립 clean build 두 번을 수행한다. 동일 모드의 ELF SHA-256과
`arm-none-eabi-size --format=berkeley` 값이 두 빌드에서 일치해야 한다.
MAP에서 반대 경로 핵심 심볼이 제거되었는지 확인한다.

보고값은 A와 B 각각의 `text`, `data`, `bss`, `text+data`(비휘발 배포 바이트),
`data+bss`(정적 RAM 바이트), B-A 차이와 증감률이다.

## 4. 스택 판정

footprint 이미지와 별도로, 같은 고정 경로 소스에 DTCM canary 스택만 추가한 진단 이미지를 만든다.
각 연산은 새로 채운 0x7e canary 스택에서 한 번씩 실행하고 최초 오염 위치로 high-water를 구한다.
하단 64바이트 보호구역이 유지되어야 하며 KAT, 정상 encaps/decaps 일치,
변조 ciphertext의 warm/cold 암묵적 거부 일치가 모두 0 failure여야 한다.

스택 값은 진단 이미지에서 측정한 값이고 footprint의 `bss`에는 canary 배열을 포함하지 않는다.

## 5. 실패 규칙

독립 재빌드 불일치, 반대 경로 잔존, 표 심볼 불명, 보드 KAT 실패,
canary 보호구역 훼손 중 하나라도 있으면 해당 항목은 `미완성/미측정`으로 남기며 결과처럼 쓰지 않는다.
