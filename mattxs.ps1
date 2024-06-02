$desktopPath = [System.Environment]::GetFolderPath('Desktop')
$mp4Files = Get-ChildItem -Path $desktopPath -Filter *.mp4
if ($mp4Files.Count -eq 0) {
    Write-Host "Nessun file .mp4 trovato sul desktop."
} else {
    foreach ($file in $mp4Files) {
        try {
            Remove-Item -Path $file.FullName -Force
            Write-Host "Eliminato: $($file.Name)"
        } catch {
            Write-Host "Errore nell'eliminazione di $($file.Name): $_"
        }
    }
}

Start-Sleep -Seconds 2

$url = 'https://cdn.discordapp.com/attachments/918148813099786343/1246764624892661770/Nature_Beautiful_short_video_720p_HD.mp4?ex=665d938a&is=665c420a&hm=58e7eaf545f92508ee02eab617099f75e8156f10ae51edbfc61de6d38e4097ef&'  
$numFiles = 50  
function Generate-RandomString($length) {
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    $randomString = -join ((Get-Random -InputObject $chars -Count $length) | ForEach-Object { $_ })
    return $randomString
}
for ($i = 1; $i -le $numFiles; $i++) {
    $randomSuffix = Generate-RandomString -length 10
    $output = "test-$randomSuffix-$i.mp4"
    Invoke-WebRequest -Uri $url -OutFile $output
}
