from rich.console import Console
from dataclasses import dataclass
import platform
from pathlib import Path
import logging
logger = logging.getLogger("Main").getChild("common")

def print_success_fail(console:Console,success_count:int,fail_count:int) -> None:
    """成功回数と失敗回数を表示する関数"""
    console.print(f"[green]Success:[/green] {success_count}  [red]Fail:[/red] {fail_count}")

def txt_paser(line:str) -> str:
    """
    テキストの行をパースする関数
    """
    line = line.strip()
    if not line or line.startswith(("//","#")):
        return None
    return line

def get_system() -> str:
    """使用しているOSを返す関数"""
    system = platform.system()
    if system == "Windows":
        return "Windows"
    elif system == "Darwin":
        return "Mac"
    elif system == "Linux":
        system = platform.platform()
        if system.startswith("Linux"):
            return "Linux"
        elif system.startswith("Ubuntu"):
            return "Ubuntu"
        elif system.startswith("Debian"):
            return "Debian"
        elif system.startswith("FreeBSD"):
            return "FreeBSD"
        elif system.startswith("OpenBSD"):
            return "OpenBSD"
        elif system.startswith("Arch"):
            return "Arch Linux"
        elif system.startswith("Manjaro"):
            return "Manjaro Linux"
        elif system.startswith("Gentoo"):
            return "Gentoo Linux"
        elif system.startswith("CentOS"):
            return "CentOS"
        elif system.startswith("Red Hat"):
            return "Red Hat"
        elif system.startswith("openSUSE"):
            return "openSUSE"
        elif system.startswith("Fedora"):
            return "Fedora"
        elif system.startswith("NixOS"):
            return "NixOS"
        else:
            return "Unknown"
    else:
        return "Unknown"

def get_shell(system="Unknown") -> str:
    """システムに対応するシェルを返す"""
    if system == "Windows":
        return "Powershell 7"
    elif system == "Darwin":
        return "Zsh"
    elif system == "Linux":
        return "Bash"
    else:
        return "Unknown"

def get_shell_command(shell="Unknown") -> str:
    """システムに対応するシェルコマンドを返す"""
    if shell == "Powershell 7":
        return "pwsh"
    elif shell == "Bash":
        return "bash"
    else:
        return "Unknown"

def get_shell_file(shell="Unknown") -> str:
    """システムに対応するスクリプトファイル拡張子を返す"""
    if shell == "Powershell 7":
        return "*.ps1"
    elif shell == "Bash":
        return "*.sh"
    elif shell == "Zsh":
        return "*.sh"
    else:
        return "Unknown"

def get_config_path(shell="Unknown") -> Path:
    """システムに対応する設定ファイルのパスを返す"""
    if shell == "Powershell 7":
        return Path.home() / "Documents" / "PowerShell" / "Microsoft.PowerShell_profile.ps1"
    elif shell == "Bash" and platform.system() == "Darwin":
        return Path.home() / ".bash_profile"
    elif shell == "Bash" and platform.system() == "Linux":
        return Path.home() / ".bashrc"
    elif shell == "Zsh":
        return Path.home() / ".zshrc"
    elif shell == "fish":
        return Path.home() / ".config" / "fish" / "config.fish"
    else:
        return Path.home()

def get_package_manager(system="Unknown") -> str:
    """システムに対応するパッケージマネージャーを返す"""
    if system == "Windows":
        return "winget"
    elif system == "Darwin":
        return "brew"
    elif system == "Linux":
        return "apt"
    else:
        return "Unknown"

@dataclass
class CommandRun():
    """コマンド実行の基底クラス"""
    dry_run:bool = True
    system:str = platform.system()
    shell:str = get_shell(system)
    shell_command:str = get_shell_command(shell)
    shell_file:str = get_shell_file(shell)
    command_timeout:int = 300

    def __post_init__(self):
        """初期化後の処理"""
        pass

    def creat_CommandList(self,file_path:Path) -> list[list[str]]:
        """
        コマンドファイルからコマンドリストを返す関数
        サブクラスでオーバーライドする
        """
        if file_path.suffix == ".txt":
            command = list()
            with file_path.open("r", encoding="utf-8") as f:
                for line in f.readlines():
                    if (line := txt_paser(line)) is None:
                        continue
                    command.append(self.creat_OneCommand(line))
                return command
        elif file_path.suffix == ".sh" or file_path.suffix == ".ps1":
            return [[self.shell_command, str(file_path)]]
        return list()

    def creat_OneCommand(self,line:str) -> list[str]:
        """
        一行のテキストからコマンドを作成する関数
        サブクラスでオーバーライドする
        """
        return line.split()

    def command_run(self,command:list) -> bool:
        """
        コマンドを実行する関数
        サブクラスでオーバーライドする
        """
        raise NotImplementedError("サブクラスで実装してください")

    def run(self):
        """
        メイン実行関数
        サブクラスでオーバーライドする
        """
        logger.debug(f"LOAD : {__name__}")
        raise NotImplementedError("サブクラスで実装してください")