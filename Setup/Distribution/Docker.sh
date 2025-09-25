#!/usr/bin/env bash

##### 初期化 #####
clear
source ./Setup/Bash/common.sh
info "${BOLD}=============== Docker Dotfiles セットアップ ==============="

# セットアップ #
spinner_load "システムのアップデート" "apt -y -qq update"
spinner_load "システムのアップグレード" "apt -y -qq upgrade"
if ! apt list --installed 2>/dev/null | grep -q '^tzdata/'; then
    info_log "tzdataをインストールしています"
    warn "タイムゾーンを設定してください -> Asia/Tokyo : 5/78\n"
    apt install -y tzdata
fi
spinner_load "curl のインストール" "apt install -y -qq curl"
spinner_load "sudo のインストール" "apt install -y -qq sudo"

source ./Setup/Bash/Similar_Before.sh
source ./Setup/Bash/dotfile.sh
source ./Setup/Bash/package.sh
source ./Setup/Bash/procedure_package.sh
source ./Setup/Bash/command.sh
chsh -s $(which zsh)

info "${BOLD}=============== Docker Dotfiles セットアップ完了 ==============="
printf "新しいシェルを開くか、\`zsh\`を実行して、パスの変更を反映してください。\n"
