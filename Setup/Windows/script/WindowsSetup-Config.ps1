param(
    [Parameter(Mandatory=$true, HelpMessage="コピーする際にForceを使用するかどうか")]
    [switch]$Force
)

# ============================================
# ロギング設定
# ============================================
$logFile = "Log\powershell-install-$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
Start-Transcript -Path $logFile -Force
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Windows Setup Script - Config Copy" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "開始時刻: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host

# ============================================
# 管理者権限チェック
# ============================================
$isAdmin = [bool]([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -match "S-1-5-32-544")
if (-not $isAdmin) {
    Write-Host "このスクリプトは管理者権限で実行する必要があります。" -ForegroundColor Red
    Stop-Transcript
    exit 1
}
if ($Force){
    Write-Host "このスクリプトはForce Modeで実行されます..."
}

# ============================================
# CSVファイルを読み込む
# ============================================
$configDir = "Config"
$csvPath = Join-Path $configDir ".Windows\ConfigPotision.csv"
try {
    $Configs = Import-Csv -Path $csvPath -Encoding UTF8
} catch {
    Write-Host "✗ $csvPath CSVファイルの読み込みに失敗しました: $_" -ForegroundColor Red
    exit 1
}

# ============================================
# 処理の実行
# ============================================
$successCount = 0
$failureCount = 0

# ============================================
# 設定ファイルとシンボリックリンクを設置する
# ============================================
foreach ($config in $Configs) {
    $sourcePath = ""
    $destinationPath = ""

    # $configDirを設定する #
    if ($config.CONFIG_PATH -eq "Config") {
        $sourcePath = Join-Path $configDir ".config" $config.PATH
    } else {
        $sourcePath = Join-Path $configDir ".Windows" $config.PATH
    }
    # destinationPathを設定する #
    switch ($config.TARGET_APPDATA) {
        "Config" {
            $destinationPath = Join-Path $env:USERPROFILE ".config"
        }
        "Roaming" {
            $destinationPath = $env:APPDATA
        }
        "Local" {
            $destinationPath = $env:LOCALAPPDATA
        }
        default {
            if ($config.TARGET_APPDATA.Contains("Roaming")){
                $destinationPath = Join-Path $env:USERPROFILE "AppData" $config.TARGET_APPDATA
            } elseif ($config.TARGET_APPDATA.Contains("Local")){
                $destinationPath = Join-Path $env:USERPROFILE "AppData" $config.TARGET_APPDATA
            } else {
                $destinationPath = Join-Path $env:USERPROFILE $config.TARGET_APPDATA
            }
        }
    }
    if (-not (Get-Item $sourcePath).PSIsContainer){
        if (-not (Test-Path $destinationPath)){
            New-Item $destinationPath -ItemType Directory | Out-Null
        }
        $destinationPath = Join-Path $destinationPath $config.PATH
    }

    if (-not (Test-Path $sourcePath)) {
        Write-Host "✗ 設定ファイルが見つかりません: $sourcePath" -ForegroundColor Red
        $failureCount++
        continue
    }

    try{
        # ファイルを指定されているディレクトリにコピーする
        if ($Force) {
            Copy-Item -Recurse $sourcePath $destinationPath -Force
        } else {
            Copy-Item -Recurse $sourcePath $destinationPath
        }
        Write-Host "✓ 設定ファイルを配置:" $sourcePath "->" $destinationPath -ForegroundColor Green
        # $destinationPathがLocal、Roamingであればシンボリックリンクを作成する
        if ($config.TARGET_APPDATA.Contains("Local") -or $config.TARGET_APPDATA.Contains("Roaming")) {
            $PackageName = $config.PATH
            New-Item -ItemType SymbolicLink -Path $env:USERPROFILE\.config\$PackageName -Target $destinationPath\$PackageName -Force | Out-Null
            Write-Host "✓ シンボリックリンクを作成:" $destinationPath "->" $env:USERPROFILE\.config\$PackageName -ForegroundColor Green
        }
        $successCount++
    } catch {
        Write-Host "✗ $destinationPath - エラーが発生しました:" $_ -ForegroundColor Red
        $failureCount++
    }
}

# ============================================
# 設定ファイルのセットアップ完了報告
# ============================================
Write-Host "=========================" -ForegroundColor Cyan
Write-Host "設定ファイルのセットアップ完了" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan
Write-Host "成功: $successCount 個" -ForegroundColor Green
Write-Host "失敗: $failureCount 個" -ForegroundColor Red
Write-Host "終了時刻: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host "ログファイル: $logFile" -ForegroundColor Gray
Stop-Transcript
Write-Host