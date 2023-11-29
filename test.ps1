Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window" Title="Fortnite Loader" Height="400" Width="600">
    <Grid>
        <TextBlock x:Name="txtWelcome" Text="Welcome to Fortnite Loader!" HorizontalAlignment="Center" VerticalAlignment="Center" FontSize="24" />
        <Button x:Name="btnStart" Content="Start" HorizontalAlignment="Center" VerticalAlignment="Bottom" Margin="0,0,0,20" />
        <CheckBox x:Name="chkBox" Content="Auto Update" HorizontalAlignment="Center" VerticalAlignment="Bottom" Margin="0,0,0,60" />
    </Grid>
</Window>
"@
$window = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $xaml))

$btnStart = $window.FindName("btnStart")
$chkBox = $window.FindName("chkBox")

$btnStart.Add_Click({
    Write-Host "Start button clicked!"
})
$chkBox.Add_Checked({
})

$chkBox.Add_Unchecked({
})

$window.ShowDialog() | Out-Null
