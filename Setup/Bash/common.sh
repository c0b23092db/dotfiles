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
}

get_distribution() {
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
    elif [ -e /etc/redhat-release ]; then
        if [ -e /etc/oracle-release ]; then
            distri_name="Oracle"
        else
            distri_name="Red Hat"
        fi
    else
        distri_name="Unknown"
    fi
    echo $distri_name
}

get_packagemanager() {
    if command -v brew > /dev/null ; then # macOS
        package_manager="brew"
    elif command -v apt > /dev/null ; then   # Linux
        package_manager="apt"
    elif command -v pacman > /dev/null ; then # Arch
        package_manager="pacman"
    elif command -v dnf > /dev/null ; then # Fedora
        package_manager="dnf"
    elif command -v yum > /dev/null ; then # RedHat
        package_manager="yum"
    elif command -v zypper > /dev/null ; then # openSUSE
        package_manager="zypper"
    elif command -v dpkg > /dev/null ; then # Debian
        package_manager="dpkg"
    else
        package_manager="Unknown"
    fi
    echo $package_manager
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
