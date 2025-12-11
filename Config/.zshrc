#!/bin/zsh

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

##### Defaults #####
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

##### 環境変数 #####
[ -f $HOME/.env ] && source $HOME/.env

##### eval #####
eval "$(zoxide init zsh)"
eval "$(~/.local/bin/mise activate zsh)"
eval "$(sheldon source)"
eval "$(starship init zsh)"

##### 履歴 #####
HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
setopt auto_list    # 補完候補を一覧で表示する(d)
setopt auto_menu    # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed  # 補完候補をできるだけ詰めて表示する
setopt list_types   # 補完候補にファイルの種類も表示する
setopt hist_ignore_dups # 直前のコマンドの重複を削除する
setopt hist_ignore_all_dups # 同じコマンドをhistoryに残さない
setopt hist_reduce_blanks # historyに保存するときに余分なスペースを削除する

##### 補完 #####
# autoload -U compinit; compinit
bindkey '^I' menu-complete
bindkey '^[[Z' reverse-menu-complete

##### エイリアスの読み込み #####
[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases
