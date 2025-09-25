#!/usr/bin/env bash
source ./Setup/Bash/common.sh

# mise,uvのインストール
if ! command -v mise &> /dev/null; then
    spinner_load "miseのインストール" "(curl https://mise.run | sh)"
fi
if ! command -v uv &> /dev/null; then
    spinner_load "uvのインストール" "mise use -g uv"
fi

# Pythonディレクトリの確認
if [ ! -d "./Setup/Python" ]; then
    error "Pythonディレクトリが見つかりません"
    exit 1
fi

# Python/pyproject.tomlの確認とプロジェクト初期化
if [ ! -f "./Setup/Python/pyproject.toml" ]; then
    spinner_load "Python プロジェクトを初期化しています" "uv init ./Setup/Python --python 3.13 --no-readme"
    spinner_load "requirements.txtからインストールしています" "uv add --directory ./Setup/Python -r requirements.txt"
fi

# Pythonスクリプトの実行
uv run --directory ./Setup/Python main.py --run