#!/usr/bin/env zsh

# config #
[ "$BASH_VERSION" ] && [ -f $HOME/.default ] && source "$HOME/.default.sh"
[ "$ZSH_VERSION" ] && [ -f $ZDOTDIR/.zshrc ] && source "$ZDOTDIR/.zshrc"

# path #
[ -f $HOME/.path ] && source "$HOME/.path"
