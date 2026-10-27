#!/usr/bin/env bash

# 設定ファイル #
[ -f $HOME/.default.sh ] && source $HOME/.default.sh
[ "$BASH_VERSION" ] && [ -f $HOME/.bashrc ] && source "$HOME/.bashrc"
[ "$ZSH_VERSION" ] && [ -f $HOME/.zshrc ] && source "$HOME/.zshrc"

# PATH #
[ -d "$HOME/.path" ] && export PATH="$HOME/.path:$PATH"

# 環境変数 #
[ -f $HOME/.env ] && source $HOME/.env
[ -f $HOME/.zshenv ] && source $HOME/.zshenv