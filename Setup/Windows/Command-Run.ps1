param(
    [Parameter(Mandatory=$true, HelpMessage="実行するコマンドが記載されたテキストファイルのパス")]
    [string]$FilePath
)
$fileName = Split-Path $FilePath -Leaf

# ============================================
# ロギング設定
# ============================================
$logFile = "Log\command-install-$fileName-$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
Start-Transcript -Path $logFile -Force
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "Windows Setup Script - Command Installation" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "開始時刻: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host

# ============================================
# ファイルのロード
# ============================================
$commandList = .\Setup\Windows\File-Load.ps1 -FilePath $FilePath
if($commandList -eq $null){
    exit 1
}

# ============================================
# 処理の実行
# ============================================
$successCount = 0
$failureCount = 0
$totalCommands = $commandList.Count
Write-Host "実行するコマンド数:" $totalCommands -ForegroundColor Cyan
Write-Host

# コマンド実行 #
$currentIndex = 0
foreach ($command in $commandList) {
    $currentIndex++
    Write-Host "[$currentIndex/$totalCommands] 実行中: $command" -ForegroundColor Yellow

    try {
        # PowerShellでコマンド実行
        $output = Invoke-Expression $command 2>&1

        # 実行結果の判定
        if ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq $null) {
            Write-Host "✓ 成功:" $command -ForegroundColor Green
            $successCount++
        } else {
            Write-Host "✗ 失敗:" $command "(エラーコード: $LASTEXITCODE)" -ForegroundColor Red
            Write-Host "  出力:" $output -ForegroundColor DarkRed
            $failureCount++
        }
    } catch {
        Write-Host "✗ エラー:" $command -ForegroundColor Red
        Write-Host "  詳細:" $_ -ForegroundColor DarkRed
        $failureCount++
    }

    Write-Host ""
}

# ============================================
# 実行完了報告
# ============================================
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "実行完了" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "合計コマンド数: $totalCommands 個" -ForegroundColor Cyan
Write-Host "成功: $successCount 個" -ForegroundColor Green
Write-Host "失敗: $failureCount 個" -ForegroundColor Red
Write-Host "終了時刻: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host
Write-Host "ログファイル: $logFile" -ForegroundColor Gray
Stop-Transcript
Write-Host

# スクリプト終了コード
if ($failureCount -gt 0) {
    exit 1
} else {
    exit 0
}