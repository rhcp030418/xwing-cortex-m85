# A주제 전체 데이터 패키지

이 패키지는 선별 재현 부록인 `artifact-upload.zip`과 목적이 다르다.
`artifact-upload.zip`은 논문 핵심 재현에 필요한 최소 집합이고,
`all-data-upload.zip`은 A주제 연구 과정의 **원시·중간·실패·역사·의존성 파일을 모두
추적 가능한 형태로 보존하는 전수 패키지**다.

## 1. 구조

| 경로 | 내용 |
|---|---|
| `00_metadata/README.md` | 이 안내문 |
| `00_metadata/DATA_CATALOG.tsv` | 파일별 경로·크기·SHA-256·실험 ID·역할·증거 등급·상태·포함 여부 |
| `00_metadata/EXPERIMENT_LINEAGE.tsv` | 실험과 K/W/X/T 후보의 파일 수·측정 상태·현행 판정·정본 경로 |
| `00_metadata/DENOMINATOR_CATALOG.tsv` | 표준 분모 21개와 T1~T45/T28b 46개 항목의 분모·환산식·비교 가능군 |
| `00_metadata/EXCLUSIONS.tsv` | 제외 파일과 제외 사유 전부 |
| `00_metadata/DATA_CATALOG.xlsx` | 사람이 필터·검토하기 위한 동일 카탈로그 workbook |
| `00_metadata/MANIFEST.sha256` | ZIP 내부 모든 다른 항목의 크기·SHA-256 |
| `corpus/A주제/...` | 포함 파일의 원래 상대경로를 그대로 보존한 전체 corpus |

## 2. 포함 규칙

다음을 포함한다.

- 원시 보드 로그와 진단 로그
- ELF·SREC·map·readback 관련 파일
- 사전등록·결과서·분석·수치 정본·계보 대장
- 생성기·회수기·하네스·어셈블리·solver 입력과 출력
- 동결 아티팩트와 실패한 후보
- `_보관`의 역사 백업과 staging 자료
- 두 pqmx vendor snapshot과 문헌 자료
- 논문 원고·PDF·기존 선별 artifact/Overleaf 패키지

## 3. 제외 규칙

데이터 손실을 숨기기 위한 제외는 없다. 다음만 제외한다.

- `.git/` 내부 객체·index·refs: 버전관리 내부 상태이며 연구 데이터가 아님
- `__pycache__/`와 `.pyc`: 원본 Python에서 재생성되는 runtime cache
- `all-data-upload.zip` 자신·전체 작업공간 manifest·카탈로그 생성 출력: 자기참조
  해시를 피한다. 카탈로그 산출물은 `00_metadata/`에 한 번만 넣음

source snapshot에서 제외된 `.git`·cache 파일은 `EXCLUSIONS.tsv`에 경로·크기·SHA-256과
함께 남긴다. 자기참조 출력 이름은 `SUMMARY.json`의
`generated_outputs_excluded_from_snapshot`에 별도로 고정한다.

## 4. 정본과 상태

- 원시 자료라고 해서 모두 논문 결론에 사용할 수 있는 것은 아니다.
- `lifecycle=historical` 또는 `canonicality=backup`은 과거 복사본이며 현행 정본이 아니다.
- `evidence_level=E1-direct`는 직접 로그, `E2`는 동결·결과,
  `E3`는 소스·호스트 정적 분석, `E4`는 장부·프로토콜, `E5`는 논문 소비층이다.
- `all_data_included=Y`는 전수 패키지 포함 여부이고 `artifact_included=Y`는 선별 재현
  패키지 포함 여부다. 두 필드는 같은 뜻이 아니다.
- `expBO`는 코드와 `done` 기록은 있으나 RAM `rep_cyc`/`EXPBO_JSON`이 보존되지 않았다.
  카탈로그가 그 수치를 복원했다고 주장하지 않는다.
- 분모 표준화는 원시 cycle을 바꾸지 않는다. 2024/039, draft-10, same-ELF A/B,
  재플래시 F/U, warm/cold는 별도 비교군이며 `DENOMINATOR_CATALOG.tsv`의 표준 ID를 넘는
  직접 환산을 금지한다.

## 5. 검증

`package_all_data.py`는 다음을 실패 조건으로 검사한다.

1. 카탈로그 이후 원본의 크기 또는 SHA-256 변경
2. 포함 대상의 누락·중복 archive path
3. ZIP CRC/read 오류
4. 내부 manifest와 entry 집합·크기·SHA-256 불일치
5. 카탈로그의 `all_data_included=Y` 집합과 `corpus/A주제/` 집합 불일치

카탈로그 재생성은 `build_data_catalog.py`, 전체 패키지 생성은
`package_all_data.py`, 작업공간 전수 해시는 `verify_all_files.py`로 수행한다.
