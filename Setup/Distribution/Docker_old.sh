#!/usr/bin/env bash

##### 初期化 #####
clear
source ./Setup/Bash/common.sh
info "${BOLD}========== Docker Dotfiles セットアップ ==========${RESET}"

# 引数の解析 #
DRY_RUN=false
RUN=false
DEBUG=false
HELP=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            ;;
        --run)
            RUN=true
            ;;
        --debug)
            DEBUG=true
            ;;
        --help)
            HELP=true
            ;;
        *)
            echo "不明なオプション: $1"
            exit 1
            ;;
    esac
    shift
done

# パスの設定 #
mapfile -t path_list < <(parse_txt ./Setup/Bash/path.txt)
for p in "${path_list[@]}"; do
    export PATH="$p:$PATH"
done
printf "${GREEN}✔${RESET} 一時パスの設定\n"

# dpkg --configure -a
spinner_load "システムのアップデート" "apt -y -qq update"
spinner_load "システムのアップグレード" "apt -y -qq upgrade"

if ! apt list --installed 2>/dev/null | grep -q '^tzdata/'; then
    info_log "tzdataをインストールしています"
    warn "タイムゾーンを設定してください -> Asia/Tokyo : 5/78\n"
    apt install -y tzdata
fi
spinner_load "curlのインストール" "apt install -y -qq curl"
spinner_load "sudoのインストール" "apt install -y -qq sudo"
spinner_load "localesのインストール" "apt install -y -qq locales"
spinner_load "miseのインストール" "(curl https://mise.run | sh)"
spinner_load "uvのインストール" "mise use -g uv"

# Pythonディレクトリの確認
if [ ! -d "./Setup/Python" ]; then
    error "Pythonディレクトリが見つかりません"
    exit 1
fi
# Python/pyproject.tomlの確認とプロジェクト初期化
if [ ! -f "./Setup/Python/pyproject.toml" ]; then
    info_log "Python プロジェクトを初期化しています"
    uv init ./Setup/Python --python 3.13 --no-readme
    info_log "requirements.txtからインストールしています"
    uv add --directory ./Setup/Python -r requirements.txt
fi

# Python引数の構築
python_args=()
if [ "$DRY_RUN" = true ]; then
    python_args+=("--dry-run")
fi
if [ "$RUN" = true ]; then
    python_args+=("--run")
fi
if [ "$DEBUG" = true ]; then
    python_args+=("--debug")
fi
if [ "$HELP" = true ]; then
    python_args+=("--help")
fi

# Pythonスクリプトの実行
uv run --directory "./Setup/Python" "main.py" "${python_args[@]}"

info "===== Docker Dotfiles セットアップ完了 ====="
printf "新しいシェルを開くか、\`zsh\`を実行して、パスの変更を反映してください。\n"