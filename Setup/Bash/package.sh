#!/usr/bin/env bash
source ./Setup/Bash/common.sh

#===== パッケージマネージャーの確認 =====#
package_manager=$(get_packagemanager)
if [ "$package_manager" = "Unknown" ] ; then
    error "サポートされてないパッケージマネージャーです : $package_manager"
    exit 1
fi

info "===== パッケージマネージャーの更新 ====="
if [ "$package_manager" = "apt" ] ; then
    spinner_load "システムのアップデート" "sudo apt update --yes"
    spinner_load "システムのアップグレード" "sudo apt upgrade --yes"
elif [ "$package_manager" = "pacman" ] ; then
    spinner_load "システムのアップデート" "sudo pacman -Syu"
else
    error "サポートされてないパッケージマネージャーです : $package_manager"
    exit 1
fi

info "===== パッケージのインストール ====="
count=0
mapfile -t parse_list < <(parse_txt ./Package/bash-$package_manager.txt)
for line in "${parse_list[@]}"; do
    count=$((count+1))
    if [ "$package_manager" = "apt" ]; then
        spinner_load "${line} のインストール" "sudo apt install --yes ${line}"
    elif [ $package_manager = "pacman" ] ; then
        spinner_load "${line} のインストール" "sudo pacman -S ${line}"
    fi
done
