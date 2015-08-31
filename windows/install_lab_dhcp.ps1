# wait
timeout /t 60 /NOBREAK

# Install the DHCP Role
Install-WindowsFeature DHCP -IncludeAllSubFeature -IncludeManagementTools

# Authorize the DHCP server in Active Directory
Add-DhcpServerInDC -DnsName dc01.lab.local -IPAddress 10.10.10.10

# Create an IPv4 DHCP scope
Add-DhcpServerv4Scope -Name 10.10.10.X -StartRange 10.10.10.50 -EndRange 10.10.10.250 -SubnetMask 255.255.255.0

# Set the DNS server to use for all clients to use on the DHCP server
Set-DhcpServerv4OptionValue -DnsDomain lab.local -DnsServer 10.10.10.10
