# Build the supplementary reproducibility archive in an ASCII-named ZIP.
$ErrorActionPreference = 'Stop'

$paperRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$topicRoot = Split-Path $paperRoot -Parent
$harnessRoot = Join-Path $topicRoot 'measure-harness'
$manuscriptRoot = Join-Path $paperRoot 'lncs_new_en'
$tempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd('\')
$stageRoot = Join-Path $tempRoot ('a-paper-artifact-' + [System.Guid]::NewGuid().ToString('N'))
$verifyRoot = Join-Path $tempRoot ('a-paper-artifact-verify-' + [System.Guid]::NewGuid().ToString('N'))
$zipPath = Join-Path $paperRoot 'artifact-upload.zip'
$gnuToolRoot = Join-Path $env:SystemDrive `
    'Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin'
$stripTool = Join-Path $gnuToolRoot 'arm-none-eabi-strip.exe'
$objcopyTool = Join-Path $gnuToolRoot 'arm-none-eabi-objcopy.exe'

function Copy-ArtifactFile([string]$source, [string]$relative) {
    $destination = Join-Path $stageRoot $relative
    $parent = Split-Path $destination -Parent
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
    Copy-Item -LiteralPath $source -Destination $destination -Force
}

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
            foreach ($file in (Get-ChildItem -LiteralPath $sourceRoot -File -Recurse | Sort-Object FullName)) {
                if (-not $file.FullName.StartsWith(
                    $sourcePrefix, [System.StringComparison]::OrdinalIgnoreCase
                )) {
                    throw "ZIP path escaped staging root: $($file.FullName)"
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

function Contains-PrivateToken([byte[]]$bytes, [string[]]$tokens) {
    $utf8 = [System.Text.Encoding]::UTF8.GetString($bytes)
    $utf16 = [System.Text.Encoding]::Unicode.GetString($bytes)
    foreach ($token in $tokens) {
        if ($token.Length -ge 3 -and (
            $utf8.IndexOf($token, [System.StringComparison]::OrdinalIgnoreCase) -ge 0 -or
            $utf16.IndexOf($token, [System.StringComparison]::OrdinalIgnoreCase) -ge 0
        )) {
            return $true
        }
    }
    return $false
}

function Assert-NoPrivateIdentifiers([string]$root, [string[]]$tokens) {
    foreach ($file in (Get-ChildItem -LiteralPath $root -File -Recurse)) {
        $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
        if (Contains-PrivateToken $bytes $tokens) {
            throw "Private identifier remains in artifact: $($file.FullName)"
        }
    }
}

function Convert-HexToBytes([string]$hex) {
    if (($hex.Length % 2) -ne 0) {
        throw "Odd-length hexadecimal record"
    }
    $bytes = New-Object byte[] ($hex.Length / 2)
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $bytes[$i] = [Convert]::ToByte($hex.Substring(2 * $i, 2), 16)
    }
    return $bytes
}

function Get-SrecDataHash([string]$path) {
    $dataLines = [System.Collections.Generic.List[string]]::new()
    foreach ($source in [System.IO.File]::ReadAllLines($path, [System.Text.Encoding]::ASCII)) {
        $line = $source.Trim().ToUpperInvariant()
        if ($line -notmatch '^S[123][0-9A-F]+$') {
            continue
        }
        $record = Convert-HexToBytes ($line.Substring(2))
        if ($record.Length -eq 0 -or $record[0] -ne $record.Length - 1) {
            throw "S-record byte-count mismatch: $path"
        }
        $sum = 0
        foreach ($value in $record) {
            $sum = ($sum + $value) -band 0xff
        }
        if ($sum -ne 0xff) {
            throw "S-record checksum mismatch: $path"
        }
        $dataLines.Add($line)
    }
    if ($dataLines.Count -eq 0) {
        throw "S-record has no data records: $path"
    }
    $canonical = ($dataLines -join "`n") + "`n"
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        $digest = $sha.ComputeHash([System.Text.Encoding]::ASCII.GetBytes($canonical))
    }
    finally {
        $sha.Dispose()
    }
    return ([System.BitConverter]::ToString($digest)).Replace('-', '')
}

function Protect-ArtifactAnonymity([string]$root) {
    if (-not (Test-Path -LiteralPath $stripTool -PathType Leaf) -or
        -not (Test-Path -LiteralPath $objcopyTool -PathType Leaf)) {
        throw 'ARM GNU strip/objcopy tools are required for blind artifact packaging'
    }

    $outerProject = Split-Path (Split-Path $topicRoot -Parent) -Leaf
    $profileUser = if ([string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
        ''
    }
    else {
        Split-Path $env:USERPROFILE -Leaf
    }
    $privateTokens = @($profileUser, $outerProject, 'rhcp030418', '박도윤') |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    $textExtensions = [System.Collections.Generic.HashSet[string]]::new(
        [System.StringComparer]::OrdinalIgnoreCase
    )
    foreach ($extension in @(
        '.asm', '.bat', '.bib', '.c', '.cfg', '.cmake', '.csv', '.d', '.h', '.i',
        '.inc', '.in', '.ini', '.json', '.ld', '.log', '.map', '.md', '.mk', '.ps1',
        '.py', '.s', '.sh', '.srec', '.tex', '.toml', '.tsv', '.txt', '.yaml', '.yml'
    )) {
        $textExtensions.Add($extension) | Out-Null
    }

    $redactedTextFiles = 0
    $binaryRecords = [System.Collections.Generic.List[object]]::new()
    foreach ($file in (Get-ChildItem -LiteralPath $root -File -Recurse | Sort-Object FullName)) {
        $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
        $isElf = $bytes.Length -ge 4 -and $bytes[0] -eq 0x7f -and
            $bytes[1] -eq 0x45 -and $bytes[2] -eq 0x4c -and $bytes[3] -eq 0x46
        if ($isElf -and (Contains-PrivateToken $bytes $privateTokens)) {
            $rawHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $file.FullName).Hash
            $loadHash = 'not-applicable (relocatable object)'
            $beforeSrec = $file.FullName + '.anon-before.srec'
            $afterSrec = $file.FullName + '.anon-after.srec'
            $checkLoadImage = $file.Extension.Equals('.elf', [System.StringComparison]::OrdinalIgnoreCase)
            try {
                if ($checkLoadImage) {
                    & $objcopyTool -O srec $file.FullName $beforeSrec
                    if ($LASTEXITCODE -ne 0) {
                        throw "objcopy failed before ELF anonymization: $($file.FullName)"
                    }
                }
                & $stripTool --strip-debug $file.FullName
                if ($LASTEXITCODE -ne 0) {
                    throw "strip failed during ELF anonymization: $($file.FullName)"
                }
                if ($checkLoadImage) {
                    & $objcopyTool -O srec $file.FullName $afterSrec
                    if ($LASTEXITCODE -ne 0) {
                        throw "objcopy failed after ELF anonymization: $($file.FullName)"
                    }
                    $beforeHash = Get-SrecDataHash $beforeSrec
                    $afterHash = Get-SrecDataHash $afterSrec
                    if ($beforeHash -ne $afterHash) {
                        throw "ELF load image changed during anonymization: $($file.FullName)"
                    }
                    $loadHash = $afterHash
                }
            }
            finally {
                foreach ($temporary in @($beforeSrec, $afterSrec)) {
                    if (Test-Path -LiteralPath $temporary -PathType Leaf) {
                        Remove-Item -LiteralPath $temporary -Force
                    }
                }
            }
            $relative = $file.FullName.Substring($root.TrimEnd('\').Length + 1).Replace('\', '/')
            $binaryRecords.Add([pscustomobject]@{
                Path = $relative
                RawHash = $rawHash
                AnonymousHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $file.FullName).Hash
                LoadHash = $loadHash
            })
            continue
        }

        if (-not $textExtensions.Contains($file.Extension)) {
            continue
        }
        if (-not (Contains-PrivateToken $bytes $privateTokens)) {
            continue
        }
        $encoding = $null
        $offset = 0
        if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xef -and $bytes[1] -eq 0xbb -and $bytes[2] -eq 0xbf) {
            $encoding = [System.Text.UTF8Encoding]::new($true, $true)
            $offset = 3
        }
        elseif ($bytes.Length -ge 2 -and $bytes[0] -eq 0xff -and $bytes[1] -eq 0xfe) {
            $encoding = [System.Text.UnicodeEncoding]::new($false, $true, $true)
            $offset = 2
        }
        elseif ($bytes.Length -ge 2 -and $bytes[0] -eq 0xfe -and $bytes[1] -eq 0xff) {
            $encoding = [System.Text.UnicodeEncoding]::new($true, $true, $true)
            $offset = 2
        }
        else {
            $encoding = [System.Text.UTF8Encoding]::new($false, $true)
        }
        try {
            $text = $encoding.GetString($bytes, $offset, $bytes.Length - $offset)
        }
        catch [System.Text.DecoderFallbackException] {
            continue
        }
        $sanitized = [regex]::Replace(
            $text, '(?i)[A-Z]:/Users/[^/\s]+', 'C:/Users/anonymous'
        )
        $sanitized = [regex]::Replace(
            $sanitized, '(?i)[A-Z]:\\Users\\[^\\\s]+', 'C:\Users\anonymous'
        )
        $sanitized = [regex]::Replace(
            $sanitized, '/home/[^/\s]+', '/home/anonymous'
        )
        $sanitized = [regex]::Replace(
            $sanitized, '(?i)/mnt/([a-z])/Users/[^/\s]+', '/mnt/$1/Users/anonymous'
        )
        if (-not [string]::IsNullOrWhiteSpace($profileUser)) {
            $sanitized = $sanitized.Replace($profileUser, 'anonymous')
        }
        if (-not [string]::IsNullOrWhiteSpace($outerProject)) {
            $sanitized = $sanitized.Replace($outerProject, 'anonymous-project')
        }
        if ($sanitized -ne $text) {
            [byte[]]$output = $encoding.GetPreamble() + $encoding.GetBytes($sanitized)
            [System.IO.File]::WriteAllBytes($file.FullName, $output)
            $redactedTextFiles++
        }
    }

    $report = [System.Collections.Generic.List[string]]::new()
    $report.Add('# Blind-review anonymization')
    $report.Add('')
    $report.Add('This file is generated by `paper/package_artifact.ps1`. Source-tree files are not rewritten.')
    $report.Add('Absolute Windows/WSL home paths and the outer personal project-folder segment are replaced only in staged text copies.')
    $report.Add('ELF/object files containing private build paths have non-loadable debug sections removed with `arm-none-eabi-strip --strip-debug`.')
    $report.Add('For every stripped executable ELF, normalized S1/S2/S3 data records from `objcopy -O srec` are byte-identical before and after stripping; measured SREC files are copied unchanged.')
    $report.Add('Historical SHA-256 ledgers inside frozen directories continue to identify the unredacted research originals; `MANIFEST.sha256` identifies the submitted anonymous copies.')
    $report.Add('')
    $report.Add("- Redacted text files: $redactedTextFiles")
    $report.Add("- Debug-stripped ELF/object files: $($binaryRecords.Count)")
    $report.Add('')
    $report.Add('| submitted path | original SHA-256 | anonymous SHA-256 | load-image SREC-data SHA-256 |')
    $report.Add('|---|---|---|---|')
    foreach ($record in $binaryRecords) {
        $report.Add(('| `{0}` | `{1}` | `{2}` | `{3}` |' -f
            $record.Path, $record.RawHash, $record.AnonymousHash, $record.LoadHash))
    }
    [System.IO.File]::WriteAllLines(
        (Join-Path $root 'ANONYMIZATION.md'),
        $report,
        [System.Text.UTF8Encoding]::new($false)
    )
    Assert-NoPrivateIdentifiers $root $privateTokens
    return [pscustomobject]@{
        TextFiles = $redactedTextFiles
        BinaryFiles = $binaryRecords.Count
        PrivateTokens = $privateTokens
    }
}

New-Item -ItemType Directory -Path $stageRoot | Out-Null
New-Item -ItemType Directory -Path $verifyRoot | Out-Null
try {
    Copy-ArtifactFile (Join-Path $paperRoot 'ARTIFACT_README.md') 'README.md'
    foreach ($name in @(
        'main.tex',
        'main.pdf',
        'references.bib',
        'build_assets.py',
        'llncs.cls',
        'splncs04.bst',
        'TRANSLATION_CRITERIA.md',
        'README.md'
    )) {
        Copy-ArtifactFile (Join-Path $manuscriptRoot $name) (Join-Path 'paper\manuscript' $name)
    }
    $manuscriptStage = Join-Path $stageRoot 'paper\manuscript'
    Copy-Item -LiteralPath (Join-Path $manuscriptRoot 'assets') `
        -Destination $manuscriptStage -Recurse -Force
    Copy-Item -LiteralPath (Join-Path $manuscriptRoot 'data') `
        -Destination $manuscriptStage -Recurse -Force
    Copy-ArtifactFile (Join-Path $topicRoot '논문_데이터_표.md') 'paper\논문_데이터_표.md'
    Copy-ArtifactFile (Join-Path $topicRoot '분모_정의_통일.md') 'paper\분모_정의_통일.md'
    Copy-ArtifactFile (Join-Path $paperRoot '데이터_누적_검증대장.md') 'paper\데이터_누적_검증대장.md'
    Copy-ArtifactFile (Join-Path $paperRoot '데이터_계보_아티팩트_정합성.md') 'paper\데이터_계보_아티팩트_정합성.md'
    Copy-ArtifactFile (Join-Path $paperRoot '자원_비용_감사.md') 'paper\자원_비용_감사.md'
    Copy-ArtifactFile (Join-Path $paperRoot '분모_표준화_카탈로그.tsv') 'paper\분모_표준화_카탈로그.tsv'
    Copy-ArtifactFile (Join-Path $harnessRoot 'slot_bound_t18.py') 'measure-harness\slot_bound_t18.py'
    Copy-ArtifactFile (Join-Path $topicRoot 'artifact\README.md') 'artifact\README.md'
    Copy-ArtifactFile (Join-Path $topicRoot 'artifact\board-src\itcm_pad.c') 'artifact\board-src\itcm_pad.c'

    foreach ($name in @(
        '2026-08-28_expCL_icount_reaudit_protocol.md',
        '2026-08-28_expCL_results.md',
        '2026-08-28_expCM_d10_full_vector_prereg.md',
        '2026-08-28_expCM_d10_full_vector_results.md',
        '2026-08-28_expCN_cp_sat_repro_results.md',
        '2026-08-28_expCO_incontext_checkpoint_prereg.md',
        '2026-08-28_expCO_results.md',
        '2026-08-28_expCP_wider_coverage_prereg.md',
        '2026-08-28_expCP_results.md',
        '2026-08-28_expCQ_results.md',
        '2026-08-28_expCR_lenngren_yield1_prereg.md',
        '2026-08-28_expCR_results.md',
        '2026-08-28_expCS_solver_phase0_prereg.md',
        '2026-08-28_expCS_results.md',
        '2026-08-28_expCT_seed_sweep_prereg.md',
        '2026-08-28_expCT_results.md',
        '2026-08-28_expCU_CV_CW_CX_prereg.md',
        '2026-08-28_expCU_CV_CW_CX_results.md',
        '2026-08-28_expCY_cumulative_5run_prereg.md',
        '2026-08-28_expCY_results.md',
        '2026-08-28_expCZ_current_board_recheck_prereg.md',
        '2026-08-28_expCZ_results.md',
        '2026-08-28_expDA_77pct_coverage_prereg.md',
        '2026-08-28_expDA_results.md',
        '2026-08-28_expDB_full_solver_prereg.md',
        '2026-08-28_expDB_protocol_amendment.md',
        '2026-08-28_expDB_results.md',
        '2026-08-28_expDC_lenngren_uprime_prereg.md',
        '2026-08-28_expDC_results.md',
        '2026-08-30_expDD_pmu_recovery_prereg.md',
        '2026-08-30_expDD_results.md',
        '2026-08-30_expDE_minimal_deployment_prereg.md',
        '2026-08-30_expDE_results.md',
        '2026-08-31_expDF_four_gates_prereg.md',
        '2026-08-31_expDF_four_gates_results.md',
        '2026-08-31_expDG_full_xwing_prereg.md',
        '2026-08-31_expDH_draft10_full_prereg.md',
        '2026-08-31_expDH_draft10_full_results.md',
        '2026-08-31_expDI_m85_schedule_prereg.md',
        '2026-08-31_expDI_m85_schedule_results.md',
        '2026-08-31_expDJ_final_same_elf_prereg.md',
        '2026-08-31_expDJ_final_same_elf_results.md',
        'harvest_ra8m1_expDE.py',
        'harvest_ra8m1_expDJ.py',
        'run_expDJ.ps1',
        'stage_expDJ.ps1',
        'restore_expDH_after_expDJ.ps1',
        'generate_d10_kat.py',
        'summarize_expCL.py',
        'run_harvest_logged.py'
    )) {
        Copy-ArtifactFile (Join-Path $harnessRoot $name) (Join-Path 'measure-harness' $name)
    }

    $artifactParent = Join-Path $stageRoot 'measure-harness\artifacts'
    New-Item -ItemType Directory -Path $artifactParent -Force | Out-Null
    foreach ($name in @(
        '2026-08-27_expCK_fiatx4_slot_accounting',
        '2026-08-27_expCJ',
        '2026-08-28_expCM_d10_full_vector',
        '2026-08-28_expCN_cp_sat_repro',
        '2026-08-28_expCO',
        '2026-08-28_expCP',
        '2026-08-28_expCQ',
        '2026-08-28_expCR',
        '2026-08-28_expCS',
        '2026-08-28_expCT_seed_sweep',
        '2026-08-28_expCUWX',
        '2026-08-28_expDA',
        '2026-08-28_expDB',
        '2026-08-28_expDC',
        '2026-08-31_expDF_DH',
        '2026-08-31_expDI',
        '2026-08-31_expDJ'
    )) {
        Copy-Item -LiteralPath (Join-Path $harnessRoot ('artifacts\' + $name)) `
            -Destination $artifactParent -Recurse -Force
    }
    Copy-Item -LiteralPath (Join-Path $harnessRoot 'logs') `
        -Destination (Join-Path $stageRoot 'measure-harness') -Recurse -Force
    Copy-Item -LiteralPath (Join-Path $harnessRoot 'expCJ-src') `
        -Destination (Join-Path $stageRoot 'measure-harness') -Recurse -Force
    $newStageParent = Join-Path $stageRoot 'measure-harness\staging'
    New-Item -ItemType Directory -Path $newStageParent -Force | Out-Null
    foreach ($name in @('2026-08-30_expDD_wrap', '2026-08-30_expDE', '2026-08-31_expDI', '2026-08-31_expDJ')) {
        Copy-Item -LiteralPath (Join-Path $harnessRoot ('staging\' + $name)) `
            -Destination $newStageParent -Recurse -Force
    }
    Copy-Item -LiteralPath (Join-Path $topicRoot 'slothy-2stream') `
        -Destination $stageRoot -Recurse -Force

    foreach ($cacheDir in @(Get-ChildItem -LiteralPath $stageRoot -Directory -Filter '__pycache__' -Recurse)) {
        $resolvedCache = [System.IO.Path]::GetFullPath($cacheDir.FullName)
        $stagePrefixForCleanup = $stageRoot.TrimEnd('\') + '\'
        if (-not $resolvedCache.StartsWith(
            $stagePrefixForCleanup, [System.StringComparison]::OrdinalIgnoreCase
        )) {
            throw "Refusing to remove cache outside staging root: $resolvedCache"
        }
        Remove-Item -LiteralPath $resolvedCache -Recurse -Force
    }

    $anonymization = Protect-ArtifactAnonymity $stageRoot

    $stagePrefix = $stageRoot.TrimEnd('\') + '\'
    $manifestLines = Get-ChildItem -LiteralPath $stageRoot -File -Recurse |
        Sort-Object FullName |
        ForEach-Object {
            if (-not $_.FullName.StartsWith($stagePrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
                throw "Manifest path escaped staging root: $($_.FullName)"
            }
            $relative = $_.FullName.Substring($stagePrefix.Length).Replace('\', '/')
            $fileHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName).Hash.ToLowerInvariant()
            '{0}  {1}' -f $fileHash, $relative
        }
    [System.IO.File]::WriteAllLines(
        (Join-Path $stageRoot 'MANIFEST.sha256'),
        $manifestLines,
        [System.Text.UTF8Encoding]::new($false)
    )

    Write-DeterministicZip $stageRoot $zipPath
    Expand-Archive -LiteralPath $zipPath -DestinationPath $verifyRoot
    $manifestPath = Join-Path $verifyRoot 'MANIFEST.sha256'
    if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
        throw 'Artifact archive has no top-level MANIFEST.sha256'
    }
    if (-not (Test-Path -LiteralPath (Join-Path $verifyRoot 'ANONYMIZATION.md') -PathType Leaf)) {
        throw 'Artifact archive has no anonymization record'
    }
    Assert-NoPrivateIdentifiers $verifyRoot $anonymization.PrivateTokens
    foreach ($script in (Get-ChildItem -LiteralPath $verifyRoot -File -Filter '*.ps1' -Recurse)) {
        $parseTokens = $null
        $parseErrors = $null
        [void][System.Management.Automation.Language.Parser]::ParseFile(
            $script.FullName, [ref]$parseTokens, [ref]$parseErrors
        )
        if ($parseErrors.Count -ne 0) {
            throw "Packaged PowerShell syntax error: $($script.FullName): $($parseErrors[0].Message)"
        }
    }
    $verifiedCount = 0
    foreach ($line in [System.IO.File]::ReadAllLines($manifestPath)) {
        if ($line -notmatch '^([0-9a-f]{64})  (.+)$') {
            throw "Malformed manifest line: $line"
        }
        $expectedHash = $Matches[1]
        $relative = $Matches[2]
        $verifiedFile = Join-Path $verifyRoot ($relative.Replace('/', '\'))
        if (-not (Test-Path -LiteralPath $verifiedFile -PathType Leaf)) {
            throw "Manifest file missing from archive: $relative"
        }
        $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $verifiedFile).Hash.ToLowerInvariant()
        if ($actualHash -ne $expectedHash) {
            throw "Manifest hash mismatch: $relative"
        }
        $verifiedCount++
    }
    $packedTex = Join-Path $verifyRoot 'paper\manuscript\main.tex'
    $packedPdf = Join-Path $verifyRoot 'paper\manuscript\main.pdf'
    $packedBib = Join-Path $verifyRoot 'paper\manuscript\references.bib'
    $packedData = Join-Path $verifyRoot 'paper\논문_데이터_표.md'
    $packedDenominatorPolicy = Join-Path $verifyRoot 'paper\분모_정의_통일.md'
    $packedHistory = Join-Path $verifyRoot 'paper\데이터_누적_검증대장.md'
    $packedLineage = Join-Path $verifyRoot 'paper\데이터_계보_아티팩트_정합성.md'
    $packedResourceAudit = Join-Path $verifyRoot 'paper\자원_비용_감사.md'
    $packedDenominatorCatalog = Join-Path $verifyRoot 'paper\분모_표준화_카탈로그.tsv'
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath $packedTex).Hash -ne
        (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $manuscriptRoot 'main.tex')).Hash) {
        throw 'Artifact manuscript source is not the current English main.tex'
    }
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath $packedPdf).Hash -ne
        (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $manuscriptRoot 'main.pdf')).Hash) {
        throw 'Artifact manuscript PDF is not the current English main.pdf'
    }
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath $packedBib).Hash -ne
        (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $manuscriptRoot 'references.bib')).Hash) {
        throw 'Artifact manuscript bibliography is not the current English references.bib'
    }
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath $packedData).Hash -ne
        (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $topicRoot '논문_데이터_표.md')).Hash) {
        throw 'Artifact numerical source of truth is not current'
    }
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath $packedDenominatorPolicy).Hash -ne
        (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $topicRoot '분모_정의_통일.md')).Hash) {
        throw 'Artifact denominator policy is not current'
    }
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath $packedHistory).Hash -ne
        (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $paperRoot '데이터_누적_검증대장.md')).Hash) {
        throw 'Artifact cumulative data ledger is not current'
    }
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath $packedLineage).Hash -ne
        (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $paperRoot '데이터_계보_아티팩트_정합성.md')).Hash) {
        throw 'Artifact data-lineage ledger is not current'
    }
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath $packedResourceAudit).Hash -ne
        (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $paperRoot '자원_비용_감사.md')).Hash) {
        throw 'Artifact resource-cost audit is not current'
    }
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath $packedDenominatorCatalog).Hash -ne
        (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $paperRoot '분모_표준화_카탈로그.tsv')).Hash) {
        throw 'Artifact denominator catalog is not current'
    }
    $hash = Get-FileHash -Algorithm SHA256 -LiteralPath $zipPath
    "Artifact package: {0}; bytes={1}; files={2}; redacted_text={3}; stripped_binary={4}; sha256={5}" -f `
        $zipPath, (Get-Item -LiteralPath $zipPath).Length, $verifiedCount, `
        $anonymization.TextFiles, $anonymization.BinaryFiles, $hash.Hash
}
finally {
    foreach ($cleanup in @($stageRoot, $verifyRoot)) {
        $resolvedCleanup = [System.IO.Path]::GetFullPath($cleanup)
        $safePrefix = $tempRoot + '\a-paper-artifact-'
        if (-not $resolvedCleanup.StartsWith($safePrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Refusing to remove unexpected artifact staging path: $resolvedCleanup"
        }
        Remove-Item -LiteralPath $resolvedCleanup -Recurse -Force
    }
}
