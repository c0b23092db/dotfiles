#!/usr/bin/env bash

##### 初期化 #####
clear
source ./Setup/Bash/common.sh
distribution=$(get_distribution)
info "${BOLD}========== ${distribution} Dotfiles セットアップ =========="

# 事前セットアップ＃＃
source ./Setup/Bash/Similar_Before.sh

# セットアップ #
source ./Setup/Bash/dotfile.sh
source ./Setup/Bash/package.sh
source ./Setup/Bash/procedure_package.sh
source ./Setup/Bash/command.sh

# 事後セットアップ #
source ./Setup/Bash/Similar_After.sh

info "${BOLD}========== ${distribution} Dotfiles セットアップ完了 =========="
printf "新しいシェルを開くか、\`source ~/.zshrc\`を実行して、パスの変更を反映してください。\n"