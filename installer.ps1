Clear-Host

Write-Host "[+] Create a directory on path C:\Users\Booster"
New-Item -ItemType Directory -Path C:\Users\Booster -ErrorAction SilentlyContinue
if ($?) {
    Write-Host "[+] Directory Created. Press Enter to continue."
    Read-Host
} else {
    Write-Host "[!] Failed to create directory. Press Enter to exit."
    Read-Host
    exit
}

Write-Host "[+] Checking if Python is installed"

$pythonVersion = $(python --version 2>&1)
if ($LASTEXITCODE -eq 0) {
    Write-Host "[+] Python is already installed. Skipping installation."
} else {
    Write-Host "[+] Install Prerequisite for Python"
    Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe' -OutFile 'C:\Users\Booster\py.exe'
    Start-Process -FilePath 'C:\Users\Booster\py.exe' -Wait
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[!] Failed to install Python. Press Enter to exit."
        Read-Host
        exit
    }
    Write-Host "[+] Python Installed."
}

Write-Host "[+] Install Dependencies using pip"
pip install keyboard, winreg, colorama

Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Scuttlang/Win11-Booster/main/boost.py' -OutFile 'C:\Users\Booster\booster.py'

Write-Host "[+] Running booster script"
python C:\Users\Booster\booster.py 
if ($LASTEXITCODE -ne 0) {
    Write-Host "[!] Failed to run booster script. Press Enter to exit."
    Read-Host
    exit
}
Write-Host "[+] Press Enter to exit."
Read-Host
