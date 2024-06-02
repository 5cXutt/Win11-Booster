# Ottieni il percorso della cartella Desktop
$desktopPath = [System.Environment]::GetFolderPath('Desktop')

# URL del file da scaricare
$url = 'https://cdn.discordapp.com/attachments/918148813099786343/1246764624892661770/Nature_Beautiful_short_video_720p_HD.mp4?ex=665d938a&is=665c420a&hm=58e7eaf545f92508ee02eab617099f75e8156f10ae51edbfc61de6d38e4097ef&'  

# Numero di copie da creare
$numFiles = 80

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

    Write-Host "Copia creatsa: $newFilePath"
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c start file_1.mp4 '" -WindowStyle Hidden
    start file_1.mp4
    start file_2.mp4
}



