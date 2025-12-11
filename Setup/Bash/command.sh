#!/usr/bin/env bash
source ./Setup/Bash/common.sh
source $HOME/.env

# コマンドファイルの実行
run_commands_from_file() {
    local file="$1"
    echo "📁 $file"
    mapfile -t cmds < <(parse_txt "$file")
    for cmd in "${cmds[@]}"; do
        spinner_load "$cmd を実行" "$cmd"
    done
}

# ディレクトリ内の *.txt ファイルを順番に実行
# exclude_list に指定したファイルは除外
run_commands_from_dir() {
    local dir="$1"
    local pattern="$2"
    local priority_file="$3"
    shopt -s nullglob
    if [[ -f "./Setup/Command/$priority_file" ]]; then
        mapfile -t exclude_list < <(parse_txt "./Setup/Command/$priority_file")
        for file in "$dir"/$pattern; do
            local skip=false
            for ex in "${exclude_list[@]}"; do
                [[ $(basename "$file") == "$ex" ]] && skip=true && break
            done
            $skip && continue
            run_commands_from_file "$file"
        done
    else
        for file in "$dir"/$pattern; do
            run_commands_from_file "$file"
        done
    fi
    shopt -u nullglob
}

# 優先ファイル読み込み
run_priority_commands() {
    local dir="$1"
    local pattern="$2"
    local priority_file="$3"
    local -a executed=()
    while read -r pattern || [ -n "$pattern" ]; do
        [[ -z "$pattern" ]] && continue
        for file in $dir/$pattern ; do
            [[ -f "$file" ]] || continue
            run_commands_from_file "$file"
            executed+=$file
        done
    done < "./Setup/Command/$priority_file"
}

distro=$(get_distribution)

if [[ -f "./Setup/Command/.priority_command.txt" ]]; then
    info "===== 優先ファイル ====="
    run_priority_commands "./Setup/Command" "*.txt" ".priority_command.txt"
fi

info "===== 共通ファイル ====="
run_commands_from_dir "./Setup/Command" "*.txt" ".priority_command.txt"

if [[ -d "./Setup/Command/$distro" ]]; then
    info "===== ディストリビューションファイル: $distro ====="
    run_commands_from_dir "./Setup/Command/$distro" "*.txt" ".priority_$distro.txt"
fi