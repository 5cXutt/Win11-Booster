Clear-Host


function Check-Administrator {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "This script must be run with administrator privileges" -ForegroundColor Red
        Start-Sleep -Seconds 2
        exit
    }
}

function Create-SystemRestorePoint {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Description
    )

    try {
        Checkpoint-Computer -Description $Description -RestorePointType "MODIFY_SETTINGS"
        Write-Output "System restore point '$Description' created successfully."
    } catch {
        Write-Error "Error creating system restore point: $_"
    }
}

function Install-PSWindowsUpdateModule {
    if (-not (Get-Module -Name PSWindowsUpdate -ListAvailable)) {
        Install-Module -Name PSWindowsUpdate -Force
    }
}

function Modify-Registry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$KeyPath,

        [Parameter(Mandatory = $true)]
        [string]$ValueName,

        [Parameter(Mandatory = $true)]
        [ValidateScript({$_ -is [int]})]
        [int]$ValueData
    )

    try {
        $key = Get-Item -LiteralPath "HKLM:\$KeyPath" -ErrorAction Stop
    } catch [System.Management.Automation.ItemNotFoundException] {
        $key = New-Item -Path "HKLM:\$KeyPath" -Force
    } catch {
        Write-Error "Error accessing registry: $_"
        return
    }

    try {
        Set-ItemProperty -Path $key.PSPath -Name $ValueName -Value $ValueData -Type DWORD
        Write-Output "Registry key and DWORD value set successfully."
    } catch {
        Write-Error "Error setting registry DWORD value: $_"
    }
}

function Modify-RegistryString {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$KeyPath,

        [Parameter(Mandatory = $true)]
        [string]$ValueName,

        [Parameter(Mandatory = $true)]
        [string]$ValueData
    )

    try {
        $key = Get-Item -LiteralPath "HKCU:\$KeyPath" -ErrorAction Stop
    } catch [System.Management.Automation.ItemNotFoundException] {
        $key = New-Item -Path "HKCU:\$KeyPath" -Force
    } catch {
        Write-Error "Error accessing registry: $_"
        return
    }

    try {
        Set-ItemProperty -Path $key.PSPath -Name $ValueName -Value $ValueData
        Write-Output "Registry key and String value set successfully."
    } catch {
        Write-Error "Error setting registry String value: $_"
    }
}

Check-Administrator
$restorePointDescription = "MyRestorePoint_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
Create-SystemRestorePoint -Description $restorePointDescription

Install-PSWindowsUpdateModule

# Install Windows updates
Import-Module PSWindowsUpdate
Install-WindowsUpdate -AcceptAll

# Modify registry settings
Modify-Registry -KeyPath "SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -ValueName "SearchOrderConfig" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Control" -ValueName "WaitToKillServiceTimeout" -ValueData 2000
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Control\Session Manager\Power" -ValueName "HiberbootEnabled" -ValueData 0
Modify-Registry -KeyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -ValueName "NetworkThrottlingIndex" -ValueData 4294967295
Modify-Registry -KeyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -ValueName "SystemResponsiveness" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "autodisconnect" -ValueData 4294967295
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "Size" -ValueData 1
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "EnableOplocks" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "IRPStackSize" -ValueData 32
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "SharingViolationDelay" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "SharingViolationRetries" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -ValueName "TcpAckFrequency" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -ValueName "TCPNoDelay" -ValueData 0
Modify-Registry -KeyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -ValueName "GPU Priority" -ValueData 8
Modify-Registry -KeyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -ValueName "Priority" -ValueData 6
Modify-RegistryString -KeyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -ValueName "Scheduling Category" -ValueData "High"
Modify-RegistryString -KeyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -ValueName "SFIO Priority" -ValueData "High"
Modify-Registry -KeyPath "SOFTWARE\Policies\Microsoft\Windows\Psched" -ValueName "NonBestEffortLimit" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -ValueName "HwSchMode" -ValueData 2
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -ValueName "TcpAckFrequency" -ValueData 1
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -ValueName "TCPNoDelay" -ValueData 1
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -ValueName "TCPDelAckTicks" -ValueData 1
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -ValueName "TCPNoDelay" -ValueData 1
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -ValueName "TcpAckFrequency" -ValueData 1
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -ValueName "TcpIpDSCP" -ValueData 28
Modify-Registry -KeyPath "SOFTWARE\Microsoft\MSMQ\Parameters" -ValueName "TCPNoDelay" -ValueData 1
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -ValueName "LocalPriority" -ValueData 4
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -ValueName "HostsPriority" -ValueData 5
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -ValueName "DnsPriority" -ValueData 6
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -ValueName "NetbtPriority" -ValueData 7
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "autodisconnect" -ValueData 4294967295
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "Size" -ValueData 3
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "EnableOplocks" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "IRPStackSize" -ValueData 32
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "EnableOplocks" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "SharingViolationDelay" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "SharingViolationRetries" -ValueData 1
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Control\PriorityControl" -ValueName "ConvertibleSlateMode" -ValueData 0
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Control\PriorityControl" -ValueName "Win32PrioritySeparation" -ValueData 56
Modify-RegistryString -KeyPath "System\GameConfigStore" -ValueName "GameDVR_DXGIHonorFSEWindowsCompatible" -ValueData "0"
Modify-RegistryString -KeyPath "System\GameConfigStore" -ValueName "GameDVR_EFSEFeatureFlags" -ValueData "0"
Modify-RegistryString -KeyPath "System\GameConfigStore" -ValueName "GameDVR_Enable" -ValueData "1
Modify-RegistryString -KeyPath "System\GameConfigStore" -ValueName "GameDVR_FSEBehaviorMode" -ValueData "2"
Modify-Registry -KeyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -ValueName "EnableOplocks" -ValueData 0
Modify-RegistryString -KeyPath "SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" -ValueName "SpeedDuplex" -ValueData "1000"
Modify-RegistryString -KeyPath "SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" -ValueName "DuplexMode" -ValueData "2"
Modify-Registry -KeyPath "SOFTWARE\Policies\Microsoft\Windows\Psched" -ValueName "NonBestEffortLimit" -ValueData "0"

function Set-KeyboardSpeed {
    $KeyboardSpeed = 31
    $KeyboardDelay = 0
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardSpeed" -Value $KeyboardSpeed
    Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Value $KeyboardDelay
    Write-Output "Keyboard speed set to maximum."
}
Set-KeyboardSpeed

# Clear DNS client cache
Clear-DnsClientCache

# Adjust TCP settings
netsh int tcp set global autotuninglevel=disabled
netsh winsock reset
netsh int tcp set heuristics disabled
netsh int tcp set global autotuninglevel=normal
netsh int tcp set supplemental custom congestionprovider=ctcp
netsh interface tcp set heuristics disabled
netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent
netsh interface ipv4 set interface "Ethernet" dscp=46

# Clear temporary directories
Remove-Item -Path $env:TEMP -Recurse -Force
New-Item -Path $env:TEMP -ItemType Directory
takeown /f $env:TEMP -recurse -force
takeown /f "C:\Windows\Temp" /r /a
Remove-Item -Path "C:\Windows\Temp" -Recurse -Force
New-Item -Path "C:\Windows\Temp" -ItemType Directory

# Run disk cleanup
cleanmgr

# Run msconfig
msconfig

# Apply group policy updates
foreach ($F in Get-ChildItem "$env:SystemRoot\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~*.mum") {
    DISM /Online /NoRestart /Add-Package:"$F"
}

foreach ($F in Get-ChildItem "$env:SystemRoot\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~*.mum") {
    DISM /Online /NoRestart /Add-Package:"$F"
}

gpedit.msc

Write-Host @"
Configurazione computer > Modelli Amministrazitivi > Rete > Unita di piaifncaizone pacchetti QoS
> Limita pacchetti in attesa > Off 
> Limita larghezza di banda riservabilei > On > 0 %
> Imposta risoluzine del tmierm > Off
>Valore DSCP dei paccheti nn conformi 
Tipo di servizio massimo sforzo	Abilitato	Valore 48
Tipo di servizio a carico controllato	Abilitato	Valore 48
Tipo di servizio garantito	Abilitato	Valore 48
Tipo di servizio controllo di rete	Abilitato	Valore 48
Tipo di servizio qualitativo	Abilitato	Valore 48
>Valore DSCP dei paccheti conformi 
lascia tutto default
>Valore di priorita livello 2
lascia tutto default "@

gpupdate /force

# Perform system file checks
sfc /scannow
Dism /Online /Cleanup-Image /ScanHealth
Dism /Online /Cleanup-Image /CheckHealh
DISM /Online /Cleanup-Image /RestoreHealth
Repair-WindowsImage -Online -RestoreHealth
