#!/usr/bin/env bash
source ./Setup/Bash/common.sh

mapfile -t path_list < <(parse_txt ./Setup/Bash/path.txt)
for p in "${path_list[@]}"; do
    export PATH="$p:$PATH"
done
printf "${GREEN}✔${RESET} 一時パスの設定\n"
