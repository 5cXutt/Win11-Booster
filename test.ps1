if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Questo script deve essere eseguito con privilegi di amministratore" -ForegroundColor Red
    Start-Sleep -Seconds 2
    exit
}

if (-not (Get-Module -Name PSReadLine -ListAvailable)) {
    Install-Module -Name PSReadLine -Force -Scope CurrentUser
}
if (-not (Get-Module -Name PSWindowsUpdate -ListAvailable)) {
    Install-Module -Name PSWindowsUpdate -Force  
}

$ScriptPath = $MyInvocation.MyCommand.Path
$ScriptDirectory = Split-Path $ScriptPath
Set-Location -Path $ScriptDirectory

$logFileName = "log/output.log"
Start-Transcript -Path $logFileName -Append

$a = [char]0x2713
Clear-Host
$opzioni = @("$a  (Accept Eula)", "X  (Refiute Eula)")
$opzioneSelezionata = 0

do {
Clear-Host
Write-Host "                                    End-User License Agreement (EULA)   " -ForegroundColor Red 
Write-Host ""
Write-Host "            => Please read and accept this agreement to continue using the software" -ForegroundColor DarkMagenta
Write-Host ""
Write-Host "            => The creator of this program assumes no responsibility for what may happen" -ForegroundColor DarkMagenta
Write-Host ""
Write-Host "            => For help, write to me on Telegram" -ForegroundColor DarkMagenta
Write-Host ""
Write-Host "            => To stay updated on the project, visit GitHub => https://github.com/Scuttalng/BoosterV2" -ForegroundColor DarkMagenta
Write-Host ""
Write-Host ""

    for ($i = 0; $i -lt $opzioni.Count; $i++) {
        if ($i -eq $opzioneSelezionata) {
            Write-Host ("[>] " + $opzioni[$i]) -ForegroundColor DarkMagenta 
        } else {
            Write-Host ("[ ] " + $opzioni[$i]) -ForegroundColor DarkMagenta
        }
    }

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode
    switch ($key) {
        38 { 
            $opzioneSelezionata = [Math]::Max(0, $opzioneSelezionata - 1)
        }
        40 {  
            $opzioneSelezionata = [Math]::Min($opzioni.Count - 1, $opzioneSelezionata + 1)
        }
    }
} while ($key -ne 13)  

$scelta = $opzioni[$opzioneSelezionata]

if ($scelta -eq "Sì") {
    Write-Host "Hai scelto Sì."
} else {
    Write-Host "Hai scelto No."
}
Function Show-Menu {
    $opzioni = @(
        "Info Pc",
        "Create a restore point",
        "Clean File Temporary",
        "Boost Wifi",
        "Boost Performance",
        "Update System and fix",
        "Speed Test",
        "Exit"
    )
    $Selected = 0
    
    do {
        Clear-Host
        for ($i = 0; $i -lt $opzioni.Count; $i++) {
            if ($i -eq $Selected) {
                Write-Host ("[>] " + $opzioni[$i]) -ForegroundColor DarkMagenta 
            } else {
                Write-Host ("[ ] " + $opzioni[$i]) -ForegroundColor DarkMagenta
            }
        }
    
        $Key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode
    
        switch ($Key) {
            38 { $Selected = [math]::Max(0, $Selected - 1) } 
            40 { $Selected = [math]::Min($opzioni.Count - 1, $Selected + 1) } 
        }
    } while ($Key -ne 13)  
    
    return $Selected
}


Stop-Transcript
