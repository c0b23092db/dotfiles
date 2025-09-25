#!/usr/bin/env bash
source ./Setup/Bash/common.sh

##### apt-keyが必要なパッケージ #####

# lazygit #
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
spinner_load "lazygit のインストール" "sudo install lazygit -D -t /usr/local/bin/"

# mise #
spinner_load "miseのインストール" "(curl https://mise.run | sh)"
