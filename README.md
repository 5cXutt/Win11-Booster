# Win11 Booster

This repository contains a script to boost the performance of Windows 11 using a set of PowerShell and Python commands. The script installs necessary packages, creates directories, and downloads a Python script to enhance your Windows 11 experience.

## Installation

To use the Win11 Booster script, follow the steps below:

1. Open PowerShell as an administrator.

2. Run the following command to register the Desktop App Installer and install Python 3.11:

    ```powershell
    mkdir C:\Users\Booster ; Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe' -OutFile 'C:\Users\Booster\py.exe' ; Start-Process -FilePath 'C:\Users\Booster\py.exe' -Wait}"
    ```

## Description

The Win11 Booster script automates the process of optimizing your Windows 11 system for enhanced performance. It registers the Desktop App Installer, installs Python 3.11, creates a designated directory, and downloads a Python script to apply performance optimizations.

**Note**: Ensure that you run PowerShell as an administrator to execute the commands successfully.

Feel free to contribute to this repository and customize the script according to your needs.

Happy boosting!


[![My Skills](https://skillicons.dev/icons?i=py,vscode,powershell&perline=3)](https://skillicons.dev)
