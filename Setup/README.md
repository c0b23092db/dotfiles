# セットアップのREADME

帰り道は → [README.md](../README.md)

## ディレクトリの構造
- **Resource**
  画像ファイルなど個人的なファイルを保存するディレクトリ
- **Config**
  設定ファイルを保存するディレクトリ
  - **.config**
    $HOMEディレクトリに設置する`.config`ディレクトリ
  - **.Portable**
    クロスプラットフォームのポータブル版の設定ファイルを保存するディレクトリ
  - **.Windows**
    Windows・インストーラー版
    - **.Portable**
    - **[ConfigPotision.csv](../Config/.Windows/ConfigPotision.csv)**
      コピーするファイルとディレクトリを設定するファイル
  - **.Ubuntu**
    Ubuntu・インストーラー版
    - **.config**
    - **.Portable**

- **Package**
  パッケージマネージャーでインストールできるIDをまとめるディレクトリ
- **Setup**
  - **Command**
    実行するコマンドのファイル
    - **.priority_command.txt**
      最優先で読み込むコマンドファイル
  - **Distribution**
    Bashを使うインストーラー
  - **Windows**
    Windowsで使用するインストーラー
- **[install.sh](../install.sh)**
  Linux用のインストーラー
- **[Windows_Installer.ps1](../Windows_Installer.ps1)**
  Windows11用のインストーラー
- **[Mac_Installer.sh](../Mac_Installer.sh)**
  MaxOS用のインストーラー
- **[.gitignore](../.gitignore)**
- **[README.md](../README.md)**
- **[LICENSE](../LICENSE)**

## セットアップの仕組み
セットアップの順番は以下の通りに行われます。

### install.sh
- ディストリビューションの確認
- スクリプトの起動
- 一時パスの設定
- 事前のLinuxコマンドの実行
- 設定ファイルのコピー / シンボリックリンクの作成
- パッケージのインストール
- パッケージを介さない独自のインストール
- テキストファイルに記載されたコマンドの実行
- 事後のLinuxコマンドの実行

### Windows_Installer.ps1
- スクリプトの起動
- スクリプトの実行環境を確認
- 一時パスの設定
- 事前のWindowsコマンドの実行
- WinGetによるインストール
- PowersShell PSResourceによるインストール
- テキストファイルに記載されたコマンドの実行
- Visual StudioのINCLUDE,LIB,LIBPATHの設定
- 設定ファイルのコピー / シンボリックリンクの作成
- 事後のWindowsコマンドの実行

## テキストファイルの扱い
特殊文字はこのように扱われます。
- `#` : コメント行
- `//` : コメント行

## Setup
セットアップに使うディレクトリです。

### Command
コマンドが記載されたテキストファイルを設置するディレクトリです。テキストファイルを読み込んでコマンドを実行します。

### Distribution
Linux系のインストーラー分岐です。`install.sh`から読み込むようにしています。

直接起動する場合は以下のコマンドを参考にしてください。
```bash
bash Setup/Distribution/distribution_name.sh
```
