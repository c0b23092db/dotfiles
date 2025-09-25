#!/usr/bin/env bash

# 色の定義 #
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
BOLD="\033[1m"
RESET="\033[0m"

# 出力の定義 #
info ()     { printf "\r${BLUE}$1${RESET}\n"; }
info_log () { printf "\r${CYAN}$1...${RESET}\n"; }
success ()  { printf "\e[2K\r${GREEN}✔${RESET} $1\n"; }
warn ()     { printf "\e[2K\r${YELLOW}⚠${RESET} $1\n"; }
error ()    { printf "\e[2K\r${RED}✖${RESET} $1\n"; }
spinner ()  {
    local i=0
    local pid=$!
    local spin='-\|/'
    local n=${#spin}
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % $n ))
        printf "\r${MAGENTA}${spin:$i:1} ${CYAN}$1...${RESET}"
        sleep 0.1
    done
    wait $pid
    exit_code=$?
    if [ $exit_code -eq 0 ]; then
        success "${WHITE}$1${RESET}"
    else
        error "${WHITE}$1...${RED}$exit_code${RESET}"
    fi
}
spinner_load() {
    bash -c "$2" > /dev/null 2>&1 & spinner "$1"
    # eval "$2" > /dev/null 2>&1 & spinner "$1"
}

# 関数の定義 #
get_distribution() {
    local distri_name="Unknown"
    if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        if [ -e /etc/lsb-release ]; then
            distri_name="Ubuntu"
        else
            distri_name="Debian"
        fi
    elif [ -e /etc/redhat-release ]; then
        if [ -e /etc/oracle-release ]; then
            distri_name="Oracle"
        else
            distri_name="Red Hat"
        fi
    elif [ -e /etc/pop-os ]; then
        distri_name="Pop!_OS"
    elif [ -e /etc/fedora-release ]; then
        distri_name="Fedora"
    elif [ -e /etc/arch-release ]; then
        distri_name="Arch"
    elif [ -e /etc/nix-release ]; then
        distri_name="Nix"
    elif [ -e /etc/turbolinux-release ]; then
        distri_name="Turbol"
    elif [ -e /etc/SuSE-release ]; then
        distri_name="SuSE"
    elif [ -e /etc/mandriva-release ]; then
        distri_name="Mandriva"
    elif [ -e /etc/vine-release ]; then
        distri_name="Vine"
    elif [ -e /etc/gentoo-release ]; then
        distri_name="Gentoo"
    else
        distri_name="Unknown"
    fi
    echo ${distri_name}
}

new_get_distribution() {
    local distri_name="Unknown"
    if [ -e /etc/os-release ]; then
        source /etc/os-release && distri_name=$NAME
        # Ubuntu : Ubuntu
        # Pop! OS : Pop!_OS
        # Linux Mint : Linux Mint
    elif [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        if [ -e /etc/lsb-release ]; then
            distri_name="Ubuntu"
        else
            distri_name="Debian"
        fi
    fi
    echo $distri_name
}

# mapfile -t parse_list < <(parse_txt ファイル名)
# for p in "${parse_list[@]}"; do echo $p; done
parse_txt() {
    declare -a parse_list=()
    while read -r line || [ -n "$line" ]; do
        line=$(echo "$line" | tr -d '\r' | xargs)
        [ -z "$line" ] && continue
        case "$line" in //*) continue ;; \#*) continue ;; esac
        parse_list+=("$line")
    done < "$1"
    printf "%s\n" "${parse_list[@]}"
}
