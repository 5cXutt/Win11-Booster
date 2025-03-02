Set-NetTCPSetting -SettingName "InternetCustom" -ReceiveWindow 65536
Set-NetTCPSetting -SettingName "InternetCustom" -WindowScalingEnabled $true
Set-NetTCPSetting -SettingName "InternetCustom" -DelayedAckEnabled $true
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("8.8.8.8", "8.8.4.4")
Get-NetAdapterAdvancedProperty -Name "Ethernet" | Where-Object {$_.DisplayName -eq "Large Send Offload v2 (IPv4)"} | Set-NetAdapterAdvancedProperty -DisplayName "Large Send Offload v2 (IPv4)" -DisplayValue "Disabled"
netsh interface tcp set global autotuninglevel=disabled
Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_tcpip6
Set-NetTCPSetting -SettingName "InternetCustom" -MaxConnectionsPer1_0Server 1000
Clear-DnsClientCache
Set-NetTCPSetting -SettingName "InternetCustom" -EnableFastOpen $true
Set-NetTCPSetting -SettingName "InternetCustom" -TcpTimedWaitDelay 30
Get-NetAdapterAdvancedProperty -Name "Ethernet" | Where-Object {$_.DisplayName -eq "Large Receive Offload v2 (IPv4)"} | Set-NetAdapterAdvancedProperty -DisplayName "Large Receive Offload v2 (IPv4)" -DisplayValue "Disabled"
Set-NetIPInterface -InterfaceAlias "Ethernet" -Ipv4PathMTUDiscovery $true
Set-NetIPInterface -InterfaceAlias "Ethernet" -InterfaceMetric 10
Set-NetIPInterface -InterfaceAlias "Ethernet" -AddressFamily IPv4 -InterfaceMetric 10
Set-NetIPInterface -InterfaceAlias "Ethernet" -AddressFamily IPv6 -InterfaceMetric 50
Set-NetAdapterRss -Name "Ethernet" -Enabled $true
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "TCP Checksum Offload (IPv4)" -DisplayValue "Enabled"
netstat -an | Select-String "ESTABLISHED"
