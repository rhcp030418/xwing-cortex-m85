param([string]$Project = 'C:\Users\cnscj\e2_studio\workspace\blinky')

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$HarnessDir = $PSScriptRoot
$Source = Join-Path $HarnessDir 'expDI-src\expdi_harness.inc'
$Harness = Join-Path $Project 'src\harness.c'
$Asm = Join-Path $Project 'src\x25519\x25519-cortex-m4-gcc.s'
$Target = Join-Path $Project 'src\expdi_harness.inc'
$Backup = Join-Path $HarnessDir 'staging\2026-08-31_pre-expDI-active'
$Utf8 = [System.Text.UTF8Encoding]::new($false)

foreach ($Path in @($Source, $Harness, $Asm)) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "Missing expDI input: $Path" }
}
$HarnessText = [System.IO.File]::ReadAllText($Harness)
$AsmText = [System.IO.File]::ReadAllText($Asm)
$AlreadyPatched = $HarnessText.Contains('#include "expdi_harness.inc"') -and
                  $AsmText.Contains('.Lexpdi_sched:')

if (-not $AlreadyPatched) {
    if (-not $HarnessText.Contains('#include "expdh_harness.inc"') -or
        -not $HarnessText.Contains('run_on_stack(expdh_run_all, dtcm_stack + sizeof(dtcm_stack));') -or
        -not $AsmText.Contains('expdg_x25519_mode')) {
        throw 'expDI expects the measured expDH tree.'
    }
    if (-not (Test-Path -LiteralPath $Backup)) {
        New-Item -ItemType Directory -Path $Backup | Out-Null
        Copy-Item -LiteralPath $Harness -Destination (Join-Path $Backup 'harness.c')
        Copy-Item -LiteralPath $Asm -Destination (Join-Path $Backup 'x25519-cortex-m4-gcc.s')
    }
    $HarnessText = $HarnessText.Replace('#include "expdh_harness.inc"', '#include "expdi_harness.inc"')
    $HarnessText = $HarnessText.Replace(
        'run_on_stack(expdh_run_all, dtcm_stack + sizeof(dtcm_stack));',
        'run_on_stack(expdi_run_all, dtcm_stack + sizeof(dtcm_stack));')

    $Nl = if ($AsmText.Contains("`r`n")) { "`r`n" } else { "`n" }
    $Old = @(
        "`tvdup.32 q0,lr",
        "`tvldrw.u32 q1,[r0]",
        "`tvldrw.u32 q2,[r1]",
        "`tveor q3,q1,q2",
        "`tvand q3,q3,q0",
        "`tveor q1,q1,q3",
        "`tveor q2,q2,q3",
        "`tvstrw.u32 q1,[r0]",
        "`tvstrw.u32 q2,[r1]",
        "`tvldrw.u32 q1,[r0,#16]",
        "`tvldrw.u32 q2,[r1,#16]",
        "`tveor q3,q1,q2",
        "`tvand q3,q3,q0",
        "`tveor q1,q1,q3",
        "`tveor q2,q2,q3",
        "`tvstrw.u32 q1,[r0,#16]",
        "`tvstrw.u32 q2,[r1,#16]",
        "`tvldrw.u32 q1,[r0,#32]",
        "`tvldrw.u32 q2,[r1,#32]",
        "`tveor q3,q1,q2",
        "`tvand q3,q3,q0",
        "`tveor q1,q1,q3",
        "`tveor q2,q2,q3",
        "`tvstrw.u32 q1,[r0,#32]",
        "`tvstrw.u32 q2,[r1,#32]",
        "`tvldrw.u32 q1,[r0,#48]",
        "`tvldrw.u32 q2,[r1,#48]",
        "`tveor q3,q1,q2",
        "`tvand q3,q3,q0",
        "`tveor q1,q1,q3",
        "`tveor q2,q2,q3",
        "`tvstrw.u32 q1,[r0,#48]",
        "`tvstrw.u32 q2,[r1,#48]"
    ) -join $Nl
    if ($AsmText.IndexOf($Old) -lt 0 -or $AsmText.IndexOf($Old) -ne $AsmText.LastIndexOf($Old)) {
        throw 'expDI MVE replacement point is not unique.'
    }
    $New = @(
        "`tmovw r2,#:lower16:expdi_cswap_mode",
        "`tmovt r2,#:upper16:expdi_cswap_mode",
        "`tldr r2,[r2]",
        "`tcmp r2,#1",
        "`tbeq.w .Lexpdi_vpsel",
        "`tcmp r2,#2",
        "`tbeq.w .Lexpdi_sched",
        '.Lexpdi_xor:',
        $Old,
        "`tb.w .Lexpdi_done",
        '.Lexpdi_vpsel:',
        "`tvmsr p0,lr",
        "`tvldrw.u32 q1,[r0]",
        "`tvldrw.u32 q2,[r1]",
        "`tvpsel q3,q2,q1",
        "`tvpsel q2,q1,q2",
        "`tvstrw.u32 q3,[r0]",
        "`tvstrw.u32 q2,[r1]",
        "`tvldrw.u32 q1,[r0,#16]",
        "`tvldrw.u32 q2,[r1,#16]",
        "`tvpsel q3,q2,q1",
        "`tvpsel q2,q1,q2",
        "`tvstrw.u32 q3,[r0,#16]",
        "`tvstrw.u32 q2,[r1,#16]",
        "`tvldrw.u32 q1,[r0,#32]",
        "`tvldrw.u32 q2,[r1,#32]",
        "`tvpsel q3,q2,q1",
        "`tvpsel q2,q1,q2",
        "`tvstrw.u32 q3,[r0,#32]",
        "`tvstrw.u32 q2,[r1,#32]",
        "`tvldrw.u32 q1,[r0,#48]",
        "`tvldrw.u32 q2,[r1,#48]",
        "`tvpsel q3,q2,q1",
        "`tvpsel q2,q1,q2",
        "`tvstrw.u32 q3,[r0,#48]",
        "`tvstrw.u32 q2,[r1,#48]",
        "`tb.w .Lexpdi_done",
        '.Lexpdi_sched:',
        "`tvmsr p0,lr",
        "`tvldrw.u32 q0,[r0]",
        "`tvldrw.u32 q1,[r1]",
        "`tvpsel q2,q1,q0",
        "`tvldrw.u32 q3,[r0,#16]",
        "`tvpsel q1,q0,q1",
        "`tvstrw.u32 q2,[r0]",
        "`tvldrw.u32 q0,[r1,#16]",
        "`tvstrw.u32 q1,[r1]",
        "`tvpsel q2,q0,q3",
        "`tvldrw.u32 q1,[r0,#32]",
        "`tvpsel q0,q3,q0",
        "`tvstrw.u32 q2,[r0,#16]",
        "`tvldrw.u32 q3,[r1,#32]",
        "`tvstrw.u32 q0,[r1,#16]",
        "`tvpsel q2,q3,q1",
        "`tvldrw.u32 q0,[r0,#48]",
        "`tvpsel q3,q1,q3",
        "`tvstrw.u32 q2,[r0,#32]",
        "`tvldrw.u32 q1,[r1,#48]",
        "`tvstrw.u32 q3,[r1,#32]",
        "`tvpsel q2,q1,q0",
        "`tvstrw.u32 q2,[r0,#48]",
        "`tvpsel q1,q0,q1",
        "`tvstrw.u32 q1,[r1,#48]",
        '.Lexpdi_done:'
    ) -join $Nl
    $AsmText = $AsmText.Replace($Old, $New)

    $Extra = @(
        '',
        "`t.align 2",
        "`t.type expdi_cswap_xor, %function",
        "`t.global expdi_cswap_xor",
        'expdi_cswap_xor:',
        "`tvdup.32 q0,r2",
        "`tvldrw.u32 q1,[r0]",
        "`tvldrw.u32 q2,[r1]",
        "`tveor q3,q1,q2",
        "`tvand q3,q3,q0",
        "`tveor q1,q1,q3",
        "`tveor q2,q2,q3",
        "`tvstrw.u32 q1,[r0]",
        "`tvstrw.u32 q2,[r1]",
        "`tvldrw.u32 q1,[r0,#16]",
        "`tvldrw.u32 q2,[r1,#16]",
        "`tveor q3,q1,q2",
        "`tvand q3,q3,q0",
        "`tveor q1,q1,q3",
        "`tveor q2,q2,q3",
        "`tvstrw.u32 q1,[r0,#16]",
        "`tvstrw.u32 q2,[r1,#16]",
        "`tvldrw.u32 q1,[r0,#32]",
        "`tvldrw.u32 q2,[r1,#32]",
        "`tveor q3,q1,q2",
        "`tvand q3,q3,q0",
        "`tveor q1,q1,q3",
        "`tveor q2,q2,q3",
        "`tvstrw.u32 q1,[r0,#32]",
        "`tvstrw.u32 q2,[r1,#32]",
        "`tvldrw.u32 q1,[r0,#48]",
        "`tvldrw.u32 q2,[r1,#48]",
        "`tveor q3,q1,q2",
        "`tvand q3,q3,q0",
        "`tveor q1,q1,q3",
        "`tveor q2,q2,q3",
        "`tvstrw.u32 q1,[r0,#48]",
        "`tvstrw.u32 q2,[r1,#48]",
        "`tbx lr",
        "`t.size expdi_cswap_xor, .-expdi_cswap_xor",
        '',
        "`t.type expdi_cswap_vpsel, %function",
        "`t.global expdi_cswap_vpsel",
        'expdi_cswap_vpsel:',
        "`tvmsr p0,r2",
        "`tvldrw.u32 q1,[r0]",
        "`tvldrw.u32 q2,[r1]",
        "`tvpsel q3,q2,q1",
        "`tvpsel q2,q1,q2",
        "`tvstrw.u32 q3,[r0]",
        "`tvstrw.u32 q2,[r1]",
        "`tvldrw.u32 q1,[r0,#16]",
        "`tvldrw.u32 q2,[r1,#16]",
        "`tvpsel q3,q2,q1",
        "`tvpsel q2,q1,q2",
        "`tvstrw.u32 q3,[r0,#16]",
        "`tvstrw.u32 q2,[r1,#16]",
        "`tvldrw.u32 q1,[r0,#32]",
        "`tvldrw.u32 q2,[r1,#32]",
        "`tvpsel q3,q2,q1",
        "`tvpsel q2,q1,q2",
        "`tvstrw.u32 q3,[r0,#32]",
        "`tvstrw.u32 q2,[r1,#32]",
        "`tvldrw.u32 q1,[r0,#48]",
        "`tvldrw.u32 q2,[r1,#48]",
        "`tvpsel q3,q2,q1",
        "`tvpsel q2,q1,q2",
        "`tvstrw.u32 q3,[r0,#48]",
        "`tvstrw.u32 q2,[r1,#48]",
        "`tbx lr",
        "`t.size expdi_cswap_vpsel, .-expdi_cswap_vpsel",
        '',
        "`t.type expdi_cswap_sched, %function",
        "`t.global expdi_cswap_sched",
        'expdi_cswap_sched:',
        "`tvmsr p0,r2",
        "`tvldrw.u32 q0,[r0]",
        "`tvldrw.u32 q1,[r1]",
        "`tvpsel q2,q1,q0",
        "`tvldrw.u32 q3,[r0,#16]",
        "`tvpsel q1,q0,q1",
        "`tvstrw.u32 q2,[r0]",
        "`tvldrw.u32 q0,[r1,#16]",
        "`tvstrw.u32 q1,[r1]",
        "`tvpsel q2,q0,q3",
        "`tvldrw.u32 q1,[r0,#32]",
        "`tvpsel q0,q3,q0",
        "`tvstrw.u32 q2,[r0,#16]",
        "`tvldrw.u32 q3,[r1,#32]",
        "`tvstrw.u32 q0,[r1,#16]",
        "`tvpsel q2,q3,q1",
        "`tvldrw.u32 q0,[r0,#48]",
        "`tvpsel q3,q1,q3",
        "`tvstrw.u32 q2,[r0,#32]",
        "`tvldrw.u32 q1,[r1,#48]",
        "`tvstrw.u32 q3,[r1,#32]",
        "`tvpsel q2,q1,q0",
        "`tvstrw.u32 q2,[r0,#48]",
        "`tvpsel q1,q0,q1",
        "`tvstrw.u32 q1,[r1,#48]",
        "`tbx lr",
        "`t.size expdi_cswap_sched, .-expdi_cswap_sched",
        ''
    ) -join $Nl
    $AsmText += $Extra

    [System.IO.File]::WriteAllText($Harness, $HarnessText, $Utf8)
    [System.IO.File]::WriteAllText($Asm, $AsmText, $Utf8)
}
Copy-Item -Force -LiteralPath $Source -Destination $Target
Write-Host 'expDI M85 scheduling experiment staged.'
