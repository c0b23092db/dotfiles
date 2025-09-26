#!/usr/bin/env bash
source ./Setup/Bash/common.sh

#===== パッケージマネージャーの確認 =====#
package_manager="Unknown"
if command -v apt > /dev/null ; then   # Linux
    package_manager="apt"
elif command -v pacman > /dev/null ; then # Arch
    package_manager="pacman"
elif command -v dnf > /dev/null ; then # Fedora
    package_manager="dnf"
elif command -v yum > /dev/null ; then # RedHat
    package_manager="yum"
elif command -v zypper > /dev/null ; then # openSUSE
    package_manager="zypper"
elif command -v brew > /dev/null ; then # macOS
    package_manager="brew"
elif command -v dpkg > /dev/null ; then # Debian
    package_manager="dpkg"
else
    error "パッケージの確認に失敗しました"
    exit 1
fi

info "===== パッケージマネージャーの更新 ====="
if [ "$package_manager" = "apt" ] ; then
    spinner_load "システムのアップデート" "sudo apt --yes update"
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
