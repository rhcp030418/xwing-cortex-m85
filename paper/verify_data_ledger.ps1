# Fail when a measured-data source appears without a corresponding ledger entry.
$ErrorActionPreference = 'Stop'

$paperRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$topicRoot = Split-Path $paperRoot -Parent
$harnessRoot = Join-Path $topicRoot 'measure-harness'
$historyPath = Join-Path $paperRoot '데이터_누적_검증대장.md'
$dataPath = Join-Path $topicRoot '논문_데이터_표.md'
$variationPath = Join-Path $topicRoot 'XWing_CortexM85_통합_variation.md'
$catalogPath = Join-Path $paperRoot '전체_데이터_카탈로그.tsv'
$experimentCatalogPath = Join-Path $paperRoot '실험_계보_카탈로그.tsv'
$denominatorPath = Join-Path $paperRoot '분모_표준화_카탈로그.tsv'
$exclusionsPath = Join-Path $paperRoot '데이터_패키지_제외목록.tsv'
$history = [System.IO.File]::ReadAllText($historyPath)
$variation = [System.IO.File]::ReadAllText($variationPath)

function Get-ExperimentIds([string]$name) {
    $ids = [System.Collections.Generic.List[string]]::new()
    $match = [regex]::Match($name, '_exp([A-Z]{1,2}[0-9]*)')
    if (-not $match.Success) {
        return $ids
    }
    $primaryId = $match.Groups[1].Value
    $ids.Add($primaryId)
    $tail = $name.Substring($match.Index + $match.Length)
    while ($true) {
        $next = [regex]::Match($tail, '^_([A-Z]{1,2}[0-9]*)(?=_|\.|-)')
        if (-not $next.Success) {
            break
        }
        $tailId = $next.Groups[1].Value
        if (-not ($primaryId -eq 'DE' -and $tailId -in @('A', 'B'))) {
            $ids.Add($tailId)
        }
        $tail = $tail.Substring($next.Length)
    }
    return $ids
}

function Assert-Equal([string]$label, [int]$actual, [int]$expected) {
    if ($actual -ne $expected) {
        throw "$label mismatch: actual=$actual expected=$expected. Update the ledger and this gate together."
    }
}

function Assert-IdsCovered([string]$label, [object[]]$items) {
    $ids = @($items | ForEach-Object { Get-ExperimentIds $_.Name } | Sort-Object -Unique)
    $missing = @($ids | Where-Object {
        $id = $_
        -not [regex]::IsMatch(
            $history,
            '(?<![A-Z0-9])' + [regex]::Escape($id) + '(?![A-Z0-9])'
        )
    })
    if ($missing.Count -ne 0) {
        throw "$label experiment IDs absent from cumulative ledger: $($missing -join ', ')"
    }
    return $ids.Count
}

function Get-FileNameExperimentIds([string]$name) {
    $ids = [System.Collections.Generic.List[string]]::new()
    $matches = [regex]::Matches(
        $name,
        '(?<![A-Za-z])exp([A-Z]{1,3}(?:[0-9]+[A-Za-z]?)?)(?![A-Za-z])',
        [System.Text.RegularExpressions.RegexOptions]::CultureInvariant
    )
    foreach ($match in $matches) {
        $ids.Add($match.Groups[1].Value.ToUpperInvariant())
    }
    return $ids
}

$resultDocs = @(Get-ChildItem -LiteralPath $harnessRoot -File -Filter '*_results.md')
$preregDocs = @(Get-ChildItem -LiteralPath $harnessRoot -File -Filter '*_prereg.md')
$allExperimentDocs = @(
    Get-ChildItem -LiteralPath $harnessRoot -File -Filter '*.md' |
        Where-Object { $_.Name -ne 'README.md' }
)
$otherExperimentDocs = @(
    $allExperimentDocs |
        Where-Object { $_.Name -notlike '*_results.md' -and $_.Name -notlike '*_prereg.md' }
)
$logs = @(Get-ChildItem -LiteralPath (Join-Path $harnessRoot 'logs') -Recurse -File)
$artifactDirs = @(Get-ChildItem -LiteralPath (Join-Path $harnessRoot 'artifacts') -Directory)
$artifactFiles = @(Get-ChildItem -LiteralPath (Join-Path $harnessRoot 'artifacts') -Recurse -File)
$slothyFiles = @(Get-ChildItem -LiteralPath (Join-Path $topicRoot 'slothy-2stream') -Recurse -File)
$allTopicFiles = @(Get-ChildItem -LiteralPath $topicRoot -Recurse -File -Force)

Assert-Equal 'result documents' $resultDocs.Count 72
Assert-Equal 'preregistration documents' $preregDocs.Count 60
Assert-Equal 'other experiment Markdown documents' $otherExperimentDocs.Count 14
Assert-Equal 'all experiment Markdown documents' $allExperimentDocs.Count 146
Assert-Equal 'logs' $logs.Count 195
Assert-Equal 'artifact directories' $artifactDirs.Count 61
Assert-Equal 'artifact files' $artifactFiles.Count 1033
Assert-Equal 'slothy files' $slothyFiles.Count 119

$documentIdCount = Assert-IdsCovered 'Markdown' $allExperimentDocs
$logIdCount = Assert-IdsCovered 'Log' $logs
$artifactIdCount = Assert-IdsCovered 'Artifact' $artifactDirs
Assert-Equal 'Markdown unique experiment IDs' $documentIdCount 97
Assert-Equal 'log unique experiment IDs' $logIdCount 63
Assert-Equal 'artifact unique experiment IDs' $artifactIdCount 60

# The earlier gate inspected only the harness Markdown/log/artifact namespaces.
# Audit every filename as well, so source-only stages such as expBO and naming
# anomalies such as expAU514 cannot hide outside those three namespaces.
$allFileNameIds = @(
    $allTopicFiles |
        ForEach-Object { Get-FileNameExperimentIds $_.Name } |
        Sort-Object -Unique
)
$missingFileNameIds = @($allFileNameIds | Where-Object {
    $id = $_
    -not [regex]::IsMatch(
        $history,
        '(?<![A-Z0-9])' + [regex]::Escape($id) + '(?![A-Z0-9])',
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
    )
})
if ($missingFileNameIds.Count -ne 0) {
    throw "All-tree filename experiment IDs absent from cumulative ledger: $($missingFileNameIds -join ', ')"
}

# Candidate-family IDs are design/data lineage even when no standalone
# experiment file was created.  Require the complete 32+20+12+9 set in both the
# canonical variation source and the cumulative ledger.
$candidateIds = @(
    (1..32 | ForEach-Object { 'K{0:D2}' -f $_ }) +
    (1..20 | ForEach-Object { 'W{0:D2}' -f $_ }) +
    (1..12 | ForEach-Object { 'X{0:D2}' -f $_ }) +
    (1..9 | ForEach-Object { 'T{0:D2}' -f $_ })
)
foreach ($id in $candidateIds) {
    $pattern = '(?<![A-Z0-9])' + [regex]::Escape($id) + '(?![A-Z0-9])'
    if (-not [regex]::IsMatch($variation, $pattern)) {
        throw "Candidate ID absent from canonical variation source: $id"
    }
    if (-not [regex]::IsMatch($history, $pattern)) {
        throw "Candidate ID absent from cumulative ledger: $id"
    }
}

$idlessLogs = @($logs | Where-Object { -not [regex]::IsMatch($_.Name, '_exp[A-Z]') })
$expectedIdlessLogs = @(
    '2026-08-21_b0_assemble.txt',
    '2026-08-26_revert_check.txt'
)
Assert-Equal 'ID-less logs' $idlessLogs.Count $expectedIdlessLogs.Count
foreach ($name in $expectedIdlessLogs) {
    if (-not ($idlessLogs.Name -contains $name)) {
        throw "Expected ID-less log not found: $name"
    }
    if (-not $history.Contains($name)) {
        throw "ID-less log absent from cumulative ledger: $name"
    }
}

$historyTRows = @(
    Select-String -LiteralPath $historyPath -Pattern '^\| T(?:[1-9]|[1-3][0-9]|4[0-9]|28b) \|'
).Count
$dataTHeadings = @(
    Select-String -LiteralPath $dataPath -Pattern '^## T(?:\d+|28b)\b'
).Count
Assert-Equal 'cumulative-ledger T rows' $historyTRows 50
Assert-Equal 'numerical-ledger T headings' $dataTHeadings 50

foreach ($requiredPath in @(
    $catalogPath,
    $experimentCatalogPath,
    $denominatorPath,
    $exclusionsPath,
    (Join-Path $paperRoot '데이터_카탈로그.xlsx'),
    (Join-Path $paperRoot 'all-data-upload.zip'),
    (Join-Path $paperRoot '전체_데이터_패키지_README.md')
)) {
    if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
        throw "Required complete-data output missing: $requiredPath"
    }
}

$catalog = @(Import-Csv -LiteralPath $catalogPath -Delimiter "`t")
$experimentCatalog = @(Import-Csv -LiteralPath $experimentCatalogPath -Delimiter "`t")
$denominators = @(Import-Csv -LiteralPath $denominatorPath -Delimiter "`t")
$exclusions = @(Import-Csv -LiteralPath $exclusionsPath -Delimiter "`t")
Assert-Equal 'file catalog rows' $catalog.Count 6531
Assert-Equal 'all-data included rows' @($catalog | Where-Object all_data_included -eq 'Y').Count 5665
Assert-Equal 'all-data excluded rows' @($catalog | Where-Object all_data_included -eq 'N').Count 866
Assert-Equal 'exclusion catalog rows' $exclusions.Count 866
Assert-Equal 'experiment lineage records' @($experimentCatalog | Where-Object record_type -eq 'experiment').Count 132
Assert-Equal 'candidate lineage records' @($experimentCatalog | Where-Object record_type -eq 'candidate').Count 73
Assert-Equal 'denominator standards' @($denominators | Where-Object row_kind -eq 'standard').Count 21
Assert-Equal 'denominator T mappings' @($denominators | Where-Object row_kind -eq 'data_mapping').Count 50
if (@($denominators | Where-Object row_kind -eq 'standard' | Group-Object standard_denominator_ids | Where-Object Count -ne 1).Count -ne 0) {
    throw 'Denominator standard IDs are blank or duplicated'
}
$mappingItems = @($denominators | Where-Object row_kind -eq 'data_mapping' | ForEach-Object source_item)
if (@($mappingItems | Group-Object | Where-Object Count -ne 1).Count -ne 0) {
    throw 'Denominator data mappings contain duplicate T items'
}
$expectedMappingItems = @((1..49 | ForEach-Object { "T$_" }) + 'T28b')
$missingMappings = @($expectedMappingItems | Where-Object { $mappingItems -notcontains $_ })
$extraMappings = @($mappingItems | Where-Object { $expectedMappingItems -notcontains $_ })
if ($missingMappings.Count -ne 0 -or $extraMappings.Count -ne 0) {
    throw "Denominator T mapping mismatch: missing=$($missingMappings -join ',') extra=$($extraMappings -join ',')"
}
if (@($denominators | Where-Object { [string]::IsNullOrWhiteSpace($_.standard_denominator_ids) -or [string]::IsNullOrWhiteSpace($_.conversion_status) }).Count -ne 0) {
    throw 'Denominator rows have blank ID or conversion status'
}
if (@($catalog | Group-Object path | Where-Object Count -ne 1).Count -ne 0) {
    throw 'File catalog has duplicate paths'
}
if (@($catalog | Where-Object { $_.sha256 -notmatch '^[0-9A-F]{64}$' }).Count -ne 0) {
    throw 'File catalog has blank or malformed SHA-256 values'
}
$deploymentModeLeak = @($catalog | Where-Object {
    $_.path -match 'expDE_(A|B)(?:_|\.|-)' -and $_.experiment_ids -match '(^|;)(A|B)(;|$)'
})
Assert-Equal 'expDE A/B mode is not legacy experiment A/B' $deploymentModeLeak.Count 0
$newExperimentRecords = @($experimentCatalog | Where-Object {
    $_.record_type -eq 'experiment' -and $_.id -in @('DD', 'DE', 'DF', 'DG', 'DH', 'DI', 'DJ')
})
Assert-Equal 'DD--DJ experiment lineage records' $newExperimentRecords.Count 7
if (@($catalog | Where-Object { $_.all_data_included -eq 'Y' -and [string]::IsNullOrWhiteSpace($_.archive_path) }).Count -ne 0) {
    throw 'Included file has no all-data archive path'
}

foreach ($required in @(
    'AE', 'AM0', 'AK1', 'AK2', 'G2', '실험 O', 'Z1', 'Z2', 'BO', 'AU514',
    'CF', 'AT2', 'AT3', 'AL implementation check'
)) {
    if (-not $history.Contains($required)) {
        throw "Required correction marker absent from cumulative ledger: $required"
    }
}

"DATA_LEDGER_AUDIT_PASS docs={0} doc_ids={1} logs={2} log_ids={3} artifact_dirs={4} artifact_ids={5} filename_ids={6} candidates={7} T={8} catalog={9} all_data={10} denominators={11}" -f `
    $allExperimentDocs.Count, $documentIdCount, $logs.Count, $logIdCount, `
    $artifactDirs.Count, $artifactIdCount, $allFileNameIds.Count, $candidateIds.Count, $historyTRows, `
    $catalog.Count, @($catalog | Where-Object all_data_included -eq 'Y').Count, $denominators.Count
