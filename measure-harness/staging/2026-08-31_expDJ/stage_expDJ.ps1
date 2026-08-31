param([string]$Project = 'C:\Users\cnscj\e2_studio\workspace\blinky')

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$HarnessDir = $PSScriptRoot
$Harness = Join-Path $Project 'src\harness.c'
$Source = Join-Path $HarnessDir 'expDJ-src\expdj_harness.inc'
$Target = Join-Path $Project 'src\expdj_harness.inc'
$Backup = Join-Path $HarnessDir 'staging\2026-08-31_pre-expDJ-harness.c'
$ExpectedHarness = '90EABECA38924E2EC0DD5AF3EC66342CBF6971DD22A4827F3A32663EB12A9EAC'
$Utf8 = [System.Text.UTF8Encoding]::new($false)

foreach ($Path in @($Harness, $Source)) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "Missing expDJ input: $Path" }
}
$Text = [System.IO.File]::ReadAllText($Harness)
if (-not $Text.Contains('#include "expdj_harness.inc"')) {
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath $Harness).Hash -ne $ExpectedHarness -or
        -not $Text.Contains('#include "expdh_harness.inc"') -or
        -not $Text.Contains('run_on_stack(expdh_run_all, dtcm_stack + sizeof(dtcm_stack));')) {
        throw 'expDJ expects the restored measured expDH source tree.'
    }
    if (-not (Test-Path -LiteralPath $Backup)) { Copy-Item -LiteralPath $Harness -Destination $Backup }
    $Text = $Text.Replace('#include "expdh_harness.inc"',
                          '#include "expdh_harness.inc"' + "`n" + '#include "expdj_harness.inc"')
    $Text = $Text.Replace('run_on_stack(expdh_run_all, dtcm_stack + sizeof(dtcm_stack));',
                          'expdj_run_all();')
    [System.IO.File]::WriteAllText($Harness, $Text, $Utf8)
}
Copy-Item -Force -LiteralPath $Source -Destination $Target
Write-Host 'expDJ final same-ELF harness staged.'

