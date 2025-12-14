# Windowsをインストールしたときに行うこと

## Powershellで実行するコマンド
必ず**ダウンロードフォルダーにドットファイルフォルダーを設置する**こと！

cd $Env:USERPROFILE\Downloads\dotfiles
Set-ExecutionPolicy RemoteSigned
[Console]::InputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')
[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding('utf-8')
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
.\Windows_Installer.ps1
