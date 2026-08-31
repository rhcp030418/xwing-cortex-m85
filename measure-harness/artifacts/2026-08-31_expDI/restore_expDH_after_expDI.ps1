param([string]$Project = 'C:\Users\cnscj\e2_studio\workspace\blinky')

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$HarnessDir = $PSScriptRoot
$Backup = Join-Path $HarnessDir 'staging\2026-08-31_pre-expDI-active'
$Harness = Join-Path $Project 'src\harness.c'
$Asm = Join-Path $Project 'src\x25519\x25519-cortex-m4-gcc.s'

foreach ($Path in @($Harness, $Asm, (Join-Path $Backup 'harness.c'),
                     (Join-Path $Backup 'x25519-cortex-m4-gcc.s'))) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "Missing restore input: $Path" }
}
$CurrentHarness = [System.IO.File]::ReadAllText($Harness)
$CurrentAsm = [System.IO.File]::ReadAllText($Asm)
if (-not $CurrentHarness.Contains('#include "expdi_harness.inc"') -or
    -not $CurrentAsm.Contains('.Lexpdi_sched:')) {
    throw 'Active project is not the expDI measurement tree.'
}
Copy-Item -Force -LiteralPath (Join-Path $Backup 'harness.c') -Destination $Harness
Copy-Item -Force -LiteralPath (Join-Path $Backup 'x25519-cortex-m4-gcc.s') -Destination $Asm
Write-Host 'Active source tree restored to the measured expDH parent.'
