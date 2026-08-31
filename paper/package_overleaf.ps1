# 한국어 정본을 평탄화하고, 격리 빌드한 뒤 Overleaf 업로드 ZIP을 만든다.
$ErrorActionPreference = 'Stop'

$paperRoot = $PSScriptRoot
$sourceMain = Join-Path $paperRoot 'ko\main.tex'
$sourceBib = Join-Path $paperRoot 'references.bib'
$stageDir = Join-Path $paperRoot 'overleaf'
$stageMain = Join-Path $stageDir 'main.tex'
$stageBib = Join-Path $stageDir 'references.bib'
$zipPath = Join-Path $paperRoot 'overleaf-upload.zip'

function Write-DeterministicZip([string]$sourceRoot, [string]$destinationZip) {
    Add-Type -AssemblyName System.IO.Compression
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $sourcePrefix = $sourceRoot.TrimEnd('\') + '\'
    $fixedTimestamp = [DateTimeOffset]::new(2026, 8, 28, 0, 0, 0, [TimeSpan]::Zero)
    $zipStream = [System.IO.File]::Open(
        $destinationZip,
        [System.IO.FileMode]::Create,
        [System.IO.FileAccess]::ReadWrite,
        [System.IO.FileShare]::None
    )
    try {
        $archive = [System.IO.Compression.ZipArchive]::new(
            $zipStream,
            [System.IO.Compression.ZipArchiveMode]::Create,
            $false
        )
        try {
            foreach ($file in (Get-ChildItem -LiteralPath $sourceRoot -File | Sort-Object Name)) {
                if (-not $file.FullName.StartsWith(
                    $sourcePrefix, [System.StringComparison]::OrdinalIgnoreCase
                )) {
                    throw "ZIP path escaped packaging root: $($file.FullName)"
                }
                $relative = $file.FullName.Substring($sourcePrefix.Length).Replace('\', '/')
                $entry = $archive.CreateEntry(
                    $relative,
                    [System.IO.Compression.CompressionLevel]::Optimal
                )
                $entry.LastWriteTime = $fixedTimestamp
                $inputStream = [System.IO.File]::OpenRead($file.FullName)
                $entryStream = $entry.Open()
                try {
                    $inputStream.CopyTo($entryStream)
                }
                finally {
                    $entryStream.Dispose()
                    $inputStream.Dispose()
                }
            }
        }
        finally {
            $archive.Dispose()
        }
    }
    finally {
        $zipStream.Dispose()
    }
}

$mainText = [System.IO.File]::ReadAllText($sourceMain)
$canonicalBib = '\bibliography{../references}'
if (-not $mainText.Contains($canonicalBib)) {
    throw "Canonical bibliography path not found in $sourceMain"
}
$mainText = $mainText.Replace($canonicalBib, '\bibliography{references}')
[System.IO.File]::WriteAllText($stageMain, $mainText, [System.Text.UTF8Encoding]::new($false))
Copy-Item -LiteralPath $sourceBib -Destination $stageBib -Force

$uploadFiles = @(
    $stageMain,
    $stageBib,
    (Join-Path $stageDir 'llncs.cls'),
    (Join-Path $stageDir 'splncs04.bst'),
    (Join-Path $stageDir 'latexmkrc')
)
$tempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd('\')
$packageDir = Join-Path $tempRoot ('a-paper-package-' + [System.Guid]::NewGuid().ToString('N'))
$verifyDir = Join-Path $tempRoot ('a-paper-overleaf-' + [System.Guid]::NewGuid().ToString('N'))
$zipVerifyDir = Join-Path $tempRoot ('a-paper-overleaf-final-' + [System.Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $packageDir | Out-Null
New-Item -ItemType Directory -Path $verifyDir | Out-Null
New-Item -ItemType Directory -Path $zipVerifyDir | Out-Null
$previousSourceDateEpoch = [Environment]::GetEnvironmentVariable('SOURCE_DATE_EPOCH', 'Process')
$previousForceSourceDate = [Environment]::GetEnvironmentVariable('FORCE_SOURCE_DATE', 'Process')
[Environment]::SetEnvironmentVariable('SOURCE_DATE_EPOCH', '1787875200', 'Process')
[Environment]::SetEnvironmentVariable('FORCE_SOURCE_DATE', '1', 'Process')
try {
    $packageFiles = foreach ($source in $uploadFiles) {
        $destination = Join-Path $packageDir ([System.IO.Path]::GetFileName($source))
        Copy-Item -LiteralPath $source -Destination $destination
        $destination
    }
    Write-DeterministicZip $packageDir $zipPath
    Expand-Archive -LiteralPath $zipPath -DestinationPath $verifyDir
    Push-Location $verifyDir
    try {
        # Overleaf also compiles through latexmk.  The explicit -pdf simulates a
        # newly imported project's default compiler selection; latexmkrc must
        # still route that rule to XeLaTeX for the Korean font setup.
        & latexmk -gg -pdf -interaction=nonstopmode -halt-on-error main.tex | Out-Null
        if ($LASTEXITCODE -ne 0) { throw 'Isolated Overleaf-style latexmk build failed' }
    }
    finally {
        Pop-Location
    }

    $isolatedLog = Join-Path $verifyDir 'main.log'
    $logText = [System.IO.File]::ReadAllText($isolatedLog)
    if ($logText -notmatch '^This is XeTeX' -or
        $logText -match 'undefined (reference|citation)' -or
        $logText -match 'Overfull \\hbox' -or
        $logText -match 'Rerun to get cross-references right') {
        throw 'Isolated build did not use XeTeX or has an undefined item, overfull box, or unstable cross-reference'
    }
    Copy-Item -LiteralPath (Join-Path $verifyDir 'main.pdf') -Destination (Join-Path $stageDir 'main.pdf') -Force
    Copy-Item -LiteralPath (Join-Path $verifyDir 'main.pdf') -Destination (Join-Path $paperRoot 'ko\main.pdf') -Force
    foreach ($buildArtifact in @('main.aux', 'main.bbl', 'main.blg', 'main.log', 'main.out')) {
        $isolatedArtifact = Join-Path $verifyDir $buildArtifact
        Copy-Item -LiteralPath $isolatedArtifact -Destination (Join-Path $stageDir $buildArtifact) -Force
        Copy-Item -LiteralPath $isolatedArtifact -Destination (Join-Path $paperRoot ('ko\' + $buildArtifact)) -Force
    }
    Write-DeterministicZip $packageDir $zipPath
    Expand-Archive -LiteralPath $zipPath -DestinationPath $zipVerifyDir
    foreach ($name in @('main.tex', 'references.bib', 'llncs.cls', 'splncs04.bst', 'latexmkrc')) {
        $packed = Join-Path $zipVerifyDir $name
        $staged = Join-Path $packageDir $name
        if (-not (Test-Path -LiteralPath $packed -PathType Leaf) -or
            (Get-FileHash -Algorithm SHA256 -LiteralPath $packed).Hash -ne
            (Get-FileHash -Algorithm SHA256 -LiteralPath $staged).Hash) {
            throw "Final Overleaf ZIP mismatch: $name"
        }
    }
    $packedFiles = @(Get-ChildItem -LiteralPath $zipVerifyDir -File)
    if ($packedFiles.Count -ne 5) {
        throw "Final Overleaf ZIP has unexpected file count: $($packedFiles.Count)"
    }
    $pdfInfo = & pdfinfo (Join-Path $verifyDir 'main.pdf')
    $pageLine = $pdfInfo | Select-String '^Pages:'
    "Overleaf package: {0}; isolated {1}; source-files={2}" -f $zipPath, $pageLine.Line.Trim(), 5
}
finally {
    [Environment]::SetEnvironmentVariable('SOURCE_DATE_EPOCH', $previousSourceDateEpoch, 'Process')
    [Environment]::SetEnvironmentVariable('FORCE_SOURCE_DATE', $previousForceSourceDate, 'Process')
    foreach ($cleanup in @($packageDir, $verifyDir, $zipVerifyDir)) {
        $resolvedCleanup = [System.IO.Path]::GetFullPath($cleanup)
        $isPackage = $resolvedCleanup.StartsWith(
            $tempRoot + '\a-paper-package-', [System.StringComparison]::OrdinalIgnoreCase
        )
        $isVerify = $resolvedCleanup.StartsWith(
            $tempRoot + '\a-paper-overleaf-', [System.StringComparison]::OrdinalIgnoreCase
        )
        if (-not ($isPackage -or $isVerify)) {
            throw "Refusing to remove unexpected temporary path: $resolvedCleanup"
        }
        Remove-Item -LiteralPath $resolvedCleanup -Recurse -Force
    }
}
