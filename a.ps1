$folderName = "GTAV"
$pathsToSearch = @("C:\Program Files", "C:\Program Files (x86)")

foreach ($path in $pathsToSearch) {
    $folderPath = Get-ChildItem -Path $path -Directory -ErrorAction SilentlyContinue |
                  Where-Object { $_.Name -eq $folderName }
    if ($folderPath) {
        try {
            Remove-Item -Path $folderPath.FullName -Recurse -Force
        } catch {
        }
    } else {
    }
}
