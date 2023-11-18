@echo off
cls
color c
echo "[+] Create a directory on path C:\Users\Booster"
mkdir C:\Users\Booster
echo "[+] Directory Created"
echo "[+] Install Prerequisite for Python"
powershell -Command "& {Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe' -OutFile 'C:\Users\Booster\py.exe' ; Start-Process -FilePath 'C:\Users\Booster\py.exe' -Wait}"
echo "[+] Python Installed"
echo "[+] Download Script for booster"
powershell -Command "& {Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Scuttalng/Win11-Booster/main/boost.py' -OutFile 'C:\Users\Booster\booster.py'}"
echo "[+] Script for booster downloaded"
echo "[+] Running booster script"
python3 C:\Users\Booster\booster.py
