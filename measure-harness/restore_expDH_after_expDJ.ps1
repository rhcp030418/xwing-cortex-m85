param([string]$Project = 'C:\Users\cnscj\e2_studio\workspace\blinky')

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$HarnessDir = $PSScriptRoot
$Backup = Join-Path $HarnessDir 'staging\2026-08-31_pre-expDJ-harness.c'
$Harness = Join-Path $Project 'src\harness.c'
foreach ($Path in @($Harness, $Backup)) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "Missing restore input: $Path" }
}
$Current = [System.IO.File]::ReadAllText($Harness)
if (-not $Current.Contains('#include "expdj_harness.inc"') -or
    -not $Current.Contains('expdj_run_all();')) {
    throw 'Active project is not the expDJ measurement tree.'
}
Copy-Item -Force -LiteralPath $Backup -Destination $Harness
Write-Host 'Active source tree restored to the measured expDH parent.'

