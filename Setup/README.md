# セットアップのREADME

帰り道は → [README.md](../README.md)

## ディレクトリの構造
- **Resource**
  画像ファイルなど個人的なファイルを保存するディレクトリ
- **Config**
  クロスプラットフォーム対応・インストーラー版
  - **.config**
    $HOMEディレクトリに設置する`.config`ディレクトリ
  - **.Portable**
    クロスプラットフォーム・ポータブル版
  - **.Windows**
    Windows・インストーラー版
    - **.Portable**
      Windows・ポータブル版
    - **Self**
    - **Roaming**
    - **configpotision.csv**
      コピーするファイルとディレクトリを設定するファイル
  - **.Ubuntu**
    Ubuntu・インストーラー版
    - **.config**
- **Package**
  パッケージマネージャーでインストールできるIDをまとめるディレクトリ
- **Setup**
  - **Command**
    実行するコマンドのファイル
    - **.priority_command.txt**
      最優先で読み込むコマンドファイル
  - **Distribution**
    Bashを使うインストーラー
  - **Python**
    Pythonを使うインストーラー
- **install.sh**
  Linux用インストーラー
- **windows11.ps1**
  Windows11用インストーラー
- **mac.sh**
  MaxOS用インストーラー
- **[.gitignore](../.gitignore)**
- **[README.md](../README.md)**
- **[LICENCE](../LICENCE)**

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

### windows11.ps1
- スクリプトの起動
- スクリプトファイルのコマンド実行
- Pythonインストーラーの起動
- パッケージマネージャーによる**CSVファイル**でのインストール
- パッケージマネージャーによる**TXTファイル**でのインストール
- .priority_-name-_command.txtで指定したos依存のコマンド実行
- os依存のコマンド実行
- .priority_command.txtで指定したコマンド実行
- コマンド実行

途中でコマンドを実行するファイルが無くても継続するため、**`id_install.csv`を使わずに直接OSディレクトリにパッケージをインストールするコマンドを書く**ことも可能です。

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

### Python
uvを使用したPythonのセットアップです。
詳しくは[PythonのREADME.md](./Python/README.md)をお読みください。
