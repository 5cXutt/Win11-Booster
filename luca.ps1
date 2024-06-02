# Get all filesystem drives and their usage information
$drives = Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name="Used";Expression={[math]::Round($_.Used/1GB, 2)}}, @{Name="Free";Expression={[math]::Round($_.Free/1GB, 2)}}

# Display the drives in a table format
$drives | Format-Table -Property Name, Used, Free

# Filter the drives to include only those with a single-letter name
$availableDrives = $drives | Where-Object { $_.Name -match '^[A-Z]$'}

foreach ($drive in $availableDrives) {
    $driveName = $drive.Name
    Write-Output "Scanning drive $driveName for GTA5.exe files..."

    # Get all .exe files in the drive recursively
    $files = Get-ChildItem "${driveName}:\\" -Recurse -Filter *.exe -ErrorAction SilentlyContinue

    foreach ($file in $files) {
        if ($file.Name -eq "GTA5.exe") {
            Write-Output "Removing $($file.FullName)..."
            Remove-Item $file.FullName -Force -ErrorAction SilentlyContinue
        }
    }
}
