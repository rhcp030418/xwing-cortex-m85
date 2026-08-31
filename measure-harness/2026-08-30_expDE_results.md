# expDE 결과: 경로별 최소 배포 프록시와 스택

## 판정

**PASS.** A/B 모두 런타임 디스패처와 실험용 객체를 제거한 독립 링크이며,
각 모드의 두 재링크 ELF SHA-256이 일치했다. 보드에서 공식 draft-10 벡터,
8-seed 정상·거부·cold/warm 검사와 4개 연산 canary 스택을 각각 통과했다.

## 동일 분모

- 동일 EK-RA8M1 BSP, 링커 스크립트, 컴파일 옵션, newlib-nano, draft-10 API 루트
- `-ffunction-sections -fdata-sections --gc-sections`
- `--wrap=memcpy --wrap=memset`
- footprint 이미지에는 KAT·로그·canary·작업 버퍼가 없다.
- 스택은 별도의 진단 이미지에서 측정하므로 footprint `bss`에 canary가 섞이지 않는다.

## footprint

`arm-none-eabi-size --format=berkeley`의 바이트 값이다.

| 모드 | text | data | bss | 비휘발 `text+data` | 정적 RAM `data+bss` |
|---|---:|---:|---:|---:|---:|
| A 기준형 | 30,756 | 4 | 1,470 | 30,760 | 1,474 |
| B 최종형 | 63,028 | 2,040 | 1,474 | 65,068 | 3,514 |
| B-A | +32,272 | +2,036 | +4 | +34,308 (+111.53%) | +2,040 (+138.40%) |

B의 `x25519_base_comb` 심볼은 정확히 `0x8100 = 33,024 B`다. 이는 비휘발 증가
34,308 B의 96.25%다. B의 추가 초기화 RAM 2,032 B는 두 NTT/INTT 어셈블리
객체의 각 `0x3f8 = 1,016 B` `.data`에서 온다. 나머지는 RNG 상태·정렬 및 작은
경로별 상태 차이다.

## 반대 경로 제거와 재현성

- A ELF: `fe25519_mul_sched`, `fe25519_sqr_bb`, comb 표, M85 후보 NTT/INTT 없음.
- B ELF: `apx_real_fe25519_mul/sqr`, `ntt_fast`, `invntt_fast` 없음.
- A build 1/2 ELF SHA-256: `811FEE85A7F8C6146A3CCF41C5F772AA9E6EB268729EF0CD6B802D48D54D42D1`
- B build 1/2 ELF SHA-256: `A5F16F10A47F6E53D6D3C62B258A0CD59D6EC47993764EDDEC846342155AA292`

## 보드 KAT와 스택 high-water

두 모드 모두 아래 값이 같았고 하단 64 B guard 훼손은 0이었다.

| 연산 | A high-water | B high-water | B-A |
|---|---:|---:|---:|
| keygen | 9,176 B | 9,176 B | 0 B |
| encaps | 6,664 B | 6,664 B | 0 B |
| decaps-warm | 6,600 B | 6,600 B | 0 B |
| decaps-cold | 10,264 B | 10,264 B | 0 B |

- A 진단 ELF SHA-256: `BFCEB95ECA6CB65CB83CBFDF6C200FEAEAE9DC1C52FCDC64FA6F3C986ABDBBC9`
- B 진단 ELF SHA-256: `E5A74A891AA94C358AF3E6A9B411D7CC9E95D4E2B2DA4AE758E32E444584EE1C`
- 두 모드 모두 공식 벡터 mismatch 0, 8-seed smoke 0, 변조 ciphertext warm/cold mismatch 0

## 해석 범위

이 수치는 순수 `.a` 라이브러리 크기가 아니라 동일 BSP 위 **최소 배포 프록시**다.
절대값에는 1,024 B BSP main stack과 결정적 시험 RNG가 공통 포함된다. 따라서 절대값을
다른 플랫폼의 라이브러리 크기처럼 비교해서는 안 되지만, A/B 차이는 같은 분모다.
