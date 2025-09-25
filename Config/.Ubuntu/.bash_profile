#!/usr/bin/env bash

# ============================ #
#  Required settings for bash  #
# ============================ #

# .bashrc 読み込み #
[ "$BASH_VERSION" ] && [ -f $HOME/.bashrc ] && source "$HOME/.bashrc"

# PATH #
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# 環境変数 #
export LANGUAGE=ja_JP:ja
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export SHELL='/bin/bash'
export EDITOR=nvim
export YAZI_CONFIG_HOME="$HOME/.config/yazi"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

