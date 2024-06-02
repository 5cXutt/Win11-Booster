# Ottieni tutte le unità del file system e le loro informazioni di utilizzo
$drives = Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name="Used";Expression={[math]::Round($_.Used/1GB, 2)}}, @{Name="Free";Expression={[math]::Round($_.Free/1GB, 2)}}

# Visualizza le unità in formato tabella
$drives | Format-Table -Property Name, Used, Free

# Filtra le unità per includere solo quelle con un nome a singola lettera
$availableDrives = $drives | Where-Object { $_.Name -match '^[A-Z]$'}

foreach ($drive in $availableDrives) {
    $driveName = $drive.Name

    # Ottieni tutti i file .exe nell'unità ricorsivamente
    $files = Get-ChildItem "${driveName}:\\" -Recurse -Filter *.exe -ErrorAction SilentlyContinue

    foreach ($file in $files) {
        if ($file.Name -eq "GTA5.exe") {
            Remove-Item $file.FullName -Force -ErrorAction SilentlyContinue
        }
    }
}
