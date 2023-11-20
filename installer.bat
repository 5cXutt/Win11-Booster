@echo off
cls
color c
echo "[+] Create a Restore Point"
powershell -NoExit -Command "& {Checkpoint-Computer -Description Booster}"

echo "[+] Create a directory on path C:\Users\Booster"
mkdir C:\Users\Booster
if %errorlevel% neq 0 (
    echo "[!] Failed to create directory. Press Enter to exit."
    pause
    exit /b %errorlevel%
)
echo "[+] Directory Created. Press Enter to continue."
pause

echo "[+] Checking if Python is installed"
python --version >nul 2>&1
if %errorlevel% eq 0 (
    echo "[+] Python is already installed. Skipping installation."
) else (
    echo "[+] Install Prerequisite for Python"
    powershell -NoExit -Command "& {Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe' -OutFile 'C:\Users\Booster\py.exe' ; Start-Process -FilePath 'C:\Users\Booster\py.exe' -Wait}"
    if %errorlevel% neq 0 (
        echo "[!] Failed to install Python. Press Enter to exit."
        pause
        exit /b %errorlevel%
    )
    echo "[+] Python Installed."
)
echo "[+] Install Dependece us pip "
pip install keyboard 
pip install winreg 
pip install colorama
echo "[+] Running booster script"
python C:\Users\Booster\booster.py
if %errorlevel% neq 0 (
    echo "[!] Failed to run booster script. Press Enter to exit."
    pause
    exit /b %errorlevel%
)
echo "[+] Press Enter to exit."
pause
