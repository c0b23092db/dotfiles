# PythonのREADME

帰り道は → [README.md](../../README.md)

## [main.py](main.py)
引数を受け取り、セットアップを開始するファイルです。

- `-h`,`--help`    : show this help message and exit
- `--debug`        : デバッグ情報を表示
- `--run`          : セットアップを実行
- `-d`,`--dry-run` : 予行演習を実行
- `-p`,`--package` : 使用するパッケージを選択 [`winget`,`brew`,`apt`,`pacman`,`dnf`,`nix`]

以下は`main.py`には設定されているものの、効力を発揮しないオプションです。
- `-s`,`--shell`   : Shellを選択する [`Powershell 7`,`Bash`,`zsh`,`fish`]
- `-o`,`--os`      : OSを選択する

## [lib](lib)

### [common.py](lib/common.py)
全体を通して使用する関数をまとめたファイルです。

### [command.py](lib/command.py)
`~/Setup/Command`にある`.txt`や`.sh`を読み込みコマンドを実行するファイルです。

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

### [config.py](lib/config.py)
`~/Config`にあるドットファイルをコピーするファイルです。

Windowsの場合、[configpotision.csv](../../Config/.Windows/configpotision.csv)に記載を行う必要があります。
`PATH`,`CONFIG_PATH`,`TARGET_APPDATA`として分類されています。
- PATH
  ディレクトリの名前
- CONFIG_PATH
  コピー元のディレクトリの位置
- TARGET_APPDATA
  コピー先のディレクトリの位置
  - .config
    `%USERPROFILE%/.config`に移動する
  - Roaming
    `%APPDATA%`に移動する
  - Local
    `LOCALAPPDATA`に移動する

### [package.py](lib/package.py)
`~/Package`にある`id.csv`、`apt.txt`、`winget.txt`を読み込みパッケージをインストールするファイルです。

パッケージマネージャーによるインストールは以下の通りに実行されます。
- winget : `winget install --source winget --exact --id <package>`
- apt : `sudo apt install --yes <package>`
- brew : `brew install <package>`
- pacman : `pacman -S <package>`

Dry Runモードは以下の通りに実行されます。
- winget : `winget search --exact --id <package>`
- apt : `sudo apt -y search <package>`
- brew : `brew search <package>`
- pacman : `pacman -Ss <package>`

#### [id.csv](../../Package/id.csv)
- NAME
  パッケージの名前
- INSTALL
  インストールするパッケージのオプション
  - all : すべてのパッケージでインストールする
  - x : インストールしない
  - package name : 指定したパッケージのみ
    - winget
    - apt
- packaga name
  パッケージのID

#### テキストファイル
テキストファイルはこのように分類されています。カンマが無ければ`ID`として読み込み、カンマがあれば`NAME,ID`として読み込みます。
```
// コメント行
Microsoft.PowerShell
UniGetUI,MartiCliment.UniGetUI
```
- NAME
  パッケージの名前
- ID
  パッケージのID

以下は特殊文字の扱いについてです。
- `#` : コメント行
- `//` : コメント行

### [state.py](lib/state.py)
製作途中です。
