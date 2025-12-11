param(
    [Parameter(Mandatory=$true, HelpMessage="実行するコマンドが記載されたテキストファイルのパス")]
    [string]$FilePath
)

# ============================================
# ファイル存在確認
# ============================================
if (-not (Test-Path $FilePath)) {
    Write-Host "エラー: 指定されたファイルが見つかりません。" -ForegroundColor Red
    Write-Host "ファイルパス: $FilePath" -ForegroundColor Red
    exit 1
}

$TextList = @()
Write-Host "コマンドファイルを読み込み中 - $FilePath" -ForegroundColor Yellow
$lines = Get-Content -Path $FilePath -Encoding UTF8
foreach ($line in $lines) {
    $trimmedLine = $line.Trim()

    if ([string]::IsNullOrWhiteSpace($trimmedLine)) {
        continue
    }
    if ($trimmedLine -match "^//.*" -or $trimmedLine -match "^#.*") {
        continue
    }

    $TextList += $trimmedLine
}

return $TextList

# $TextList = .\Setup\Windows\script\File-Load.ps1 -FilePath "file.txt"
# foreach ($text in $TextList) {
#     Write-Host $text
# }