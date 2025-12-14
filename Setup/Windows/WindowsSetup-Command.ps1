Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Windows Setup Script - Command Run Script" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# ============================================
# 管理者権限チェック
# ============================================
$isAdmin = [bool]([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -match "S-1-5-32-544")
if (-not $isAdmin) {
    Write-Host "このスクリプトは管理者権限で実行する必要があります。" -ForegroundColor Red
    exit 1
}

# ============================================
# コマンドの実行
# ============================================

Write-Host "Command Install Script for ya pkg add" -ForegroundColor Cyan
try { # ya pkg add #
    $Version = ya --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "ya バージョン: $Version" -ForegroundColor Green
        .\Setup\Windows\Command-Run.ps1 -FilePath ".\Setup\Windows\command\yazi_pkg_add.txt"
    } else {
        Write-Host "ya がインストールされていません。" -ForegroundColor Yellow
        Write-Host "winget で ya をインストールしてください: winget install -e --id sxyazi.yazi" -ForegroundColor Yellow
    }
} catch {
    Write-Host "ya が見つかりません。先に yazi をインストールしてください。" -ForegroundColor Yellow
}

Write-Host "Command Install Script for mise use" -ForegroundColor Cyan
try { # mise use #
    $Version = mise --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "mise バージョン: $Version" -ForegroundColor Green
        .\Setup\Windows\Command-Run.ps1 -FilePath ".\Setup\Windows\command\mise_use.txt"
    } else {
        Write-Host "mise がインストールされていません。" -ForegroundColor Yellow
        Write-Host "winget で mise をインストールしてください: winget install -e --id jdx.mise" -ForegroundColor Yellow
    }
} catch {
    Write-Host "mise が見つかりません。先に mise をインストールしてください。" -ForegroundColor Yellow
}

Write-Host "Command Install Script for cargo install" -ForegroundColor Cyan
try { # cargo install #
    $Version = cargo --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "cargo バージョン: $Version" -ForegroundColor Green
        .\Setup\Windows\Command-Run.ps1 -FilePath -FilePath ".\Setup\Windows\command\widnows_cargo_install.txt"
    } else {
        Write-Host "cargo がインストールされていません。" -ForegroundColor Yellow
        Write-Host "mise で Rust をインストールしてください: mise use -g rust" -ForegroundColor Yellow
    }
} catch {
    Write-Host "cargo が見つかりません。先に Rust をインストールしてください。" -ForegroundColor Yellow
}