# Translation and Terminology Criteria

1. Preserve all numerical results, equations, citations, labels, and operation scopes from the Korean source.
2. Use academic English and preserve the strength of each claim; do not turn observations into proofs or causal claims.
3. Define every acronym at first use and use only the acronym thereafter when this improves readability.
4. Use one fixed term for each technical concept throughout the text, tables, captions, and figures.
5. Use present tense for the paper and established algorithmic facts, and past tense for completed experiments.
6. Distinguish function-level diagnostics, the six-optimization diagnostic, and the final end-to-end comparison; never add percentages across these experiments.
7. Keep security validation separate from formal constant-time or side-channel assurance.
8. Preserve LNCS structure and use ASCII hyphens in source text; represent numeric ranges with LaTeX `--`.

## Fixed terminology

| Concept | Required term |
|---|---|
| 기준 구현 | reference implementation |
| 최종 통합 구현 | final integrated implementation |
| 키생성 | key generation |
| 캡슐화 | encapsulation |
| warm 역캡슐화 | warm decapsulation |
| cold 역캡슐화 | cold decapsulation |
| 고정 기저점 스칼라 곱셈 | fixed-base scalar multiplication |
| 가변 기저점 스칼라 곱셈 | variable-base scalar multiplication |
| 데이터 변환 | data-format transformation |
| 조건부 교환 | conditional swap; MVE cswap after first definition |
| 일괄 역원 계산 | batch inversion |
| 두 X25519 출력의 일괄 역원 계산 | paired inversion |
| 정렬 인식 메모리 함수 | alignment-aware memory routines |
| 단일 최적화 제거 | leave-one-out analysis |
| 종단 간 | end-to-end |

Do not substitute `baseline implementation`, `keygen`, `conditional exchange`,
`fixed-point multiplication`, or `variable-point multiplication` for the terms
above.
