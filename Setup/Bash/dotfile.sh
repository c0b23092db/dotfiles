#!/usr/bin/env bash
source ./Setup/Bash/common.sh
distribution=$(get_distribution)
flag_copy=0

if [[ flag_copy -eq 0 ]] ; then
    info "=====設定ファイルのコピー====="
    spinner_load "ドットファイルのコピー" "find ./Config -maxdepth 1 -type f -exec cp {} $HOME \;"
    spinner_load ".configのコピー" "cp -rf ./Config/.config $HOME"
    spinner_load ".$distributionのコピー" "cp -rf \"./Config/.$distribution\" $HOME"
else
    info "=====設定ファイルのシンボリックリンク====="
    spinner_load "ドットファイルのシンボリックリンク" "find ./Config -maxdepth 1 -type f -exec ln -s {} $HOME \;"
    spinner_load ".configのシンボリックリンク" "ln -srf ./Config/.config $HOME"
    spinner_load ".$distributionのシンボリックリンク" "ln -srf \"./Config/.$distribution\" $HOME"
fi
