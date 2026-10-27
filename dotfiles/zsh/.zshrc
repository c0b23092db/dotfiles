#!/usr/bin/env zsh

##### エイリアスの読み込み #####
[ -f $HOME/.alias ] && source $HOME/.alias

##### 補完 #####
# autoload -U compinit; compinit
bindkey '^I' menu-complete
bindkey '^[[Z' reverse-menu-complete

##### 履歴 #####
HISTFILE=$ZDOTDIR/.zsh_history
setopt auto_list    # 補完候補を一覧で表示する(d)
setopt auto_menu    # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed  # 補完候補をできるだけ詰めて表示する
setopt list_types   # 補完候補にファイルの種類も表示する
setopt hist_ignore_dups # 直前のコマンドの重複を削除する
setopt hist_ignore_all_dups # 同じコマンドをhistoryに残さない
setopt hist_reduce_blanks # historyに保存するときに余分なスペースを削除する

##### eval #####
eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"
eval "$(sheldon source)"
eval "$(starship init zsh)"
