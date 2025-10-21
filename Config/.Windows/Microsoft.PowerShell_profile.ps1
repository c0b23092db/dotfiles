Import-Module Terminal-Icons
$WarningPreference = "SilentlyContinue" # Warningの非表示

Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadLineOption -WordDelimiters ";:,.[]{}()/\|^&*-=+'<>「」（）『』『』［］、，。"

function y {
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}
function cl { cl.exe /source-charset:utf-8 @args}
function dcp { docker cp . $args[0]:/root/$args[1] }
function za { zoxide add . }
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-Alias pkg-config pkgconf
Set-Alias v nvim
Set-Alias m micro
Set-Alias e edit
Set-Alias br broot
Set-Alias open Start-Process

function prompt {
    $currentDir = (Get-Location).Path `
        -replace [regex]::Escape($HOME), "~" `
        -replace ".*Learn_University", "🏫 "
    $(if (Test-Path variable:/PSDebugContext) { '[DBG]: ' }
      else {  }) + $currentDir +
        $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> '
}