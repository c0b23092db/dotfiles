from lib import common
from pathlib import Path
from dataclasses import dataclass
import csv
import shutil
from os import getenv
import logging
import platform
import inspect
from rich.console import Console
from rich.progress import (
    Progress, TimeRemainingColumn, BarColumn, TextColumn, SpinnerColumn,
)
logger = logging.getLogger("Main").getChild("command_config")

def windows_appdata_path() -> dict[str,Path]:
    """
    Windows の環境変数から AppData のパスを取得する関数
    """
    return {
        "Local": Path(getenv("LOCALAPPDATA")),
        "LocalLow": Path(getenv("APPDATA")).parent / "LocalLow",
        "Roaming": Path(getenv("APPDATA")),
    }

@dataclass
class CommandConfig():
    console: Console = Console()
    target_directory:Path = Path("..","..","Config")
    os_directory:Path = Path("..","..","Config","."+platform.system())
    home_directory:Path = Path.home()
    config_directory:Path = Path.home() / ".config"
    configpotision:Path = os_directory / "configpotision.csv"
    system:str = platform.system()
    command_timeout:int = 300
    dry_run:bool = True

    # OS別設定関数 #

    def Global(self):
        """
        Config配下の設定ファイルを .config にコピーする関数
        """
        logger.debug(f"[bright_black]LOAD : {__name__}.{inspect.stack()[0].function}[/bright_black]")
        count_success = 0
        count_fail = 0
        config_dotfiles = [f for f in self.target_directory.iterdir() if f.is_file()]
        config_list = [f for f in (self.target_directory/Path(".config")).iterdir()]
        if logger.getEffectiveLevel() == logging.DEBUG:
            self.console.print(config_list)
        if self.dry_run:
            text = "表示中"
        else:
            text = "コピー中"
        with Progress(
            TextColumn("[bold blue]{task.description}"),SpinnerColumn(spinner_name="simpleDotsScrolling"),
            " "*0,BarColumn(bar_width=None)," "*0,
            SpinnerColumn(spinner_name="simpleDotsScrolling"),TimeRemainingColumn(elapsed_when_finished=True),
            expand = True,
            console=self.console
        ) as progress:
            task = progress.add_task(f"設定ファイルを{text}",total=len(config_list)+len(config_dotfiles))
            for config_path in config_dotfiles: # dotfilesをコピー #
                if self.copy_config(config_path,self.home_directory / config_path.name):
                    count_success += 1
                else:
                    count_fail += 1
                progress.advance(task)
            for config_path in config_list: # configをコピー #
                if self.copy_config(config_path,self.config_directory / config_path.name):
                    count_success += 1
                else:
                    count_fail += 1
                progress.advance(task)
        common.print_success_fail(self.console,count_success,count_fail)

    def Linux(self):
        """
        Linux配下の設定ファイルを .config にコピーする関数
        """
        logger.debug(f"[bright_black]LOAD : {__name__}.{inspect.stack()[0].function}[/bright_black]")
        self.Global()

    def Darwin(self):
        """
        Darwin配下の設定ファイルを .config にコピーする関数
        """
        logger.debug(f"[bright_black]LOAD : {__name__}.{inspect.stack()[0].function}[/bright_black]")
        self.Global()

    def Windows(self):
        """
        Windows配下の設定ファイルを .config/Local/LocalLow/Roaming にコピーする関数"""
        logger.debug(f"[bright_black]LOAD : {__name__}.{inspect.stack()[0].function}[/bright_black]")
        # ファイルチェック #
        if not self.configpotision.exists():
            logger.warning(f"🔍 {self.configpotision}は存在しません")
            return
        # Windowsの設定ファイルを置く場所を記載したCSVファイルを読み込む #
        name = ""
        config = ""
        target = ""
        path_list = list()
        appdata_paths = windows_appdata_path()
        count_success = 0
        count_fail = 0
        with self.configpotision.open("r",encoding="utf-8") as f:
            reader = csv.DictReader(f)
            """
            configpotision.csv のフォーマット
            PATH,CONFIG_PATH,TARGET_APPDATA
            """
            for row in reader:
                if not (row["PATH"] or row["CONFIG_PATH"] or row["TARGET_APPDATA"]):
                    logger.warning(f"⚠️ {row} は不正なデータです")
                    continue
                name:Path = Path(row["PATH"])
                if row["CONFIG_PATH"] == "Global":
                    config = self.target_directory
                elif row["CONFIG_PATH"] == "Config":
                    config = self.target_directory / Path(".config")
                elif row["CONFIG_PATH"] == "OS":
                    config = self.os_directory
                else:
                    config = Path(self.os_directory,row["CONFIG_PATH"])
                if row["TARGET_APPDATA"] == "Local" or row["TARGET_APPDATA"] == "Roaming":
                    target:Path = appdata_paths[row["TARGET_APPDATA"]]
                else:
                    target = Path.home() / row["TARGET_APPDATA"]
                path_list.append({"name":name,"config":config,"target":target})
        if logger.getEffectiveLevel() == logging.DEBUG:
            self.console.print(path_list)
        if self.dry_run:
            text = "表示中"
        else:
            text = "コピー中"
        with Progress(
            TextColumn("[bold blue]{task.description}"),SpinnerColumn(spinner_name="simpleDotsScrolling"),
            " "*0,BarColumn(bar_width=None)," "*0,
            SpinnerColumn(spinner_name="simpleDotsScrolling"),TimeRemainingColumn(elapsed_when_finished=True),
            expand = True,
            console=self.console
        ) as progress:
            task = progress.add_task(f"設定ファイルを{text}",total=len(path_list))
            for config_path in path_list:
                if self.copy_config(config_path["config"] / config_path["name"],config_path["target"] / config_path["name"]):
                    count_success += 1
                else:
                    count_fail += 1
                progress.advance(task)
        common.print_success_fail(self.console,count_success,count_fail)

    # 実行動作関数 #

    def copy_config(self,config_path:Path,target_path:Path) -> bool:
        """
        設定ファイルをコピーする関数
        config_path : コピー元の設定ファイルのパス
        target_path : コピー先の設定ファイルのパス
        """
        try:
            if self.dry_run:
                self.console.print(f"💾 コピー先 : {config_path} -> {target_path}")
            else:# コピー実行 #
                with self.console.status("コピー中...",spinner="point") as _:
                    if config_path.is_dir():
                        shutil.copytree(config_path, target_path, dirs_exist_ok=True)
                    else:
                        target_path.parent.mkdir(parents=True, exist_ok=True)
                        shutil.copy2(config_path, target_path)
                self.console.print(f"[green]✔[/green] {config_path.name} をコピーしました")
        except Exception as e:
            self.console.print(f"❌ {config_path.name} のコピーに失敗しました : {e}")
            return False
        else:
            return True

    # 実行関数 #

    def check_run(self) -> bool:
        if not self.target_directory.exists():
            logger.debug(f"🔍 {self.target_directory} は存在しません")
            return False
        if not self.os_directory.exists():
            logger.debug(f"🔍 {self.os_directory} は存在しません")
            return False
        return True

    def run(self):
        if not self.check_run():
            return
        system = platform.system()
        if hasattr(self, system):
            self.console.print("[blue]設定ファイルをコピーします。[/blue]")
            getattr(self, system)()
        else:
            logger.warning(f"⚠️ {system} は未対応の OS です")

def run(console:Console,dry_run=False):
    logger.debug(f"LOAD : {__name__}")
    config_run = CommandConfig(console,dry_run=dry_run)
    config_run.run()
