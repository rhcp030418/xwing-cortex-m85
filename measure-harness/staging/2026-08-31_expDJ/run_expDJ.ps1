param([string]$Project = 'C:\Users\cnscj\e2_studio\workspace\blinky')

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$Root = $PSScriptRoot
$Python = 'C:\Users\cnscj\AppData\Local\Programs\Python\Python314\python.exe'
$Make = 'C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\eclipse\plugins\com.renesas.ide.exttools.gnumake.win32.x86_64_4.3.1.v20240909-0854\mk\make.exe'
$Toolchain = 'C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin'
$Debug = Join-Path $Project 'Debug'
$Stage = Join-Path $Root 'staging\2026-08-31_expDJ'
$Artifact = Join-Path $Root 'artifacts\2026-08-31_expDJ'
$BuildLog = Join-Path $Stage '2026-08-31_expDJ_build.txt'
$RestoreLog = Join-Path $Stage '2026-08-31_expDJ_restore_expDH_build.txt'
$LockPath = Join-Path $Root '.ra8m1-measurement.lock'

foreach ($Path in @($Python, $Make, (Join-Path $Debug 'makefile'))) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "Missing expDJ tool/input: $Path" }
}
foreach ($Path in @($Stage, $Artifact)) {
    if (Test-Path -LiteralPath $Path) { throw "Refusing to overwrite existing expDJ output: $Path" }
}
$Lock = [System.IO.FileStream]::new($LockPath, [System.IO.FileMode]::CreateNew,
    [System.IO.FileAccess]::Write, [System.IO.FileShare]::None, 1,
    [System.IO.FileOptions]::DeleteOnClose)
try {
    New-Item -ItemType Directory -Path $Stage | Out-Null
    & (Join-Path $Root 'stage_expDJ.ps1') -Project $Project
    $SavedPath = $env:Path
    $SavedAction = $ErrorActionPreference
    try {
        $env:Path = "$Toolchain;$SavedPath"
        $ErrorActionPreference = 'Continue'
        $BuildOutput = & $Make -C $Debug -B -j2 all 2>&1
        $BuildExit = $LASTEXITCODE
    }
    finally {
        $env:Path = $SavedPath
        $ErrorActionPreference = $SavedAction
    }
    $BuildOutput | Set-Content -Encoding UTF8 -LiteralPath $BuildLog
    if ($BuildExit -ne 0) { throw 'expDJ build failed' }

    foreach ($Name in @('blinky.elf', 'blinky.srec', 'blinky.map')) {
        Copy-Item -LiteralPath (Join-Path $Debug $Name) -Destination (Join-Path $Stage $Name)
    }
    foreach ($Pair in @(
        @((Join-Path $Project 'src\harness.c'), 'harness.c'),
        @((Join-Path $Project 'src\expdj_harness.inc'), 'expdj_harness.inc'),
        @((Join-Path $Project 'src\x25519_base.c'), 'x25519_base.c'),
        @((Join-Path $Project 'src\x25519\x25519-cortex-m4-gcc.s'), 'x25519-cortex-m4-gcc.s'),
        @((Join-Path $Root '2026-08-31_expDJ_final_same_elf_prereg.md'), '2026-08-31_expDJ_final_same_elf_prereg.md'),
        @((Join-Path $Root 'harvest_ra8m1_expDJ.py'), 'harvest_ra8m1_expDJ.py'),
        @((Join-Path $Root 'harvest_ra8m1_expDE.py'), 'harvest_ra8m1_expDE.py'),
        @((Join-Path $Root 'run_harvest_logged.py'), 'run_harvest_logged.py'),
        @((Join-Path $Root 'stage_expDJ.ps1'), 'stage_expDJ.ps1'),
        @((Join-Path $Root 'restore_expDH_after_expDJ.ps1'), 'restore_expDH_after_expDJ.ps1')
    )) { Copy-Item -LiteralPath $Pair[0] -Destination (Join-Path $Stage $Pair[1]) }

    for ($Run = 1; $Run -le 5; $Run++) {
        $Log = Join-Path $Stage ("2026-08-31_expDJ_run{0}.txt" -f $Run)
        & $Python (Join-Path $Stage 'run_harvest_logged.py') `
            (Join-Path $Stage 'harvest_ra8m1_expDJ.py') $Log `
            --elf (Join-Path $Stage 'blinky.elf') --srec (Join-Path $Stage 'blinky.srec')
        if ($LASTEXITCODE -ne 0) { throw "expDJ board gate failed on run $Run" }
    }

    New-Item -ItemType Directory -Path $Artifact | Out-Null
    Copy-Item -Path (Join-Path $Stage '*') -Destination $Artifact -Recurse -Force

    & (Join-Path $Root 'restore_expDH_after_expDJ.ps1') -Project $Project
    $SavedPath = $env:Path
    $SavedAction = $ErrorActionPreference
    try {
        $env:Path = "$Toolchain;$SavedPath"
        $ErrorActionPreference = 'Continue'
        $RestoreOutput = & $Make -C $Debug -B -j2 all 2>&1
        $RestoreExit = $LASTEXITCODE
    }
    finally {
        $env:Path = $SavedPath
        $ErrorActionPreference = $SavedAction
    }
    $RestoreOutput | Set-Content -Encoding UTF8 -LiteralPath $RestoreLog
    if ($RestoreExit -ne 0) { throw 'expDH restore build failed' }
    $RestoredHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $Debug 'blinky.elf')).Hash
    if ($RestoredHash -ne '98D620B64816AE63ACFB80FA98A2428FD8AFE12D698E7E08729A2AD29907FA51') {
        throw "Restored expDH ELF hash mismatch: $RestoredHash"
    }
    Copy-Item -LiteralPath $RestoreLog -Destination (Join-Path $Artifact $RestoreLog.Split('\')[-1]) -Force
    Write-Host 'expDJ complete: five flashes frozen; active project restored to expDH.'
}
finally {
    $Lock.Dispose()
}
