from lib import common
import platform
from pathlib import Path
from dataclasses import dataclass, field
import subprocess
import logging
import inspect
from rich.console import Console
from rich.progress import (
    Progress, TimeRemainingColumn, BarColumn, TextColumn, SpinnerColumn,
)
import os
logger = logging.getLogger("Main").getChild("command_install")

def parse_command_file(file_path:Path):
    """
    コマンドファイルからコマンドリストを返す関数
    """
    _,ext = os.path.splitext(file_path)
    if ext == ".txt":
        commands = list()
        with file_path.open('r', encoding='utf-8') as f:
            for line in f.readlines():
                if (line := common.txt_paser(line)) is None:
                    continue
                commands.append(line.split(" "))
    elif ext == ".sh":
        commands = [["source",str(file_path)]]
    elif ext == ".ps1":
        commands = [["pwsh",str(file_path)]]
    return commands

@dataclass
class CommandInstall():
    console:Console = Console()
    command_directory:Path = Path("..","Command")
    priority_path:Path = Path("..","Command",".priority_command.txt")
    pattern_path:str = "*.txt"
    already_list:list = field(default_factory=list)
    command_list:list = field(default_factory=list)
    system:str = platform.system()
    env:dict = field(default_factory=dict)
    command_timeout:int = 600
    dry_run : bool = True

    def glob_command_file(self,pattern = "*.txt"):
        file_list = list()
        for file_path in self.command_directory.glob(pattern):
            if any(keyword.name in file_path.name for keyword in self.already_list):
                continue
            file_list.append(file_path)
        return file_list

    # def load_additional_paths(self) -> list:
    #     """
    #     設定ファイルから追加のパスを読み込む関数
    #     """
    #     additional_paths = list()
    #     # システムに応じたパスファイルを選択
    #     if self.system == "Windows":
    #         path_file = Path("..","Powershell","path.txt")
    #     else:  # Linux, Darwin
    #         path_file = Path("..","Bash","path.txt")
    #     if not path_file.exists():
    #         logger.debug(f"📁 Path file not found: {path_file}")
    #         return list()
    #     try:
    #         with path_file.open('r', encoding='utf-8') as f:
    #             for line in f.readlines():
    #                 if (line := common.txt_paser(line)) is None:
    #                     continue
    #                 # チルダ展開
    #                 expanded_path = os.path.expanduser(line)
    #                 if os.path.exists(expanded_path):
    #                     additional_paths.append(expanded_path)
    #                     logger.debug(f"🔧 Found additional path: {expanded_path}")
    #                 else:
    #                     logger.debug(f"⚠️ Path does not exist: {expanded_path}")
    #     except Exception as e:
    #         logger.error(f"🚨 Error reading path file {path_file}: {e}")
    #     return additional_paths

    def commandinlist_run(self,command_list:list) -> None:
        """
        コマンドリストからコマンドを取り出し実行する関数
        """
        count_success = 0
        count_fail = 0
        if self.dry_run:
            text = "表示中"
        else:
            text = "実行中"
        with Progress(
            TextColumn("[bold blue]{task.description}"),SpinnerColumn(spinner_name="simpleDotsScrolling"),
            " "*0,BarColumn(bar_width=None)," "*0,
            SpinnerColumn(spinner_name="simpleDotsScrolling"),TimeRemainingColumn(elapsed_when_finished=True),
            expand = True,
            console=self.console
        ) as progress:
            task = progress.add_task(f"コマンドを{text}",total=len(command_list))
            for command in command_list:
                if self.command_run(command):
                    count_success += 1
                else:
                    count_fail += 1
                progress.advance(task)
        common.print_success_fail(self.console,count_success,count_fail)

    def command_run(self,command:list) -> bool:
        """
        コマンドを実行する関数
        """
        try:
            logger.debug(f"💬 {command}")
            with self.console.status(" ".join(command),spinner="point") as _:
                if not self.dry_run:
                    result = subprocess.run(command,encoding="utf-8",
                                            check=True, capture_output=True,
                                            text=True, timeout=self.command_timeout)
                    if not result.returncode == 0:
                        self.console.print(f"❌ {command}")
                        return False
        except subprocess.TimeoutExpired as result:
            logger.error(f"⏰ 実行中にタイムアウトしました: "," ".join(command))
            logger.debug(result.stdout)
            return False
        except subprocess.CalledProcessError as result:
            logger.debug(f"return code: {result.returncode}")
            if "already" in result.stderr:
                logger.info(f"💡 既に実行されています: "+" ".join(result.cmd))
                return True
            else:
                logger.error(f"💥 実行に失敗しました : "+" ".join(result.cmd)+"\n"+result.stderr)
                return False
        except Exception as e:
            logger.error(f"🚨 予期しないエラー: {e}")
            return False
        else:
            self.console.print("[green]✔[/green] "+" ".join(command))
            return True

    # 実行関数 #

    def install_command(self,text:str="*.txt"):
        """
        command_directoryにあるファイルに記載されているコマンドのインストール
        """
        logger.debug(f"[bright_black]LOAD : {__name__}.{inspect.stack()[0].function}[/bright_black]")
        # 実行の確認 #
        if not (file_list := self.glob_command_file(self.pattern_path)):
            logger.debug("コマンドファイルはありません。")
            return list()
        command_list = list()
        for file_path in file_list:
            command_list += parse_command_file(file_path)
        if not command_list:
            logger.debug("コマンドはありません。")
            return list()
        # 実行 #
        self.console.print(f"[bright_cyan]{text}のコマンドによるインストールを実行します。[/bright_cyan]")
        self.commandinlist_run(command_list)
        return file_list

    def install_priority_command(self,text:str="指定したファイル"):
        """
        priority_pathで指定したファイルのコマンドによるインストール
        """
        logger.debug(f"[bright_black]LOAD : {__name__}.{inspect.stack()[0].function}[/bright_black]")
        file_list = list()
        # 優先コマンドファイルの読み込み #
        try:
            with self.priority_path.open("r", encoding="utf-8") as f:
                pattern_command_list = f.read().splitlines()
        except FileNotFoundError:
            logger.warning(f"🔍 優先コマンドファイルが存在しません: {self.priority_path}")
            return list()
        except Exception as e:
            logger.error(f"優先コマンドファイルを読み込めません: {e}")
            return list()
        if not pattern_command_list:
            logger.debug("🔧 優先コマンドファイルは空欄です。")
            return list()
        if logger.getEffectiveLevel() == logging.DEBUG:
            self.console.print(pattern_command_list)
        for pattern_file in pattern_command_list:
            file_list += self.glob_command_file(pattern_file)
        if not file_list:
            logger.debug("🔧 コマンドファイルはありません。")
            return list()
        command_list = list()
        for file_path in file_list:
            command_list += parse_command_file(file_path)
        if not command_list:
            logger.debug("🔧 コマンドはありません。")
            return list()
        # 実行 #
        self.console.print(f"[bright_cyan]{text}のコマンドによるインストールを実行します。[/bright_cyan]")
        self.commandinlist_run(command_list)
        return file_list

# メイン関数 #

def run(console,dry_run=False):
    logger.debug(f"LOAD : {__name__}")
    # OSコマンド #
    os_command = CommandInstall(console,Path("..","Command",platform.system()),Path("..","Command",f".priority_{platform.system()}.txt"),"*",dry_run=dry_run)
    os_command.already_list = os_command.install_priority_command("OSディレクトリにある指定したファイル")
    os_command.install_command("OSディレクトリにある*.txtとスクリプトファイル")
    # 汎用コマンド #
    command = CommandInstall(console,Path("..","Command"),dry_run=dry_run)
    command.already_list = command.install_priority_command()
    command.install_command()