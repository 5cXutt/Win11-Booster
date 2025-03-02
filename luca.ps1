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
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Transmit Buffers" -DisplayValue 2048
netsh interface tcp set global congestionprovider=ctcp
New-NetRoute -DestinationPrefix "0.0.0.0/0" -InterfaceAlias "Ethernet" -NextHop "192.168.1.1" -RouteMetric 10
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "TCP Segmentation Offload v2 (IPv4)" -DisplayValue "Enabled"
Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False
Set-NetAdapterAdvancedProperty -Name "Ethernet" -DisplayName "Receive Buffers" -DisplayValue 2048
Set-NetIPInterface -InterfaceAlias "Ethernet" -NlMtu 1500
netsh interface tcp set global rss=enabled
New-NetQosPolicy -Name "VoIP" -AppPath "C:\Program Files\Skype\Skype.exe" -Priority 5
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL' -Name "Enabled" -Value 1
Set-NetIPInterface -InterfaceAlias "Ethernet" -CompressionEnabled $true
Get-NetAdapterStatistics -Name "Ethernet"
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("1.1.1.1", "1.0.0.1")
netsh interface tcp set global initrwnd=16384
netstat -an | Select-String "ESTABLISHED"
