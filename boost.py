import winreg
import subprocess
import ctypes
import sys
import time
import os
from colorama import init, Fore

subprocess.run(['pip', 'install', 'colorama'])
subprocess.run(['pip', 'install', 'keyboard'])
subprocess.run(['pip', 'install', 'winreg'])

init(autoreset=True)

def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False

if is_admin():
    print("")
else:
    ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 1)
    sys.exit()

eula_text = """
END-USER LICENSE AGREEMENT
IMPORTANT-READ CAREFULLY: This End-User License Agreement ("EULA") is a legal agreement between you (either an individual or a single entity) and [Your Company Name] for the software product(s) provided with this EULA, which may include associated software components, media, printed materials, and "online" or electronic documentation ("Software"). By installing, copying, or otherwise using the Software, you agree to be bound by the terms of this EULA. If you do not agree to the terms of this EULA, do not install or use the Software.
[Scuttlang </3 ]
"""

print(eula_text)

def update_progress_bar(completed, goal):
    progress = completed / goal
    bar_length = 70
    completed_blocks = int(bar_length * progress)
    remaining_blocks = bar_length - completed_blocks

    bar = Fore.GREEN + "🟦" * completed_blocks + Fore.RED + "🟥" * remaining_blocks + Fore.RESET

    percentage = int(progress * 100)
    progress_text = f"{bar}  {percentage}%"

    return progress_text

def simulate_progress():
    goal_value = 10

    for completed_value in range(goal_value + 1):
        os.system('cls' if os.name == 'nt' else 'clear')
        progress_bar = update_progress_bar(completed_value, goal_value)
        print(progress_bar)
        time.sleep(0.5)

    print("\nComplete!")


def modify_registry():
    key_path = r"SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching"
    value_name = "SearchOrderConfig"
    value_data = 0

    key_path = r"SYSTEM\CurrentControlSet\Control"
    value_name = "WaitToKillServiceTimeout"
    value_data = 2000  

    key_path = r"SYSTEM\CurrentControlSet\Control\Session Manager\Power"
    value_name = "HiberbootEnabled"
    value_data = 0    

    key_path = r"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
    value_name = "NetworkThrottlingIndex"
    value_data = 4294967295   
    value_name = "SystemResponsiveness"
    value_data = 0   

    key_path = r"SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"
    value_name = "autodisconnect"
    value_data = 4294967295   
    value_name = "Size"
    value_data = 1
    value_name = "EnableOplocks"
    value_data = 0
    value_name = "IRPStackSize"
    value_data = 32
    value_name = "SharingViolationDelay"
    value_data = 0
    value_name = "SharingViolationRetries"
    value_data = 0

    key_path = r"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
    value_name = "TcpAckFrequency"
    value_data = 0
    value_name = "TCPNoDelay" 
    value_data = 0

    key_path = r"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
    value_name = "GPU Priority"
    value_data = 8
    value_name = "Priority"
    value_data = 6
    value_name = "Scheduling Category"
    value_data = "High"
    value_name = "SFIO Priority"
    value_data = "High"

    key_path = r"SOFTWARE\Policies\Microsoft\Windows\Psched"
    value_name = "NonBestEffortLimit"
    value_data = 0

    key_path = r"SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
    value_name = "HwSchMode"
    value_data = 2

    #key_path = r"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
    #value_name = "TcpAckFrequency"
    #value_data = 1
    #value_name = "TCPNoDelay"
    #value_data = 1

    key_path = r"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
    value_name = "TCPDelAckTicks"
    value_data = 1
    value_name = "TCPNoDelay"
    value_data = 1
    value_name = "TcpAckFrequency"
    value_data = 1

    key_path = r"SOFTWARE\Microsoft\MSMQ\Parameters"
    value_name = "TCPNoDelay"
    value_data = 1

    key_path = r"SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider"
    value_name = "LocalPriority"
    value_data = 4
    value_name = "HostsPriority"
    value_data = 5
    value_name = "DnsPriority"
    value_data = 6
    value_name = "NetbtPriority"
    value_data = 7    

    key_path = r"SYSTEM\CurrentControlSet\services\LanmanServer\Parameters"
    value_name = "autodisconnect"
    value_data = 4294967295
    value_name = "Size"
    value_data = 3
    value_name = "EnableOplocks"
    value_data = 0
    value_name = "IRPStackSize"
    value_data = 32
    value_name = "EnableOplocks"
    value_data = 0
    value_name = "SharingViolationDelay"
    value_data = 0
    value_name = "SharingViolationRetries"
    value_data = 1

    key_path = r"SYSTEM\CurrentControlSet\Control\PriorityControl"
    value_name = "ConvertibleSlateMode"
    value_data = 0
    value_name = "Win32PrioritySeparation"
    value_data = 56

    try:
        key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, key_path, 0, winreg.KEY_SET_VALUE | winreg.KEY_WOW64_64KEY)
    except FileNotFoundError:
        key = winreg.CreateKey(winreg.HKEY_LOCAL_MACHINE, key_path)

    try:
        winreg.SetValueEx(key, value_name, 0, winreg.REG_DWORD, value_data)
        print("Registry key and DWORD value set successfully.")
    except Exception as e:
        print(f"Error setting registry DWORD value: {e}")
    finally:
        winreg.CloseKey(key)



def modify_registryS():
    key_path = r"System\GameConfigStore"
    value_name = "GameDVR_DXGIHonorFSEWindowsCompatible"
    value_data = 0
    value_name = "GameDVR_EFSEFeatureFlags"
    value_data = 0
    value_name = "GameDVR_Enable"
    value_data = 1
    value_name = "GameDVR_FSEBehaviorMode"
    value_data = 2
    value_name = "GameDVR_HonorUserFSEBehaviorMode"
    value_data = 0

    try:
        key = winreg.OpenKey(winreg.HKEY_CURRENT_USER, key_path, 0, winreg.KEY_SET_VALUE | winreg.KEY_WOW64_64KEY)
    except FileNotFoundError:
        key = winreg.CreateKey(winreg.HKEY_CURRENT_USER, key_path)

    try:
        winreg.SetValueEx(key, value_name, 0, winreg.REG_SZ, value_data)
        print("Registry key and String value set successfully.")
    except Exception as e:
        print(f"Error setting registry String value: {e}")
    finally:
        winreg.CloseKey(key)

def run_commands():
    commands = [
    'powercfg /duplicatescheme 3c0050b9-c741-431c-b155-869aefed4a28',
    'powercfg /setactive 3c0050b9-c741-431c-b155-869aefed4a28'
    'bcdedit -set disabledynamictick yes',
    'bcdedit -set useplatformtick yes',
    'defrag c: 0',
    'Stop-Process -Name explorer -Force',
    'Start-Process explorer',
    'Clear-DnsClientCache',
    'netsh int tcp set global autotuninglevel=disabled',
    'netsh winsock reset',
    'cd \\',
    '$adapterIndex = Get-NetAdapter | Select-Object -ExpandProperty InterfaceDescription -First 1 | Select-Object -Last 1',
    'Set-NetAdapterAdvancedProperty -InterfaceIndex $adapterIndex -DisplayName "Speed" -DisplayValue "1 Gbps"',
    'Remove-Item -Path *.log -Recurse -Force',
    'netsh int tcp show global',
    'netsh int tcp set global chimney=enabled',
    'netsh int tcp set heuristics disabled',
    'netsh int tcp set global autotuninglevel=normal',
    'netsh int tcp set global congestionprovider=ctcp',
    'netsh interface tcp set heuristics disabled',
    'Clear-DnsClientCache',
    'Install-Module -Name PSWindowsUpdate -Force',
    'Import-Module -Name PSWindowsUpdate',
    'Get-WindowsUpdate',
    'Install-WindowsUpdate -AcceptAll', 
    'Remove-Item -Path $env:TEMP -Recurse -Force',
    'New-Item -Path $env:TEMP -ItemType Directory',
    'takeown /f $env:TEMP -recurse -force',
    'takeown /f "C:\Windows\Temp" /r /d y',
    'Remove-Item -Path "C:\Windows\Temp" -Recurse -Force',
    'New-Item -Path "C:\Windows\Temp" -ItemType Directory',
    'takeown /f "C:\Windows\Temp" /r /d y',
    'takeown /f $env:TEMP -recurse -force',
    'cleanmgr',
    'sfc /scannow',
    'Dism /Online /Cleanup-Image /ScanHealth',
    'Dism /Online /Cleanup-Image /CheckHealth',
    'Repair-WindowsImage -Online -RestoreHealth',
    'Restart-Computer -Force'
]

    for command in commands:
        subprocess.run(['powershell', '-Command', command], shell=True)

if __name__ == "__main__":
    modify_registry()
    modify_registryS()
    run_commands()
    simulate_progress()
