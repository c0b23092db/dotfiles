"""
Dotfiles セットアップスクリプト
"""

def main():
    from rich import pretty
    from rich.console import Console
    from rich.logging import RichHandler
    from rich.panel import Panel
    import logging
    import sys
    import argparse
    from lib import common
    # setting #
    console = Console()
    pretty.install()
    logging.basicConfig(
        level=logging.WARNING,
        encoding='utf-8',
        format="%(message)s",
        datefmt="[%X]",
        handlers=[RichHandler(console=console,markup=True,rich_tracebacks=True,show_time=True)],
    )
    logger = logging.getLogger("Main")

    parser = argparse.ArgumentParser(
        description="Dotfiles セットアップスクリプト",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
使用例:
  uv run main.py --run          : セットアップ
  uv run main.py --dry-run      : 予行演習のみ
        """
    )
    parser.add_argument("--run", action="store_true", help="セットアップを実行")
    parser.add_argument("-d","--dry-run", action="store_true", help="予行演習を実行")
    parser.add_argument("-o","--os", help="使用するOSを選択")
    parser.add_argument("-s","--shell", help="使用するシェルを選択" , choices=["Powershell 7","Bash","zsh","fish"])
    parser.add_argument("-p","--package", help="使用するパッケージを選択" , choices=["winget","brew","apt","pacman","dnf","nix"])
    parser.add_argument("--debug", action="store_true", help="デバッグ情報を表示")

    args = parser.parse_args()

    if args.debug:
        console.print("🐳 デバッグモードを開始します",style="bold green")
        logger.setLevel(logging.DEBUG)
    if args.dry_run:
        console.print("💫 予行演習を開始します",style="bold blue")
    elif args.run:
        console.print("🚀 セットアップを開始します",style="bold blue")
    else:
        console.print("⚠️\tセットアップを実行するには --run を指定してください",style="yellow")
        console.print("\tあるいは --help を指定してヘルプを表示してください",style="yellow")
        return

    try:
        logger.debug(f"LOAD : {__name__}")
        from lib import package,command,config
        import platform
        system = platform.system()
        if not args.shell:
            shell = common.get_shell(system)
        package.run(console,args.dry_run,args.package)
        config.run(console,args.dry_run)
        command.run(console,args.dry_run)
    except KeyboardInterrupt:
        console.print("⚠️ ユーザーによってセットアップが中断されました",style="yellow")
        sys.exit(1)
    except Exception as e:
        if args.debug:
            console.print(f"💥 エラーが発生しました",style="red")
            from traceback import format_exc
            console.print(format_exc())
        else:
            error_panel = Panel.fit(
                f"{str(e)}",
                title="💥 エラーが発生しました",
                border_style="red"
            )
            console.print(error_panel)
        sys.exit(1)
    else:
        console.print("🎉 セットアップが完了しました！",style="bold green")
        sys.exit(0)

if __name__ == "__main__":
    main()
