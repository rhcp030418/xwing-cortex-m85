# 실험 AI — encaps F/U/U1 경로·구간 귀속

> 날짜: 2026-08-24  
> 사전등록: `2026-08-24_expAI_encaps_attribution_prereg.md`  
> 보드: EK-RA8M1, DWT CYCCNT, N=100, F↔U와 F↔U1 각각 ABBA  
> 원시 로그: `logs/2026-08-24_expAI_encaps_attribution_run{1,2}.txt`

## 결론

현재 ITCM 배치에서 F→U encaps 총 손실은 두 run의 AB/BA 네 값에서
**+81,722~+81,822cyc**였고, 한 job만 U4에 넣은 F→U1은
**+26,156~+26,192cyc**였다. 따라서 두 번째 job을 U8 융합 경로로 옮긴 순효과는
**+55,556~+55,620cyc 악화**다.

이 순효과는 융합 구간에서 **+227,678~+227,707cyc**가 늘고, 잔여 ladder 구간에서
약 **−172.1kcyc**가 줄어드는 상쇄의 결과다. 즉 현재 encaps 불균형은 잔여 ladder
직렬화가 지배해서가 아니라, 두 번째 job의 작업을 잔여 scalar 구간에서 더 비싼 U8
융합 구간으로 옮긴 결과다. 이 결론은 기존 U 기각 판정을 바꾸지 않는다.

## 두 독립 run

각 값은 candidate−F다. 양수는 악화, 음수는 candidate가 해당 구간에서 더 짧다는 뜻이다.
체크포인트 공통 오버헤드는 절대값에는 포함되지만 차분에서 상쇄된다.

| 비교 | run | 순서 | total | ML-KEM+x4 융합 | finish+scalar 잔여 | 기타/결합 |
|---|---:|---|---:|---:|---:|---:|
| F→U | 1 | AB | +81,768 | +425,647 | −343,865 | −14 |
| F→U | 1 | BA | +81,722 | +425,576 | −343,865 | +11 |
| F→U1 | 1 | AB | +26,178 | +197,933 | −171,747 | −8 |
| F→U1 | 1 | BA | +26,192 | +197,913 | −171,755 | +34 |
| F→U | 2 | AB | +81,822 | +425,675 | −343,867 | +14 |
| F→U | 2 | BA | +81,732 | +425,595 | −343,855 | −8 |
| F→U1 | 2 | AB | +26,156 | +197,931 | −171,748 | −27 |
| F→U1 | 2 | BA | +26,174 | +197,923 | −171,744 | −5 |

`기타/결합 = total − 융합 − 잔여`이며 범위는 −27~+34cyc다. 이는 별도 성능
주장으로 해석하지 않고 체크포인트·호출 경계의 **미분류 잔여**로 보존한다.

## 사전등록 분기별 귀속

1. **2-job 융합 경로 자체:** U−U1 융합 구간은 run 1 **+227,678cyc**,
   run 2 **+227,707cyc**다.
2. **잔여 ladder 직렬화:** U는 U1보다 잔여 구간이 약 172.1kcyc 짧다. 따라서 큰
   양의 잔여 직렬화가 지배한다는 예측은 반증됐다.
3. **x4·스티칭 상호작용:** 같은 ELF의 독립 U4/U8 24-round 배치에서는
   `P8−2P4=+6,062~+6,130cyc/batch`였다. 그러나 full encaps에서 이 배치가 몇 번
   기여했는지를 세는 계측 카운터가 이번 빌드에서 0을 보고해, +227.7k 중 순수
   계산량을 넘는 부분의 정량 귀속은 **미측정**이다. 추정으로 메우지 않는다.
4. **미분류:** 합성 산술의 경계 잔여는 −27~+34cyc다. 3번의 내부 세분은 위 이유로
   미측정이다.

## 정확성·재현성 게이트

두 유효 run 모두 다음을 통과했다.

- RFC 7748 4종과 SHA3 KAT, ML-KEM roundtrip/reject, x4/U primitive KAT
- 기존 전체 하네스와 신규 F/U/U1 ciphertext·shared-secret mismatch 0
- `expAI mismatch=0`, stack canary fail 0, stack high-water 9,020 B
- `harness_fails=0`

첫 시도 한 번은 성능값을 얻지 못해 제외했다. 신규 준비용 ML-KEM keypair를 FSP 기본
스택에서 직접 호출해 `CFSR=0x00100000(STKOF)`가 났고, stacked PC는
`indcpa_keypair_derand`였다. 준비 함수를 기존 16KiB `run_on_stack`으로 옮긴 뒤 clean
build했고, 이후 두 독립 flash/run에서 fault와 mismatch가 재발하지 않았다.
최종 clean build는 0 errors(기존 경고 296건)였고, ELF의 `rep_cyc` 크기는
`0x197d0 = 261×100×4B`로 슬롯 수와 일치한다. ITCM limit은 `0x0000c6d0`이다.

## 해시

| 파일 | SHA-256 |
|---|---|
| 유효 측정 ELF | `A57D8FA05D467619EAD9A965FFFE5FE08263398E2508B6DF5CA4A2E710ED5A55` |
| 유효 측정 SREC | `E98A8184E3652E028F1F2AC9213425F3FCE81E369DB3C7281640327DBD65DBB7` |
| `harness_expAI_staged.c` | `1B352D5FBF652773EC8FC31D8E819812BB502BA5386F82D30B3DEB6A62327971` |
| `harvest_ra8m1_expAI.py` | `E6728121F5EED4429488ACC57F4E7D4DC81CF775469ADEA0B41E6C66A905D49C` |
| run 1 로그 | `F83200545C1584C934C86A07CC980F20CB1BCF35AEA6E79C587E80EE847B1FB2` |
| run 2 로그 | `50BC8B4BC5CBAFD3E3648A59406D11818D9255F0EEA52F4410B8132CE7BA55BD` |
