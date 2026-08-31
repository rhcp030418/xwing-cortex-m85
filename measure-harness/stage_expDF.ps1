param(
    [string]$Project = 'C:\Users\cnscj\e2_studio\workspace\blinky'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$HarnessDir = $PSScriptRoot
$SourceDir = Join-Path $HarnessDir 'expDF-src'
$ProjectSrc = Join-Path $Project 'src'
$Harness = Join-Path $ProjectSrc 'harness.c'
$X25519 = Join-Path $ProjectSrc 'x25519_base.c'
$Backup = Join-Path $HarnessDir 'staging\2026-08-31_pre-expDF-active'
$ExpectedHarness = '4A483F1B2DE1D93716DE0BB77689648193DA5E86F22729F131C332719701BAAA'
$ExpectedX25519 = '274715D027030EB90D79BD9C5C9ED5481D6B29F656FA994E7162398BA7733E2C'
$Utf8 = [System.Text.UTF8Encoding]::new($false)

foreach ($Path in @($Harness, $X25519,
                     (Join-Path $SourceDir 'expdf_harness.inc'),
                     (Join-Path $SourceDir 'expdf_x25519.inc'))) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "Missing expDF input: $Path" }
}

$HarnessText = [System.IO.File]::ReadAllText($Harness)
$X25519Text = [System.IO.File]::ReadAllText($X25519)
$AlreadyPatched = $HarnessText.Contains('#include "expdf_harness.inc"') -and
                  $X25519Text.Contains('#include "expdf_x25519.inc"') -and
                  $HarnessText.Contains('run_on_stack(expdf_run_all, dtcm_stack + sizeof(dtcm_stack));')

if (-not $AlreadyPatched) {
    $HarnessHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Harness).Hash
    $X25519Hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $X25519).Hash
    if ($HarnessHash -ne $ExpectedHarness -or $X25519Hash -ne $ExpectedX25519) {
        throw "Active project is neither the registered baseline nor an expDF staging tree."
    }

    if (-not (Test-Path -LiteralPath $Backup)) {
        New-Item -ItemType Directory -Path $Backup | Out-Null
        Copy-Item -LiteralPath $Harness -Destination (Join-Path $Backup 'harness.c')
        Copy-Item -LiteralPath $X25519 -Destination (Join-Path $Backup 'x25519_base.c')
    }

    $Nl = if ($HarnessText.Contains("`r`n")) { "`r`n" } else { "`n" }
    $HarnessNeedle = $Nl + 'void harness_main(void)'
    if ($HarnessText.IndexOf($HarnessNeedle) -lt 0 -or
        $HarnessText.IndexOf($HarnessNeedle) -ne $HarnessText.LastIndexOf($HarnessNeedle)) {
        throw 'harness_main insertion point is not unique'
    }
    $HarnessText = $HarnessText.Replace(
        $HarnessNeedle,
        $Nl + '#include "expdf_harness.inc"' + $Nl + $Nl + 'void harness_main(void)')

    $CallNeedle = '    expdd_run_all();' + $Nl + '    uart_puts("HARNESS DONE\n");'
    $CallReplacement = '    run_on_stack(expdf_run_all, dtcm_stack + sizeof(dtcm_stack));' + $Nl +
                       '    uart_puts("HARNESS DONE\n");'
    if ($HarnessText.IndexOf($CallNeedle) -lt 0 -or
        $HarnessText.IndexOf($CallNeedle) -ne $HarnessText.LastIndexOf($CallNeedle)) {
        throw 'expDD early-return call point is not unique'
    }
    $HarnessText = $HarnessText.Replace($CallNeedle, $CallReplacement)

    $XNl = if ($X25519Text.Contains("`r`n")) { "`r`n" } else { "`n" }
    $X25519Text += $XNl + '#include "expdf_x25519.inc"' + $XNl
    [System.IO.File]::WriteAllText($Harness, $HarnessText, $Utf8)
    [System.IO.File]::WriteAllText($X25519, $X25519Text, $Utf8)
}

Copy-Item -Force -LiteralPath (Join-Path $SourceDir 'expdf_harness.inc') -Destination (Join-Path $ProjectSrc 'expdf_harness.inc')
Copy-Item -Force -LiteralPath (Join-Path $SourceDir 'expdf_x25519.inc') -Destination (Join-Path $ProjectSrc 'expdf_x25519.inc')

Write-Host 'expDF sources staged into the active e2studio project.'
