# Powershell Script for Vagrant to install and configure DHCP
# @davidstamen
# http://davidstamen.com

# Wait 30 seconds
timeout /t 30

# Install the DHCP Role
Install-WindowsFeature DHCP -IncludeAllSubFeature -IncludeManagementTools

# Authorize the DHCP server in Active Directory
$server = hostname
Add-DhcpServerInDC -DnsName $server -IPAddress 10.10.10.10

# Create an IPv4 DHCP scope
Add-DhcpServerv4Scope -Name 10.10.10.X -StartRange 10.10.10.50 -EndRange 10.10.10.250 -SubnetMask 255.255.255.0

# Set the DNS server to use for all clients to use on the DHCP server
Set-DhcpServerv4OptionValue -DnsDomain lab.local -DnsServer 10.10.10.10
Set-DhcpServerv4Scope -ScopeId 10.10.10.0 -LeaseDuration 1.00:00:00
