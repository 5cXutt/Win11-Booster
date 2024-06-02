while ($true) {
    try {
        Stop-Process -Name explorer -Force
        Start-Process explorer.exe
    } catch {
        Write-Host "Errore: $_"
    }
}
