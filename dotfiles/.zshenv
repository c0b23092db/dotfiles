#!/usr/bin/env zsh

# ZSH #
export ZDOTDIR="$HOME/.config/zsh"
# 共通 #
[ -f $HOME/.env ] && source $HOME/.env
export HISTSIZE=1000
export SAVEHIST=10000
export EDITOR=nvim
export MISE_OS=Linux
export ZSH_PATH=$(which zsh)
