# BashのREADME

帰り道は → [README.md](../../README.md)

## [Similer_Before.sh](Similer_Before.sh)
Linux系統全てにおける共通コマンドを**事前**に実行するBashファイル。

## [Similer_After.sh](Similer_After.sh)
Linux系統全てにおける共通コマンドを**事後**に実行するBashファイル。

## [common.sh](common.sh)
Bashのセットアップに共通で使う関数をまとめたBashファイル。

## [command.sh](command.sh)
`~/Setup/Command`にある`.txt`を読み込み実行するBashファイル。

[.priority_command](../Command/.priority_command.txt)など`.priority`とあるファイルは優先するファイルを設定できるテキストファイルです。
`install_one.txt`、`install_three.txt`と入力した場合、one -> three -> twoと順番に読み込みます。

テキストファイルの一例です。
```
// コメント行
cargo install --locked cargo-binstall
```
以下は特殊文字の扱いについてです。
- `#` : コメント行
- `//` : コメント行

## [dotfile.sh](dotfile.sh)
`Config`にあるファイルおよびディレクトリをコピーもしくはシンボリックリンクを作成するファイル。

実行順番は以下の通りになります。
- `Config`内のファイル
- `Config`内のディレクトリ
- `.ディストリビューション名`のファイルとディレクトリ

## [package.sh](package.sh)
`Package`にある`bash-パッケージ名.txt`を読み込み実行するBashファイル。

パッケージマネージャーによるインストールは以下の通りに実行されます。
- winget : `winget install --source winget --exact --id <package>`
- apt : `sudo apt install --yes <package>`
- brew : `brew install <package>`
- pacman : `pacman -S <package>`

## [procedure_package.sh](procedure_package.sh)
パッケージマネージャーを介さないインストールをまとめるBashファイル。

## [python.sh](python.sh)
miseとuvをインストールして`~/Setup/Python`でuvによるプロジェクトの初期化をし、そしてmain.pyを実行するBashファイル。
