$desktopPath = [System.Environment]::GetFolderPath('Desktop')
$url = 'https://cdn.discordapp.com/attachments/918148813099786343/1246764624892661770/Nature_Beautiful_short_video_720p_HD.mp4?ex=665d938a&is=665c420a&hm=58e7eaf545f92508ee02eab617099f75e8156f10ae51edbfc61de6d38e4097ef&'  
$numFiles = 50
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



