# 원고 빌드: .\build.ps1 [ko|en|all]  (인자 없으면 정본 ko만)
param([ValidateSet("ko", "en", "all")][string]$which = "ko")

$base = $PSScriptRoot

# 한국어 정본은 단 하나의 격리 빌드 경로만 사용한다. 직접 ko/에서 빌드하면
# bibliography 경로가 달라 AUX/BLG/LOG가 overleaf/와 갈라질 수 있다.
if ($which -in @("ko", "all")) {
    & (Join-Path $base 'package_overleaf.ps1')
    if ($LASTEXITCODE -ne 0) { throw 'Canonical Korean isolated build failed' }
}

if ($which -eq "ko") { return }

Write-Warning 'en/main.tex is a stale, non-submission draft; synchronize it from ko/main.tex before citation or upload.'

$previousSourceDateEpoch = [Environment]::GetEnvironmentVariable('SOURCE_DATE_EPOCH', 'Process')
$previousForceSourceDate = [Environment]::GetEnvironmentVariable('FORCE_SOURCE_DATE', 'Process')
[Environment]::SetEnvironmentVariable('SOURCE_DATE_EPOCH', '1787875200', 'Process')
[Environment]::SetEnvironmentVariable('FORCE_SOURCE_DATE', '1', 'Process')
try {
    $dir = Join-Path $base 'en'
    Push-Location $dir
    try {
        & pdflatex -interaction=nonstopmode -halt-on-error main.tex *>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { throw 'en typesetting pass 1 failed' }
        & biber main *>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { throw 'en bibliography build failed' }
        & pdflatex -interaction=nonstopmode -halt-on-error main.tex *>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { throw 'en typesetting pass 2 failed' }
        $out = & pdflatex -interaction=nonstopmode -halt-on-error main.tex *>&1
        if ($LASTEXITCODE -ne 0) { throw 'en typesetting pass 3 failed' }
        $m = $out | Select-String "Output written on main.pdf \((\d+) page"
        $pages = if ($m) { $m.Matches.Groups[1].Value } else { "FAIL" }
        $errs = ($out | Select-String "^!").Count
        $undef = (Select-String -Path main.log -Pattern "undefined (reference|citation)" -EA SilentlyContinue).Count
        "en: pages={0} errors={1} undefined={2}" -f $pages, $errs, $undef
        if ($errs -gt 0) { $out | Select-String "^!" | Select-Object -First 5 }
    }
    finally {
        Pop-Location
    }
}
finally {
    [Environment]::SetEnvironmentVariable('SOURCE_DATE_EPOCH', $previousSourceDateEpoch, 'Process')
    [Environment]::SetEnvironmentVariable('FORCE_SOURCE_DATE', $previousForceSourceDate, 'Process')
}
