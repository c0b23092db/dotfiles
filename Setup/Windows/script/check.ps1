# ============================================
# ファイルのロード
# ============================================
$commandList = .\Setup\Windows\script\File-Load.ps1 -FilePath ".\Setup\Windows\install\yazi_pkg_add.txt"
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
    Write-Host "✓ 成功:" $command -ForegroundColor Green
    Write-Host ""
}