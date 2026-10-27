#!/usr/bin/env bash

[ -f $HOME/.default.sh ] && source "$HOME/.default.sh"

##### エイリアスの読み込み #####
[[ -f ~/.aliases ]] && source ~/.aliases

##### eval #####
eval "$(mise activate bash)"
eval "$(zoxide init bash)"
# eval "$(starship init bash)"
