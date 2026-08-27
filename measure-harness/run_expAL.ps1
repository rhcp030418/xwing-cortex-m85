param(
    [string]$Project = 'C:\Users\cnscj\e2_studio\workspace\blinky'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$HarnessDir = $PSScriptRoot
$Python = 'C:\Users\cnscj\AppData\Local\Programs\Python\Python314\python.exe'
if (-not (Test-Path -LiteralPath $Python)) { throw "Python 없음: $Python" }
$Make = 'C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\eclipse\plugins\com.renesas.ide.exttools.gnumake.win32.x86_64_4.3.1.v20240909-0854\mk\make.exe'
$Toolchain = 'C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin'
$Debug = Join-Path $Project 'Debug'
$Tools = Join-Path $HarnessDir 'expAL_tools.py'
$Logs = Join-Path $HarnessDir 'logs'
$Run1 = Join-Path $Logs '2026-08-24_expAL_run1.txt'
$Run2 = Join-Path $Logs '2026-08-24_expAL_run2.txt'
$BuildLog = Join-Path $Logs '2026-08-24_expAL_build.txt'
$Stage = Join-Path $HarnessDir 'staging\2026-08-24_expAL'
$Result = Join-Path $HarnessDir '2026-08-24_expAL_results.md'
$Artifact = Join-Path $HarnessDir 'artifacts\2026-08-24_expAL'
$LockPath = Join-Path $HarnessDir '.ra8m1-measurement.lock'

try {
    $LockStream = [System.IO.FileStream]::new(
        $LockPath,
        [System.IO.FileMode]::CreateNew,
        [System.IO.FileAccess]::Write,
        [System.IO.FileShare]::None,
        1,
        [System.IO.FileOptions]::DeleteOnClose
    )
}
catch {
    throw "다른 RA8M1 측정 runner가 실행 중이거나 lock이 남아 있음: $LockPath"
}

try {

foreach ($Output in @($BuildLog, $Run1, $Run2, $Stage, $Result, $Artifact)) {
    if (Test-Path -LiteralPath $Output) { throw "기존 결과를 덮지 않음: $Output" }
}

& $Python $Tools check --project $Project
if ($LASTEXITCODE -ne 0) { throw 'expAL preflight failed' }

& $Python $Tools apply --project $Project
if ($LASTEXITCODE -ne 0) { throw 'expAL apply failed' }

$SourceBefore = (& $Python $Tools fingerprint --project $Project | Select-Object -Last 1).Trim()
if ($LASTEXITCODE -ne 0 -or $SourceBefore.Length -ne 64) {
    throw 'expAL pre-build source fingerprint failed'
}

New-Item -ItemType Directory -Force -Path $Logs | Out-Null
$SavedPath = $env:Path
$SavedErrorAction = $ErrorActionPreference
try {
    $env:Path = "$Toolchain;$SavedPath"
    $ErrorActionPreference = 'Continue'
    $BuildOutput = & $Make -C $Debug -B -j2 all 2>&1
    $BuildExit = $LASTEXITCODE
}
finally {
    $env:Path = $SavedPath
    $ErrorActionPreference = $SavedErrorAction
}
$BuildOutput | ForEach-Object { Write-Host $_ }
$BuildOutput | Set-Content -Encoding UTF8 -LiteralPath $BuildLog
if ($BuildExit -ne 0) { throw 'expAL build failed' }

$SourceAfter = (& $Python $Tools fingerprint --project $Project | Select-Object -Last 1).Trim()
if ($LASTEXITCODE -ne 0 -or $SourceAfter -ne $SourceBefore) {
    throw 'project source changed during expAL build'
}

& $Python $Tools stage --project $Project --stage $Stage --build-log $BuildLog --source-fingerprint $SourceBefore
if ($LASTEXITCODE -ne 0) { throw 'expAL pre-flash freeze failed' }
$FrozenElf = Join-Path $Stage 'blinky.elf'
$FrozenSrec = Join-Path $Stage 'blinky.srec'
$FrozenHarvester = Join-Path $Stage 'harvest_ra8m1_expAL.py'
$FrozenLogger = Join-Path $Stage 'run_harvest_logged.py'
$FrozenTools = Join-Path $Stage 'expAL_tools.py'

& $Python $FrozenLogger $FrozenHarvester $Run1 --elf $FrozenElf --srec $FrozenSrec
$Run1Exit = $LASTEXITCODE
& $Python $FrozenLogger $FrozenHarvester $Run2 --elf $FrozenElf --srec $FrozenSrec
$Run2Exit = $LASTEXITCODE

& $Python $FrozenTools report --project $Project --stage $Stage --logs $Run1 $Run2 --result $Result --artifact $Artifact
$ReportExit = $LASTEXITCODE
& $Python $FrozenTools freeze --project $Project --stage $Stage --logs $Run1 $Run2 --result $Result --artifact $Artifact
if ($LASTEXITCODE -ne 0) { throw 'expAL artifact freeze failed' }

if ($Run1Exit -ne 0 -or $Run2Exit -ne 0) {
    throw 'expAL artifacts were preserved, but at least one firmware gate failed.'
}
if ($ReportExit -ne 0) {
    throw 'expAL artifacts were preserved, but the preregistered performance verdict was NOT PASS.'
}
Write-Host 'expAL complete: two flashes, report, and clean-room artifact are ready.'
}
finally {
    $LockStream.Dispose()
}
