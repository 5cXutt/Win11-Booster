Clear-Host
function Check-Administrator {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "This script must be run with administrator privileges" -ForegroundColor Red
        Start-Sleep -Seconds 2
        exit
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
Import-Module PSWindowsUpdate
Install-WindowsUpdate -AcceptAll
Modify-Registry -keyPath "SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -valueName "SearchOrderConfig" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Control" -valueName "WaitToKillServiceTimeout" -valueData 2000
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Control\Session Manager\Power" -valueName "HiberbootEnabled" -valueData 0
Modify-Registry -keyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -valueName "NetworkThrottlingIndex" -valueData 4294967295
Modify-Registry -keyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -valueName "SystemResponsiveness" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -valueName "autodisconnect" -valueData 4294967295
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -valueName "Size" -valueData 1
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -valueName "EnableOplocks" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -valueName "IRPStackSize" -valueData 32
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -valueName "SharingViolationDelay" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -valueName "SharingViolationRetries" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -valueName "TcpAckFrequency" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -valueName "TCPNoDelay" -valueData 0
Modify-Registry -keyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -valueName "GPU Priority" -valueData 8
Modify-Registry -keyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -valueName "Priority" -valueData 6
Modify-RegistryString -keyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -valueName "Scheduling Category" -valueData "High"
Modify-RegistryString -keyPath "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -valueName "SFIO Priority" -valueData "High"
Modify-Registry -keyPath "SOFTWARE\Policies\Microsoft\Windows\Psched" -valueName "NonBestEffortLimit" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -valueName "HwSchMode" -valueData 2
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -valueName "TcpAckFrequency" -valueData 1
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -valueName "TCPNoDelay" -valueData 1
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -valueName "TCPDelAckTicks" -valueData 1
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -valueName "TCPNoDelay" -valueData 1
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -valueName "TcpAckFrequency" -valueData 1
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -valueName "TcpIpDSCP" -valueData 28
Modify-Registry -keyPath "SOFTWARE\Microsoft\MSMQ\Parameters" -valueName "TCPNoDelay" -valueData 1
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -valueName "LocalPriority" -valueData 4
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -valueName "HostsPriority" -valueData 5
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -valueName "DnsPriority" -valueData 6
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -valueName "NetbtPriority" -valueData 7
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" -valueName "autodisconnect" -valueData 4294967295
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" -valueName "Size" -valueData 3
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" -valueName "EnableOplocks" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" -valueName "IRPStackSize" -valueData 32
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" -valueName "EnableOplocks" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" -valueName "SharingViolationDelay" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" -valueName "SharingViolationRetries" -valueData 1
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Control\PriorityControl" -valueName "ConvertibleSlateMode" -valueData 0
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\Control\PriorityControl" -valueName "Win32PrioritySeparation" -valueData 56
Modify-RegistryString -keyPath "System\GameConfigStore" -valueName "GameDVR_DXGIHonorFSEWindowsCompatible" -valueData "0"
Modify-RegistryString -keyPath "System\GameConfigStore" -valueName "GameDVR_EFSEFeatureFlags" -valueData "0"
Modify-RegistryString -keyPath "System\GameConfigStore" -valueName "GameDVR_Enable" -valueData "1"
Modify-RegistryString -keyPath "System\GameConfigStore" -valueName "GameDVR_FSEBehaviorMode" -valueData "2"
Modify-Registry -keyPath "SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" -valueName "EnableOplocks" -valueData 0
Modify-RegistryString -keyPath "SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" -valueName "SpeedDuplex" -valueData "100"
Modify-RegistryString -keyPath "SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" -valueName "DuplexMode" -valueData "2"
Modify-Registry -keyPath "SOFTWARE\Policies\Microsoft\Windows\Psched" -valueName "NonBestEffortLimit" -valueData "0"
Clear-DnsClientCache
netsh int tcp set global autotuninglevel=disabled
netsh winsock reset
netsh int tcp set heuristics disabled
netsh int tcp set global autotuninglevel=normal
netsh int tcp set supplemental custom congestionprovider=ctcp
netsh interface tcp set heuristics disabled
netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent
netsh interface ipv4 set interface "Ethernet" dscp=46
Clear-DnsClientCache
Remove-Item -Path $env:TEMP -Recurse -Force
New-Item -Path $env:TEMP -ItemType Directory
takeown /f $env:TEMP -recurse -force
takeown /f "C:\Windows\Temp" /r /a
Remove-Item -Path "C:\Windows\Temp" -Recurse -Force
New-Item -Path "C:\Windows\Temp" -ItemType Directory
cleanmgr
msconfig

foreach ($F in Get-ChildItem "$env:SystemRoot\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~*.mum") {
    DISM /Online /NoRestart /Add-Package:"$F"
}

foreach ($F in Get-ChildItem "$env:SystemRoot\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~*.mum") {
    DISM /Online /NoRestart /Add-Package:"$F"
}
Write-Host("
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
lascia tutto default ")

gpedit.msc

gpupdate /force
sfc /scannow
Dism /Online /Cleanup-Image /ScanHealth
Dism /Online /Cleanup-Image /CheckHealh
Repair-WindowsImage -Online -RestoreHealth
