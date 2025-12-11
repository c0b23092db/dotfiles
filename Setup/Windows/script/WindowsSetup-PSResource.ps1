# ============================================
# ロギング設定
# ============================================
$logFile = "Log\powershell-install-$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
Start-Transcript -Path $logFile -Force
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "Windows Setup Script - PowerShell Module Installation" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "開始時刻: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host

# ============================================
# インストール対象アプリケーション定義
# ============================================
$applications_id = @(
    "Terminal-Icons"
)
$successCount = 0
$failureCount = 0
$totalApps = $applications_id.Count
Write-Host "合計 $totalApps 個のPowerShellモジュールをインストール開始します" -ForegroundColor Cyan
Write-Host

# ============================================
# インストール実行
# ============================================

foreach ($app in $applications_id) {
    $currentIndex = [array]::IndexOf($applications_id, $app) + 1
    Write-Host "[$currentIndex/$totalApps] $app をインストール中..." -ForegroundColor Yellow
    try {
        Install-PSResource -Name $app -Confirm:$false -TrustRepository 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ $app - インストール成功" -ForegroundColor Green
            $successCount++
        } else {
            Write-Host "✗ $app - インストール失敗 (エラーコード: $LASTEXITCODE)" -ForegroundColor Red
            $failureCount++
        }
    } catch {
        Write-Host "✗ $app - エラーが発生しました: $_" -ForegroundColor Red
        $failureCount++
    }
    Write-Host
}

# ============================================
# インストール完了報告
# ============================================
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "インストール完了 (PowerShell)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "終了時刻: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host "成功: $successCount 個" -ForegroundColor Green
Write-Host "失敗: $failureCount 個" -ForegroundColor Red
Write-Host "ログファイル: $logFile" -ForegroundColor Gray
Stop-Transcript
Write-Host

# スクリプト終了コード
if ($failureCount -gt 0) {
    exit 1
} else {
    exit 0
}