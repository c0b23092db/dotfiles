<div align="center">

# ***どっとふぁいる***
**作成途中のプロジェクト**

**Windows(winget)** / **Linux Mint(apt)**

</div>

## ❄ うぇるかむ ❄

![Wezterm_and_Windows](./Resource/github/window_windows.png)

## ☐️ TODO ☑
- [x] Windowsのインストーラーを完成させる
- [x] Ubuntu系統のインストーラーを完成させる
- [ ] メインディストリビューションを決める
- [ ] メインディストリビューションを優先的に使用する
- [ ] Githubに画像を貼る

コンフィグ周り
- [ ] Neovimの設定ファイルを修正する

## 💻 いんふぉめーしょん 💻

### 🗨️ さぽーと 💭
- [x] Windows 11 Pro
- [x] Ubuntu
- [x] Linux Mint
- [ ] Docker

### 📦 ぱっけーじ 📦

#### Global
- Terminal : Wezterm
- Filer : yazi
- Browser : Vivaldi / Comet
- Text Editer Micro / Neovim
- Code Editor : Visual Studio Code / Neovim / Micro
- Music Player : Neiro / mpv
- Video Player : mpv
- Minecraft Launcher : MultiMC

#### Global(Linux)
- Shell : zsh + Starship / bash

#### Programming Language
- Program Manager : mise
  - Rust : rustup
  - Python : uv
  - C# : .NET
  - Java : Open JDK
  - TypeScript : Node.js 24
- C/C++ : cl / clang / gcc
- Godot : GDScript

#### OS

##### Windows
- Package Manager : winget
- Shell : Powershell 7
- Terminal : **Global** / Windows Terminal
- Filer : File Explorer / **Global**
- App Launcher : PowerToys
- Text Editer : メモ帳 / edit / **Global**
- Music Player : メディアプレーヤー / **Global**
- Video Player : メディアプレーヤー / **Global**
- Minecraft Launcher : **Global** / Minecraft Launcher
- C/C++ : cl

##### Linux Mint
- Window Manager : Cinnamon
- Package Manager : apt

## ✿ せっとあっぷ ✿

### 実行方法

**Dotfilesを`$HOME`に設置**し、**`$HOME/.dotfiles`で起動する**ことを前提としています。

```bash
git clone https://github.com/c0b23092db/dotfiles ~/.dotfiles
cd ~/.dotfiles
bash install.sh
```

```powershell
.\Windows-Installer.ps1 <option>
```

もしくは、**対応するディストリビューションもしくはベースとなったディストリビューションを直接起動**してください。

```bash
bash Setup/Distribution/Ubuntu.sh
```

### フォント
必須フォントは以下の通りです。
- [UDEV Gothic HS](https://github.com/yuru7/udev-gothic)

もし、違うフォントを使う場合は`wezterm/config/font.lua`の該当部分を変更してください。
```lua:font.lua
        family = "UDEV Gothic 35HSJPDOC",
```
その他のフォントは[URL_Font.csv](./Resource/URL/URL_Font.csv)に掲載してます。

## ⚙️ セットアップファイルについて ⚙️
- [Setup](Setup/README.md)
- [Bash](Setup/Bash/README.md)

## 📄 ライセンス 📝
[MIT License](./LICENSE) / <http://opensource.org/licenses/MIT>
