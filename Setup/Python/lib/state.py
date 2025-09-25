"""
State machine
"""
from dataclasses import dataclass
from lib import common
import platform

@dataclass
class State_System:
    base_system = platform.system()
    system:str = common.get_system()
    shell:str = common.get_shell(base_system)
    shell_command:str = common.get_shell_command(shell)
    shell_file:str = common.get_shell_file(shell)

@dataclass
class State_Run:
    dry_run:bool = True