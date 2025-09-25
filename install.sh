#!/usr/bin/env bash

clear
source ./Setup/Bash/common.sh

distribution=$(get_distribution)
if [ "$distribution" = "Ubuntu" ]; then
    source ./Setup/Distribution/Ubuntu.sh
elif [ "$distribution" = "Linux Mint" ]; then
    source ./Setup/Distribution/Linux_Mint.sh
elif [ "$distribution" = "Unknown" ]; then
    error "不明なディストリビューション: $distribution"
else
    error "設定されていないディストリビューション: $distribution"
    exit 1
fi
