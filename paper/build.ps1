# 원고 빌드: .\build.ps1 [ko|en]  (인자 없으면 둘 다)
param([string]$which = "all")

$base = $PSScriptRoot
$targets = @()
if ($which -eq "all" -or $which -eq "ko") { $targets += ,@("ko", "xelatex", "bibtex") }
if ($which -eq "all" -or $which -eq "en") { $targets += ,@("en", "pdflatex", "biber") }

foreach ($t in $targets) {
    $dir = Join-Path $base $t[0]
    $eng = $t[1]
    $bib = $t[2]
    Push-Location $dir
    & $eng -interaction=nonstopmode main.tex *>&1 | Out-Null
    & $bib main *>&1 | Out-Null
    & $eng -interaction=nonstopmode main.tex *>&1 | Out-Null
    $out = & $eng -interaction=nonstopmode main.tex *>&1
    $m = $out | Select-String "Output written on main.pdf \((\d+) page"
    $pages = if ($m) { $m.Matches.Groups[1].Value } else { "FAIL" }
    $errs = ($out | Select-String "^!").Count
    $undef = (Select-String -Path main.log -Pattern "undefined (reference|citation)" -EA SilentlyContinue).Count
    "{0}: pages={1} errors={2} undefined={3}" -f $t[0], $pages, $errs, $undef
    if ($errs -gt 0) { $out | Select-String "^!" | Select-Object -First 5 }
    Pop-Location
}
