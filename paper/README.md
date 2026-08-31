# A주제 원고 — 한/영 폴더 구조

```
paper/
  references.bib     ← 공유 (양쪽이 ../references.bib 로 참조)
  ko/main.tex        ← 정본. 검토·수정은 여기서
  en/main.tex        ← 영문판. 투고 직전 ko에서 일괄 변환
  overleaf/          ← 한국어 정본의 평탄화된 Overleaf 업로드본
  overleaf-upload.zip ← Overleaf에 바로 업로드할 ZIP
  build.ps1          ← 둘 다 빌드
  package_overleaf.ps1 ← 정본 동기화·격리 빌드·ZIP 생성
  package_artifact.ps1 ← 재현 자료·내부 SHA-256 manifest를 artifact-upload.zip으로 묶음
  verify_data_ledger.ps1 ← 전체 exp 파일명·K/W/X/T 후보·로그·아티팩트·T항목 누락 검사
  verify_all_files.py ← A주제 전 파일 hash·SREC·binary signature·ZIP/XLSX CRC 검사
  전체_파일_SHA256.tsv ← manifest 자신을 제외한 A주제 전 파일 경로·크기·SHA-256
  build_data_catalog.py ← 파일별 역할·증거·상태, 실험/후보 계보, 분모 매핑 TSV 생성
  package_all_data.py ← Git/cache만 제외한 전체 연구 corpus ZIP 생성·검증
  전체_데이터_카탈로그.tsv ← source snapshot 파일별 의미·정본성·포함 여부
  실험_계보_카탈로그.tsv ← 실험 132개·후보 73개의 파일/판정 연결표
  분모_표준화_카탈로그.tsv ← 표준 분모 21개·T항목 50개의 환산/비교 가능군
  데이터_패키지_제외목록.tsv ← 제외된 Git/cache 866개와 사유·해시
  데이터_카탈로그.xlsx ← r26 전수 snapshot; v32 핵심 제출 정본에는 사용하지 않음
  all-data-upload.zip ← r26 전수 snapshot; v32 핵심 제출 정본에는 사용하지 않음
  전체_데이터_패키지_README.md ← 전수 패키지 구조·포함/제외·검증 규칙
  ARTIFACT_README.md ← 부록 최상위 재현 안내
  데이터_누적_검증대장.md ← 최초 계획부터 실패·정정·현행까지 시간순 누적 장부
  데이터_계보_아티팩트_정합성.md ← 측정 집합·정본·제출물 버전 대장
  자원_비용_감사.md ← 동결 ELF/MAP 기반 자원비용과 미측정 경계 감사
  논문_초안.md         ← (구) 피벗 전 초안. 대체됨, 참고용
```

**작업 원칙**: 초안은 한국어로 먼저 쓴다. 영어는 투고 직전에 한 번에 옮긴다
(저자가 모든 주장을 직접 검증해야 하는데 영문 초안이 그 검토를 막기 때문).
따라서 **내용 변경은 항상 `ko/main.tex`에서 시작**하고, `en/`은 뒤따라 갱신한다.

## 빌드

```powershell
.\build.ps1          # 한국어 정본만(기본값)
.\build.ps1 ko       # 한국어만
.\build.ps1 en       # 이전 영문판(경고 출력, 제출 금지)
.\build.ps1 all      # 둘 다(영문판 경고 출력)
```

| | 엔진 | 이유 |
|---|---|---|
| `ko/` | **xelatex** | 한글(kotex). pdflatex로는 안 됨 |
| `en/` | pdflatex | |

## Overleaf 업로드

`overleaf-upload.zip`을 새 프로젝트로 업로드한다. ZIP 최상위에는 다음 다섯 소스 파일만 있다.

```text
main.tex
references.bib
llncs.cls
splncs04.bst
latexmkrc
```

`latexmkrc`가 새 프로젝트의 기본 pdfLaTeX 규칙까지 XeLaTeX로 연결하고, `main.tex`은
최상위 참고문헌 경로를 사용한다. `main.pdf`와 `main.bbl`은 Overleaf가 다시 생성하므로
업로드 ZIP에 넣지 않는다.
번들된 `llncs.cls`는 MiKTeX의 공식 LNCS 2.26 설치본과 바이트 단위로 같다.
한국어 정본을 수정한 뒤에는 다음 명령 하나로 동기화·격리 빌드·ZIP 생성을 수행한다.

```powershell
.\package_overleaf.ps1
```

스크립트는 정본의 `../references`를 ZIP용 `references`로 바꾸고, undefined 인용·참조와
overfull box가 없는지 검사한다. 격리 빌드된 PDF와 BBL을 정본 및 ZIP에 복사하고, 최종
일곱 파일을 다시 풀어 각 SHA-256이 패키징 입력과 같은지 확인한다.

## 현재 상태 (2026-08-31)

| | 쪽수 | 인용 | 상태 |
|---|---|---|---|
| ko | 15 | 14건 | **v32: expDJ 최초 A0--최종 B8 직접 동일 ELF를 주 결과로 반영.** 선행기법 대비 기여 경계, 공개 비교점, X06 flash--cycle 선택지와 최종 비교 자원 상계를 보강했다. 보드 1대·외부 최고 기준선·정확한 B8 배포 footprint·전력/에너지는 한계로 유지한다. |
| en | 10 | 12건 | 이전 판 — 투고 직전 한국어 정본에서 일괄 동기화 |

한국어 정본은 새 암호 primitive나 단순 포팅이 아닌 **Cortex-M85 아키텍처 특화 X-Wing
구현 연구**로 분류한다. 최초 A0와 최종 B8을 한 ELF에서 다섯 번 직접 비교한 주 총효과는
키생성/캡슐화/역캡슐화 warm/cold 19.52/19.75/11.66/15.48%다. 1단계
25.96/20.25/11.22/18.30%와 2단계 0.928--4.228%는 변환 귀속 자료이며 서로 합산하지 않는다.
MVE cswap과 batch inversion 자체는 선행기법이고, 기여는 X-Wing의 적용 위치·M85 구현·
종단 간 채택 검증에 한정한다.

통합 이외의 기여는 프로토콜 적용 위치, M85 레지스터·발행 제약, micro에서 전체 API까지의
채택 절차와 실패 경계다. 실제 X25519--NTT 병합은 평균 1.6개의 빈 레지스터와 재물질화
비용 때문에 순차 실행보다 느렸고, dual-beat cswap 스케줄은 micro에서 12.883% 빨랐지만
cold 전체 경로의 0.20% 채택 문턱을 넘지 못했다. 동일 명령 수와 cycle 차이는 dual-beat
가설과 일치하지만 PMU stall 사건이 없어 인과 증명으로 쓰지 않는다. 보드 2대·전원
사이클은 여전히 미측정이다.

draft-10 동일 ELF 누적 A/B와 단일축 제거 자료는 v32 원고의 1단계 성능 귀속과 기여 경계에 사용한다.
8-seed 순환과 고정/무작위 암호문 검정 자료는 원시 로그와 함께 아티팩트에 보존하되, 서로 다른
RAM 배치와 누설 검정 범위를 누적 성능 분모와 섞지 않는다.
영문판은 아직 이전 수치와 구조이므로 인용하지 않는다.

156명령 B-mid solver 재생은 `PYTHONHASHSEED=0`, CP-SAT seed 42, worker 1로 두 번 실행해
생성 출력 SHA-256 `FC05A73B...FDBDC`가 바이트 단위로 같은 것을 확인했다. 새 출력은
역사적 보드 측정 스케줄과 다르므로 85.06-cycle 실측을 대체하지 않는다. 1,184명령 역사
실행은 FEASIBLE timeout 창 때문에 여전히 bit-for-bit 재생을 주장하지 않는다.

## 관련 문서

- 용어: `../../용어_대조표.md` (A·B 공통)
- 수치 출처: `../논문_데이터_표.md` → `../measure-harness/`, `../slothy-2stream/` 로그
- 데이터 계보·제출물 버전: `데이터_계보_아티팩트_정합성.md`
- 자원비용·미측정 경계: `자원_비용_감사.md`
- 최초 계획부터 후보 73개·실험·실패·철회까지: `데이터_누적_검증대장.md`
- 측정·검증 근거: `../1단계_게이트_리포트.md`, `../4단계_상수시간_논증.md`
- 골격: `../5단계_논문_골격.md`

`artifact-upload.zip`은 v32 정본 빌드 뒤 expDF/DH/DI/DJ 동결 자료를 포함해 생성한다. 스크립트는 최상위
`MANIFEST.sha256`을 압축 해제 뒤 검증하고, 내부 원고와 PDF의 해시가 현 정본과 다르면 실패한다.

## 전체 데이터 카탈로그와 패키지

`artifact-upload.zip`은 논문 핵심 재현을 위한 **선별 집합**이다. 전체 연구 과정은 다음
순서로 별도 생성한다.

```powershell
python .\build_data_catalog.py
# 데이터_카탈로그.xlsx는 artifact-tool builder로 TSV와 같은 snapshot에서 생성
python .\package_all_data.py
```

v32 TSV 카탈로그는 source snapshot 6,531개를 분류하며 5,665개 포함·866개 제외,
실험 132개·후보 73개·T 매핑 50개다. `데이터_카탈로그.xlsx`와 `all-data-upload.zip`은
r26 전수 snapshot으로 보존하고 이번 v32 핵심 artifact의 정본으로 쓰지 않는다. v32 핵심 제출물은
`artifact-upload.zip`의 내부 manifest와 정본 PDF·원고 해시로 검증한다.

## 남은 TODO

- M55/M52·에너지·전력/전자기 부채널 미측정 — 한국어 정본의 한계 절에 명시
- 두 번째 EK-RA8M1 개체·전원 사이클 미측정 (expCQ는 리셋 부팅 5회까지)
- expDB 후속: 출력/입력 alias를 보존하는 메모리 모델 또는 alias-safe 전 조각 재생성 후 정확성·cycle 재측정
- 상류 SLOTHY 이슈 5건 제출 (초안 `slothy-2stream/upstream_issues.md`, 사용자 GitHub 계정 필요)
- dudect는 ct 유효/무효 검정까지(expCX). 비밀키 의존 누설·전력·캐시 채널은 미측정
- `artifact-upload.zip`을 익명 저장소/제출 부록에 올린 뒤 URL 또는 DOI를 메타데이터에 기입
- 저자·소속·교신 이메일과 이해관계 공개 문구 확정
- 영문판 전체 동기화 — 한국어 주장 검토 완료 뒤 수행
