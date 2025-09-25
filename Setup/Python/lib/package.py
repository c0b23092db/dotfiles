from lib import common
import re
import csv
import platform
from pathlib import Path
import subprocess
import logging
import inspect
from rich.console import Console
from rich.progress import (
    Progress, TimeRemainingColumn, BarColumn, TextColumn, SpinnerColumn,
)
from rich.table import Table
logger = logging.getLogger("Main").getChild("command_install")
console = Console()
id_directory = Path("..","..","Package")
command_timeout = 300

def get_package_manager(system="Unknown") -> str:
    """
    OSに応じたパッケージマネージャー(winget,brew,apt)を返す関数
    """
    if system == "Windows":
        return "winget"
    elif system == "Darwin":
        return "brew"
    elif system == "Linux":
        return "apt"
    else:
        return "Unknown"

def creat_search_command(package_manager="",package_name="") -> list[str]:
    """
    パッケージマネージャー(winget,brew,apt)によるコマンドの実行コマンドを作成する関数
    """
    match package_manager:
        case "winget": # Windows
            return ["winget","search","--exact","--id",package_name]
        case "brew": # macOS
            return ["brew","search",package_name]
        case "apt": # Ubuntu
            return ["apt","search",package_name]
        case "pacman": # Arch
            return ["pacman","-Ss",package_name]
        case "dnf": # Fedora
            return ["dnf","search",package_name]
        case "nix": # NixOS
            return ["nix","search",package_name]
        case _: # "Unknown"
            logger.warning(f"不明なパッケージマネージャー: {package_manager}")
            return list()

def creat_install_command(package_manager="",package_name="") -> list[str]:
    """
    パッケージマネージャー(winget,brew,apt)によるコマンドの実行コマンドを作成する関数
    """
    match package_manager:
        case "winget": # Windows
            return ["winget","install","--source","winget","--exact","--id",package_name]
        case "brew": # macOS
            return ["brew","install",package_name]
        case "apt": # Ubuntu
            return ["sudo","apt","install","--yes",package_name]
        case "pacman": # Arch
            return ["sudo","pacman","-S",package_name]
        case "dnf": # Fedora
            return ["sudo","dnf","install","-y",package_name]
        case "nix": # NixOS
            return ["nix-env","-i",package_name]
        case _: # "Unknown"
            logger.warning(f"不明なパッケージマネージャー: {package_manager}")
            return list()

def read_id_in_csv(package_manager:str,file_path:str = "id.csv") -> list:
    """
    id_install.csv を読み込んで、idリストを返す
    """
    logger.debug(f"[bright_black]LOAD : {__name__}.{inspect.stack()[0].function}[/bright_black]")
    file_path:Path = id_directory / file_path
    name_list:list[str] = list()
    install_list:list[str] = list()
    # 読み込み
    try:
        with file_path.open('r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                flag_name = False
                match row['INSTALL']:
                    case "a" | "all":
                        flag_name = True
                        if package_manager == "winget":
                            install_list.append(row['winget'])
                        elif package_manager == "brew":
                            install_list.append(row['brew'])
                        elif package_manager == "apt":
                            install_list.append(row['apt'])
                        elif package_manager == "pacman":
                            install_list.append(row['pacman'])
                    case "winget" if package_manager == "winget":
                        flag_name = True
                        install_list.append(row['winget'])
                    case "brew" if package_manager == "brew":
                        flag_name = True
                        install_list.append(row['brew'])
                    case "apt" if package_manager == "apt":
                        flag_name = True
                        install_list.append(row['apt'])
                    case "pacman" if package_manager == "pacman":
                        flag_name = True
                        install_list.append(row['pacman'])
                if flag_name == True:
                    name_list.append(row['NAME'])
    except FileNotFoundError:
        logger.debug(f"CSVファイルが見つかりません: {file_path}")
        return None,None
    if name_list == list() or install_list == list():
        logger.debug("id_install.csv にデータがありません。")
        return None,None
    # 出力
    if logger.getEffectiveLevel() == logging.DEBUG:
        table = Table(title="インストール対象")
        table.add_column("NAME")
        table.add_column("ID")
        for name,package in zip(name_list, install_list):
            table.add_row(name, package)
        console.print(table)
    return name_list,install_list

def read_id_in_txt(file_path:str = "id.txt") -> list:
    """
    id.txt を読み込んで、idリストを返す
    """
    logger.debug(f"[bright_black]LOAD : {__name__}.{inspect.stack()[0].function}[/bright_black]")
    file_path:Path = id_directory / file_path
    name_list = list()
    install_list = list()
    # 読み込み
    try:
        with file_path.open('r',encoding='utf-8') as f:
            for line in f.readlines():
                if (line := common.txt_paser(line)) is None:
                    continue
                parts = line.split(",") # 一つの場合、IDのみ
                if len(parts) == 1:
                    name_list.append("")
                    install_list.append(parts[0].strip())
                elif len(parts) == 2: # 二つの場合、名前とIDを分ける
                    name, package_id = parts[0].strip(), parts[1].strip()
                    name_list.append(name)
                    install_list.append(package_id)
    except FileNotFoundError:
        logger.debug(f"TXTファイルが見つかりません: {file_path}")
        return None,None
    if name_list == list() or install_list == list():
        logger.debug(f"{file_path} にデータがありません。")
        return None,None
    # 出力
    if logger.getEffectiveLevel() == logging.DEBUG:
        console.print(install_list)
    return name_list,install_list

def install_package(console:Console,dry_run=False,package_manager="Unknown",package="") -> bool:
    """
    パッケージマネージャー(winget,brew,apt)によるインストール/検索の実行関数
    """
    if dry_run:
        command = creat_search_command(package_manager,package)
        text = "検索"
    else:
        command = creat_install_command(package_manager,package)
        text = "インストール"
    try:
        logger.debug(f"💬 {' '.join(command)}")
        with console.status(f"{text}中 : {package}",spinner="point") as _:
            result = subprocess.run(command,
                            check=True, timeout=command_timeout, encoding="utf-8", capture_output=True, text=True)
        if not result.returncode == 0:
            logger.error(f"❌ {package} のインストールに失敗しました")
            return False
    except subprocess.TimeoutExpired as result:
        logger.error(f"⏰ {package} のインストール中にタイムアウトしました")
        console.print(result.stdout)
        return False
    except subprocess.CalledProcessError as result:
        # Windows / winget #
        if result.returncode == 2316632084:
            logger.warning(f"❌ {package}は見つかりませんでした")
            return False
        elif result.returncode == 2316632107:
            logger.info(f"[green]✔[/green] {package} は既にインストールされています")
            return True
        else:
            if package_manager == "winget":
                output = re.sub(r"^[\s\-\\|/]+\n", "", result.stdout + result.stderr)
            else:
                output = result.stdout + result.stderr
            logger.error(f"❌ {package} のインストール中にエラーが発生しました: {output}")
            return False
    else:
        if dry_run:
            console.print(f"[green]✔[/green] {package} を検索しました")
        else:
            console.print(f"[green]✔[/green] {package} をインストールしました")
        return True

def commandinlist_run(console:Console,dry_run=False,package_manager:str=None,name_list:list=None,install_list:list=None):
    if dry_run:
        console.print(f"[bright_cyan]{package_manager}による検索を実行します。[/bright_cyan]")
        text = "検索中"
    else:
        console.print(f"[bright_cyan]{package_manager}によるインストールを実行します。[/bright_cyan]")
        text = "インストール中"
    count_success = 0
    count_fail = 0
    with Progress(
        TextColumn("[bold blue]{task.description}"),SpinnerColumn(spinner_name="simpleDotsScrolling"),
        " "*0,BarColumn(bar_width=None)," "*0,
        SpinnerColumn(spinner_name="simpleDotsScrolling"),TimeRemainingColumn(elapsed_when_finished=True),
        expand = True,
        console=console
    ) as progress:
        task = progress.add_task("パッケージ："+text,total=len(install_list))
        for name,package in zip(name_list,install_list):
            if package == "":
                logger.warning(f"{name} のIDが空欄です。")
                count_fail += 1
            elif install_package(console,dry_run, package_manager, package) == True:
                count_success += 1
            else:
                count_fail += 1
            progress.advance(task)
    common.print_success_fail(console,count_success,count_fail)

def check_run(package_manager:str=None) -> bool:
    """
    実行可能かを確認する関数
    """
    if package_manager == None and get_package_manager(platform.system()) == "Unknown":
        logger.debug("パッケージマネージャーの自動検出に失敗しました。")
        return False
    return True

# 実行関数 #
def install_csv(console:Console,dry_run=False,package_manager:str=None):
    """
    ..\\command\\id_install.csv
    IDを使ったパッケージマネージャー(winget,brew,apt)によるインストール
    """
    logger.debug(f"[bright_black]LOAD : {__name__}.{inspect.stack()[0].function}[/bright_black]")
    # 実行の確認 #
    if not check_run(package_manager):
        return
    package_manager = get_package_manager(platform.system())
    name_list,install_list = read_id_in_csv(package_manager)
    if name_list == None or install_list == None:
        return
    # 実行 #
    commandinlist_run(console,dry_run,package_manager,name_list,install_list)

def install_txt(console:Console,dry_run=False,package_manager:str=None):
    """
    ..\\command\\*.txt
    IDを使ったパッケージマネージャー(winget,brew,apt)によるインストール
    """
    logger.debug(f"[bright_black]LOAD : {__name__}.{inspect.stack()[0].function}[/bright_black]")
    # 実行の確認 #
    if not check_run(package_manager):
        return
    package_manager = get_package_manager(platform.system())
    name_list,install_list = read_id_in_txt(package_manager+".txt")
    if name_list == None or install_list == None:
        return
    # 実行 #
    commandinlist_run(console,dry_run,package_manager,name_list,install_list)

def run(console,dry_run=False,package=None):
    logger.debug(f"LOAD : {__name__}")
    install_csv(console,dry_run,package)
    install_txt(console,dry_run,package)