#!/usr/bin/env bash
source ./Setup/Bash/common.sh

# xdg-user-dirs-updateの作成 #
LANG=en_US.UTF-8 xdg-user-dirs-update --force
[[ -d $HOME/デスクトップ ]] && mv $HOME/デスクトップ/* $HOME/Desktop && rm -rf $HOME/デスクトップ
[[ -d $HOME/ダウンロード ]] && mv $HOME/ダウンロード/* $HOME/Downloads && rm -rf $HOME/ダウンロード
[[ -d $HOME/テンプレート ]] && mv $HOME/テンプレート/* $HOME/Templates && rm -rf $HOME/テンプレート
[[ -d $HOME/公開 ]] && mv $HOME/公開/* $HOME/Public && rm -rf $HOME/公開
[[ -d $HOME/ドキュメント ]] && mv $HOME/ドキュメント/* $HOME/Documents && rm -rf $HOME/ドキュメント
[[ -d $HOME/ミュージック ]] && mv $HOME/ミュージック/* $HOME/Music && rm -rf $HOME/ミュージック
[[ -d $HOME/ピクチャ ]] && mv $HOME/ピクチャ/* $HOME/Pictures && rm -rf $HOME/ピクチャ
[[ -d $HOME/ビデオ ]] && mv $HOME/ビデオ/* $HOME/Videos && rm -rf $HOME/ビデオ

# ZSH設定 #
chsh -s $(which zsh)
