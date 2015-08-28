echo ## Install the DHCP Role
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Install-WindowsFeature DHCP -IncludeAllSubFeature -IncludeManagementTools"

echo ## Authorize the DHCP server in Active Directory
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-DhcpServerInDC -DnsName dc01.lab.local -IPAddress 10.10.10.10"

echo ## Create an IPv4 DHCP scope
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-DhcpServerv4Scope -Name 10.10.20.x -StartRange 10.10.20.10 -EndRange 10.10.20.250 -SubnetMask 255.255.255.0"

echo ## Set the DNS server to use for all clients to use on the DHCP server
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-DhcpServerv4OptionValue -DnsDomain lab.local -DnsServer 10.10.10.10"
