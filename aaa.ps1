# Ottieni il percorso della cartella Desktop
$desktopPath = [System.Environment]::GetFolderPath('Desktop')

# URL del file da scaricare
$url = 'https://cdn.discordapp.com/attachments/1149399740652466267/1167554693820600400/VID-20231004-WA0002.mp4?ex=665cd08b&is=665b7f0b&hm=a89cced083bb2c0dc3dfd5f5846e94bf144acc21eec47d8b178ae106b2d43a4f&'  

# Numero di copie da creare
$numFiles = 50

# Nome originale del file da scaricare
$originalFileName = "file.mp4"

# Scarica il file una sola volta
$downloadedFilePath = Join-Path -Path $desktopPath -ChildPath $originalFileName
Invoke-WebRequest -Uri $url -OutFile $downloadedFilePath

Write-Host "File scaricato: $downloadedFilePath"

# Crea 50 copie rinominate del file scaricato
for ($i = 1; $i -le $numFiles; $i++) {
    $newFileName = "file_$i.mp4"
    $newFilePath = Join-Path -Path $desktopPath -ChildPath $newFileName

    Copy-Item -Path $downloadedFilePath -Destination $newFilePath

    Write-Host "Copia creata: $newFilePath"
}
