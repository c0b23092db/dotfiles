param (
    [switch]$Run,
    [switch]$Look,
    [switch]$Search
)

# ============================================
# ヘルプ表示
# ============================================
if ($PSBoundParameters.Count -eq 0) {
    Write-Host "使用方法:" -ForegroundColor Cyan
    Write-Host "  .\WinGet-all.ps1 [オプション]"
    Write-Host
    Write-Host "オプション:"
    Write-Host "  -Run      アプリケーションをインストール"
    Write-Host "  -Search   アプリケーションを検索"
    Write-Host "  -Look     アプリケーションをインストールせずに実行するコマンドを表示"
    exit 0
}

# ============================================
# オプションの確認
# ============================================
if ($Look) {
    Write-Host "実行されるコマンド"
    Write-Host "  Install : winget install --exact --id <app> --source winget --accept-package-agreements --accept-source-agreements"
    Write-Host "  Search  : winget search --exact --id <app>"
    exit 0
}
if ($Search -and $Run) {
    Write-Host "-Searchと-Runは同時に指定できません。"
    exit 1
}
if (-not $Search -and -not $Run) {
    Write-Host "-Searchまたは-Runを指定してください。"
    exit 1
}

# ============================================
# ロギング設定
# ============================================
$logFile = "Log\WinGet-Install-$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
Start-Transcript -Path $logFile -Force
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Windows Setup Script - WinGet Installation (Normal)" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "開始時刻: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host

# ============================================
# 管理者権限チェック
# ============================================
$isAdmin = [bool]([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -match "S-1-5-32-544")
if ($Run -and -not $isAdmin) {
    Write-Host "このスクリプトは管理者権限で実行する必要があります。" -ForegroundColor Red
    Stop-Transcript
    exit 1
}

# ============================================
# WinGet の確認
# ============================================
Write-Host "WinGet を確認中..." -ForegroundColor Yellow
try {
    $wingetVersion = winget --version
    Write-Host "WinGet バージョン:" $wingetVersion -ForegroundColor Green
} catch {
    Write-Host "WinGet がインストールされていません。" -ForegroundColor Red
    Write-Host "Microsoft Store から WinGet をインストールしてください。" -ForegroundColor Red
    Stop-Transcript
    exit 1
}
if ($wingetVersion -eq "v1.2.10691"){
    Write-Host "WinGetのバージョンがv1.2.10691です。" -ForegroundColor Red
    Write-Host "Microsoft Store から WinGet をアップデートしてください。" -ForegroundColor Red
    Stop-Transcript
    exit 1
}
Write-Host

# ============================================
# インストール対象アプリケーション定義
# ============================================
$applications_id = .\Setup\Windows\script\File-Load.ps1 -FilePath ".\Package\WinGet-All.md"
if($applications_id -eq $null){
    exit 1
}
$totalApps = $applications_id.Count
$successCount = 0
$failureCount = 0
$skipCount = 0
if ($Search) {
    $winget_text = "検索"
} else {
    $winget_text = "インストール"
}
Write-Host "合計 $totalApps 個のアプリケーションを $winget_text 開始します" -ForegroundColor Cyan
Write-Host

# ============================================
# インストール/検索実行
# ============================================
foreach ($app in $applications_id) {
    $currentIndex = [array]::IndexOf($applications_id, $app) + 1
    Write-Host "[$currentIndex/$totalApps] $app を $winget_text 中..." -ForegroundColor Yellow
    try {
        if ($Run) {
            $output = winget install --exact --id $app --source winget --accept-package-agreements --accept-source-agreements 2>&1
        } elseif ($Search) {
            $output = winget search --exact --id $app
        }
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ $app - $winget_text 成功" -ForegroundColor Green
            $successCount++
        } elseif ($LASTEXITCODE -eq -1978335189 -or $output -match "already installed") {
            Write-Host "⊝ $app - 既に $winget_text 済み" -ForegroundColor Cyan
            $skipCount++
        } else {
            Write-Host "✗ $app - $winget_text 失敗 (エラーコード: $LASTEXITCODE)" -ForegroundColor Red
            $failureCount++
        }
    } catch {
        Write-Host "✗ $app - エラーが発生しました:" $_ -ForegroundColor Red
        $failureCount++
    }
    Write-Host
}

# ============================================
# インストール完了報告
# ============================================
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "インストール完了 (Normal)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "終了時刻: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host "成功: $successCount 個" -ForegroundColor Green
Write-Host "スキップ: $skipCount 個" -ForegroundColor Cyan
Write-Host "失敗: $failureCount 個" -ForegroundColor Red
Stop-Transcript

# スクリプト終了コード
if ($failureCount -gt 0) {
    exit 1
} else {
    exit 0
}
