cls
color c
echo "[+] Create a directory on path C:\Users\Booster"
mkdir C:\Users\Booster
if %errorlevel% neq 0 (
    echo "[!] Failed to create directory. Press Enter to exit."
    pause
    exit /b %errorlevel%
)
echo "[+] Directory Created. Press Enter to continue."
pause

echo "[+] Install Prerequisite for Python"
powershell -NoExit -Command "& {Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe' -OutFile 'C:\Users\Booster\py.exe' ; Start-Process -FilePath 'C:\Users\Booster\py.exe' -Wait}"
if %errorlevel% neq 0 (
    echo "[!] Failed to install Python. Press Enter to exit."
    pause
    exit /b %errorlevel%
)
echo "[+] Python Installed. Press Enter to continue."
pause

echo "[+] Running booster script"
python C:\Users\Booster\booster.py
if %errorlevel% neq 0 (
    echo "[!] Failed to run booster script. Press Enter to exit."
    pause
    exit /b %errorlevel%
)
echo "[+] Press Enter to exit."
pause
