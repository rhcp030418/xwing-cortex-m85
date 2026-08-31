param([string]$Project = 'C:\Users\cnscj\e2_studio\workspace\blinky')

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$HarnessDir = $PSScriptRoot
$Harness = Join-Path $Project 'src\harness.c'
$Source = Join-Path $HarnessDir 'expDH-src\expdh_harness.inc'
$Target = Join-Path $Project 'src\expdh_harness.inc'
$Backup = Join-Path $HarnessDir 'staging\2026-08-31_pre-expDH-harness.c'
$Utf8 = [System.Text.UTF8Encoding]::new($false)

if (-not (Test-Path -LiteralPath $Harness -PathType Leaf) -or
    -not (Test-Path -LiteralPath $Source -PathType Leaf)) { throw 'Missing expDH input' }
$Text = [System.IO.File]::ReadAllText($Harness)
if (-not $Text.Contains('#include "expdh_harness.inc"')) {
    if (-not $Text.Contains('#include "expdg_harness.inc"') -or
        -not $Text.Contains('run_on_stack(expdg_run_all, dtcm_stack + sizeof(dtcm_stack));')) {
        throw 'expDH expects the measured expDG staging tree.'
    }
    if (-not (Test-Path -LiteralPath $Backup)) { Copy-Item -LiteralPath $Harness -Destination $Backup }
    $Text = $Text.Replace('#include "expdg_harness.inc"', '#include "expdh_harness.inc"')
    $Text = $Text.Replace('run_on_stack(expdg_run_all, dtcm_stack + sizeof(dtcm_stack));',
                         'run_on_stack(expdh_run_all, dtcm_stack + sizeof(dtcm_stack));')
    [System.IO.File]::WriteAllText($Harness, $Text, $Utf8)
}
Copy-Item -Force -LiteralPath $Source -Destination $Target
Write-Host 'expDH current draft-10 full-path harness staged.'
