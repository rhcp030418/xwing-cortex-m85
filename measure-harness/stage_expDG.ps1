param(
    [string]$Project = 'C:\Users\cnscj\e2_studio\workspace\blinky'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$HarnessDir = $PSScriptRoot
$SourceDir = Join-Path $HarnessDir 'expDG-src'
$ProjectSrc = Join-Path $Project 'src'
$Harness = Join-Path $ProjectSrc 'harness.c'
$XBase = Join-Path $ProjectSrc 'x25519_base.c'
$XAsm = Join-Path $ProjectSrc 'x25519\x25519-cortex-m4-gcc.s'
$Backup = Join-Path $HarnessDir 'staging\2026-08-31_pre-expDG-active'
$Utf8 = [System.Text.UTF8Encoding]::new($false)

foreach ($Path in @($Harness, $XBase, $XAsm,
                     (Join-Path $SourceDir 'expdg_harness.inc'),
                     (Join-Path $SourceDir 'expdg_x25519.inc'))) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "Missing expDG input: $Path" }
}

$HarnessText = [System.IO.File]::ReadAllText($Harness)
$XBaseText = [System.IO.File]::ReadAllText($XBase)
$XAsmText = [System.IO.File]::ReadAllText($XAsm)
$AlreadyPatched = $HarnessText.Contains('#include "expdg_harness.inc"') -and
                  $XBaseText.Contains('#include "expdg_x25519.inc"') -and
                  $XAsmText.Contains('expdg_x25519_mode')

if (-not $AlreadyPatched) {
    if (-not $HarnessText.Contains('#include "expdf_harness.inc"') -or
        -not $HarnessText.Contains('run_on_stack(expdf_run_all, dtcm_stack + sizeof(dtcm_stack));') -or
        -not $XBaseText.Contains('#include "expdf_x25519.inc"')) {
        throw 'expDG expects the measured expDF staging tree as its input.'
    }
    if (-not (Test-Path -LiteralPath $Backup)) {
        New-Item -ItemType Directory -Path $Backup | Out-Null
        Copy-Item -LiteralPath $Harness -Destination (Join-Path $Backup 'harness.c')
        Copy-Item -LiteralPath $XBase -Destination (Join-Path $Backup 'x25519_base.c')
        Copy-Item -LiteralPath $XAsm -Destination (Join-Path $Backup 'x25519-cortex-m4-gcc.s')
    }

    $HarnessText = $HarnessText.Replace('#include "expdf_harness.inc"',
                                        '#include "expdg_harness.inc"')
    $HarnessText = $HarnessText.Replace(
        'run_on_stack(expdf_run_all, dtcm_stack + sizeof(dtcm_stack));',
        'run_on_stack(expdg_run_all, dtcm_stack + sizeof(dtcm_stack));')

    $XNl = if ($XBaseText.Contains("`r`n")) { "`r`n" } else { "`n" }
    $XBaseText += '#include "expdg_x25519.inc"' + $XNl

    $Nl = if ($XAsmText.Contains("`r`n")) { "`r`n" } else { "`n" }
    $CswapStartNeedle = 'rsbs lr,r1,#0'
    $CswapEndNeedle = '// 40*4 - 2 = 158 cycles'
    $CswapStart = $XAsmText.IndexOf($CswapStartNeedle)
    $CswapEnd = $XAsmText.IndexOf($CswapEndNeedle, $CswapStart)
    if ($CswapStart -lt 0 -or $CswapEnd -lt 0 -or
        $CswapStart -ne $XAsmText.LastIndexOf($CswapStartNeedle) -or
        $CswapEnd -ne $XAsmText.LastIndexOf($CswapEndNeedle)) {
        throw 'scalar cswap replacement point is not unique'
    }
    $Cswap = @(
        "`trsbs lr,r1,#0",
        '',
        "`tmovw r2,#:lower16:expdg_x25519_mode",
        "`tmovt r2,#:upper16:expdg_x25519_mode",
        "`tldr r2,[r2]",
        "`ttst r2,#1",
        "`tbne.w 2f",
        '',
        "`tmov r0,sp",
        "`tadd r1,sp,#64",
        "`tmov r11,#4",
        '1:',
        "`tldm r0,{r2-r5}",
        "`tldm r1,{r6-r9}",
        "`teors r2,r2,r6",
        "`tand r10,r2,lr",
        "`teors r6,r6,r10",
        "`teors r2,r2,r6",
        "`teors r3,r3,r7",
        "`tand r10,r3,lr",
        "`teors r7,r7,r10",
        "`teors r3,r3,r7",
        "`teors r4,r4,r8",
        "`tand r10,r4,lr",
        "`teors r8,r8,r10",
        "`teors r4,r4,r8",
        "`teors r5,r5,r9",
        "`tand r10,r5,lr",
        "`teors r9,r9,r10",
        "`teors r5,r5,r9",
        "`tstm r0!,{r2-r5}",
        "`tstm r1!,{r6-r9}",
        "`tsubs r11,#1",
        "`tbne 1b",
        "`tb.w 3f",
        '2:',
        "`tmov r0,sp",
        "`tadd r1,sp,#64",
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
        "`tvstrw.u32 q2,[r1,#48]",
        '3:'
    ) -join $Nl
    $CswapEnd += $CswapEndNeedle.Length
    $XAsmText = $XAsmText.Substring(0, $CswapStart) + $Cswap +
                $XAsmText.Substring($CswapEnd)

    $TailNeedle = "`t// now we must invert zp"
    if ($XAsmText.IndexOf($TailNeedle) -lt 0 -or
        $XAsmText.IndexOf($TailNeedle) -ne $XAsmText.LastIndexOf($TailNeedle)) {
        throw 'projective return point is not unique'
    }
    $Tail = @(
        "`tmovw r2,#:lower16:expdg_x25519_mode",
        "`tmovt r2,#:upper16:expdg_x25519_mode",
        "`tldr r2,[r2]",
        "`ttst r2,#2",
        "`tbeq.w 4f",
        "`tldr r8,[sp,#200]",
        "`tldmia sp,{r0-r7}",
        "`tstmia r8!,{r0-r7}",
        "`tadd r9,sp,#32",
        "`tldmia r9,{r0-r7}",
        "`tstmia r8!,{r0-r7}",
        "`tadd sp,sp,#204",
        "`tpop {r4-r11,pc}",
        '4:',
        '',
        $TailNeedle
    ) -join $Nl
    $XAsmText = $XAsmText.Replace($TailNeedle, $Tail)

    [System.IO.File]::WriteAllText($Harness, $HarnessText, $Utf8)
    [System.IO.File]::WriteAllText($XBase, $XBaseText, $Utf8)
    [System.IO.File]::WriteAllText($XAsm, $XAsmText, $Utf8)
}

Copy-Item -Force -LiteralPath (Join-Path $SourceDir 'expdg_harness.inc') -Destination (Join-Path $ProjectSrc 'expdg_harness.inc')
Copy-Item -Force -LiteralPath (Join-Path $SourceDir 'expdg_x25519.inc') -Destination (Join-Path $ProjectSrc 'expdg_x25519.inc')
Write-Host 'expDG full-path sources staged into the active e2studio project.'
