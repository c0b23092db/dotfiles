$WarningPreference = "SilentlyContinue" # Warningの非表示
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadLineOption -WordDelimiters ";:,.[]{}()/\|^&*-=+'<>「」（）『』『』［］、，。"

function y {
    $tmp = (New-TemporaryFile).FullName
        yazi.exe @args --cwd-file="$tmp"
        $cwd = Get-Content -Path $tmp -Encoding UTF8
        if ($cwd -and $cwd -ne $PWD.Path -and (Test-Path -LiteralPath $cwd -PathType Container)) {
            Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
        }
    Remove-Item -Path $tmp
}
function .- {z -}
function .. {z ..}
function ... {z ../..}
function .... {z ../../..}
function Now-Location { Get-Location | Select-Object -ExpandProperty Path | Set-Clipboard }
function za { zoxide add . }
Set-Alias v nvim
Set-Alias m micro
Set-Alias e edit
Set-Alias br broot
Set-Alias touch New-Item
Set-Alias open Start-Process

# mise activate pwsh #
$env:MISE_SHELL = 'pwsh'
if (-not (Test-Path -Path Env:/__MISE_ORIG_PATH)) {
    $env:__MISE_ORIG_PATH = $env:PATH
}

function mise {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments=$true)]  # Allow any number of arguments, including none
        [string[]] $arguments
    )

    $previous_out_encoding = $OutputEncoding
    $previous_console_out_encoding = [Console]::OutputEncoding
    $OutputEncoding = [Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8

    function _reset_output_encoding {
        $OutputEncoding = $previous_out_encoding
        [Console]::OutputEncoding = $previous_console_out_encoding
    }

    if ($arguments.count -eq 0) {
        & "C:\Users\Admin\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe"
        _reset_output_encoding
        return
    } elseif ($arguments -contains '-h' -or $arguments -contains '--help') {
        & "C:\Users\Admin\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe" @arguments
        _reset_output_encoding
        return
    }

    $command = $arguments[0]
    if ($arguments.Length -gt 1) {
        $remainingArgs = $arguments[1..($arguments.Length - 1)]
    } else {
        $remainingArgs = @()
    }

    switch ($command) {
        { $_ -in 'deactivate', 'shell', 'sh' } {
            & "C:\Users\Admin\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe" $command @remainingArgs | Out-String | Invoke-Expression -ErrorAction SilentlyContinue
            _reset_output_encoding
        }
        default {
            & "C:\Users\Admin\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe" $command @remainingArgs
            $status = $LASTEXITCODE
            if ($(Test-Path -Path Function:\_mise_hook)){
                _mise_hook
            }
            _reset_output_encoding
            # restore exit code from mise after _mise_hook
            $global:LASTEXITCODE = $status
        }
    }
}

function Global:_mise_hook {
    if ($env:MISE_SHELL -eq "pwsh"){
        $output = & "C:\Users\Admin\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe" hook-env $args -s pwsh | Out-String
        if ($output -and $output.Trim()) {
            $output | Invoke-Expression
        }
    }
}

function __enable_mise_chpwd{
    if ($PSVersionTable.PSVersion.Major -lt 7) {
        if ($env:MISE_PWSH_CHPWD_WARNING -ne '0') {
            Write-Warning "mise: chpwd functionality requires PowerShell version 7 or higher. Your current version is $($PSVersionTable.PSVersion). You can add `$env:MISE_PWSH_CHPWD_WARNING=0` to your environment to disable this warning."
        }
        return
    }
    if (-not $__mise_pwsh_chpwd){
        $Global:__mise_pwsh_chpwd= $true
        $_mise_chpwd_hook = [EventHandler[System.Management.Automation.LocationChangedEventArgs]] {
            param([object] $source, [System.Management.Automation.LocationChangedEventArgs] $eventArgs)
            end {
                _mise_hook
            }
        };
        $__mise_pwsh_previous_chpwd_function=$ExecutionContext.SessionState.InvokeCommand.LocationChangedAction;

        if ($__mise_original_pwsh_chpwd_function) {
            $ExecutionContext.SessionState.InvokeCommand.LocationChangedAction = [Delegate]::Combine($__mise_pwsh_previous_chpwd_function, $_mise_chpwd_hook)
        }
        else {
            $ExecutionContext.SessionState.InvokeCommand.LocationChangedAction = $_mise_chpwd_hook
        }
    }
}
__enable_mise_chpwd
Remove-Item -ErrorAction SilentlyContinue -Path Function:/__enable_mise_chpwd

function __enable_mise_prompt {
    if (-not $__mise_pwsh_previous_prompt_function){
        $Global:__mise_pwsh_previous_prompt_function=$function:prompt
        function global:prompt {
            if (Test-Path -Path Function:\_mise_hook){
                _mise_hook
            }
            & $__mise_pwsh_previous_prompt_function
        }
    }
}
__enable_mise_prompt
Remove-Item -ErrorAction SilentlyContinue -Path Function:/__enable_mise_prompt

_mise_hook
if (-not $__mise_pwsh_command_not_found){
    $Global:__mise_pwsh_command_not_found= $true
    function __enable_mise_command_not_found {
        $_mise_pwsh_cmd_not_found_hook = [EventHandler[System.Management.Automation.CommandLookupEventArgs]] {
            param([object] $Name, [System.Management.Automation.CommandLookupEventArgs] $eventArgs)
            end {
                if ([Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems()[-1].CommandLine -match ([regex]::Escape($Name))) {
                    if (& "C:\Users\Admin\AppData\Local\Microsoft\WinGet\Packages\jdx.mise_Microsoft.Winget.Source_8wekyb3d8bbwe\mise\bin\mise.exe" hook-not-found -s pwsh -- $Name){
                        _mise_hook
                        if (Get-Command $Name -ErrorAction SilentlyContinue){
                            $EventArgs.Command = Get-Command $Name
                            $EventArgs.StopSearch = $true
                        }
                    }
                }
            }
        }
        $current_command_not_found_function = $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction
        if ($current_command_not_found_function) {
            $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = [Delegate]::Combine($current_command_not_found_function, $_mise_pwsh_cmd_not_found_hook)
        }
        else {
            $ExecutionContext.SessionState.InvokeCommand.CommandNotFoundAction = $_mise_pwsh_cmd_not_found_hook
        }
    }
    __enable_mise_command_not_found
    Remove-Item -ErrorAction SilentlyContinue -Path Function:/__enable_mise_command_not_found
}
# Finish mise #

function prompt {
    $currentDir = (Get-Location).Path `
        -replace [regex]::Escape($HOME), "~"
    $(if (Test-Path variable:/PSDebugContext) { '[DBG]: ' }
      else {  }) + $currentDir +
        $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> '
}
Invoke-Expression (& { (zoxide init powershell | Out-String) })