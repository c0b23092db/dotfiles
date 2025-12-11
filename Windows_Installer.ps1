.\Setup\Windows\script\WindowsSetup-Config.ps1 -Force
# .\Setup\Windows\script\check.ps1
exit 0

Clear-Host
Write-Host "================================"
Write-Host
Write-Host "Dotfiles of Windows Setup Script" -ForegroundColor Cyan
Write-Host "Created with Ikata Version 1.0.0"
Write-Host
Write-Host "================================"
Write-Host
if ($args[0] -ne "/DisablePausePrompts") { pause }

# ============================================
# 管理者権限チェック
# ============================================
$isAdmin = [bool]([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -match "S-1-5-32-544")
if (-not $isAdmin) {
    Write-Host "このスクリプトは管理者権限で実行する必要があります。" -ForegroundColor Red
    exit 1
}

# ============================================
# 事前処理
# ============================================
$main_startTime = $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
Set-Item Env:PATH $ENV:Path";$env:LOCALAPPDATA\mise\shims"
Set-Item Env:PATH $ENV:Path";$env:USERPROFILE\.cargo\bin"

# ============================================
# 処理の実行
# ============================================
.\Setup\Windows\script\WindowsSetup-WinGet.ps1 -Run
.\Setup\Windows\script\WindowsSetup-PSResource.ps1
.\Setup\Windows\script\WindowsSetup-Command.ps1
.\Setup\Windows\script\WindowsSetup-msvc.ps1

# ============================================
# 事後処理
# ============================================
Write-Host "環境変数の設定" -ForegroundColor Cyan
.\Setup\Windows\script\WindowsSetup-msvc.ps1
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','User')+";C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Tools\MSVC\14.50.35717\bin\Hostx64\x64",'User')
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','User')+";$env:USERPROFILE\.cargo\bin",'User')
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','User')+";$env:LOCALAPPDATA\mise\shims",'User')
[Environment]::SetEnvironmentVariable('PATH',[Environment]::GetEnvironmentVariable('PATH','User')+";$env:USERPROFILE\Documents\Software\mpv",'User')
[Environment]::SetEnvironmentVariable('YAZI_FILE_ONE',"C:\Program Files\Git\usr\bin\file.exe",'User')

# ============================================
# 処理の完了報告
# ============================================
Write-Host "開始時刻: $main_startTime" -ForegroundColor Gray
Write-Host "終了時刻: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host "すべての処理完了" -ForegroundColor Green
Write-Host

# スクリプト終了コード
if ($args[0] -ne "/DisablePausePrompts") { pause }
exit 0
