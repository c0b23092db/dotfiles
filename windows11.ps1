param(
    [switch]$DryRun,[switch]$Run,[switch]$Debug,[switch]$Help
)
Write-Host "=== Windows Dotfiles セットアップ ===" -ForegroundColor Blue
if (-not (Get-Command "mise" -ErrorAction SilentlyContinue)) {
    Write-Host "miseをインストールします..." -ForegroundColor Green
    winget install --source winget --exact --id jdx.mise
}
if (-not (Get-Command "uv" -ErrorAction SilentlyContinue)) {
    Write-Host "uvをインストールします..." -ForegroundColor Green
    mise use -g uv
}
if (-not (Test-Path "./Setup/Python")) {
    Write-Host "Pythonディレクトリが見つかりません" -ForegroundColor Red
    exit 1
}
if (-not (Test-Path "./Setup/Python/pyproject.toml")) {
    Write-Host "Python プロジェクトを初期化しています..." -ForegroundColor Green
    uv init ./Setup/Python --python 3.13 --no-readme
    Write-Host "requirements.txtからインストールしています..." -ForegroundColor Green
    uv add --directory ./Setup/Python -r requirements.txt
}
Write-Host "`===Pythonインストーラーを起動しています===" -ForegroundColor Blue
$pythonArgs = @()
if ($DryRun) { $pythonArgs += "--dry-run" }
if ($Run) { $pythonArgs += "--run" }
if ($Debug) { $pythonArgs += "--debug" }
if ($Help) { $pythonArgs += "--help" }

uv run --directory ./Setup/Python main.py $pythonArgs

Write-Host "=== Windows Dotfiles セットアップ完了 ===" -ForegroundColor Blue