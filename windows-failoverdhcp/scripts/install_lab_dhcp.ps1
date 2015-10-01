# Powershell Script for Vagrant to install and configure DHCP
# @davidstamen
# http://davidstamen.com

$server1 = "10.10.10.10"
$server2 = "10.10.10.11"
$username = "vagrant"
$password = "vagrant"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr

# Install the DHCP Role
Install-WindowsFeature DHCP -IncludeAllSubFeature -IncludeManagementTools -Computer $server1 -Credential $cred
Install-WindowsFeature DHCP -IncludeAllSubFeature -IncludeManagementTools -Computer $server2 -Credential $cred

# Authorize the DHCP server in Active Directory
#$server = hostname
#Add-DhcpServerInDC -DnsName $server -IPAddress $server1

# Create an IPv4 DHCP scope
Write-Host "Adding DHCP Scopes" -ForegroundColor "Yellow"
Add-DhcpServerv4Scope -ComputerName $server1 -Name "10.10.10.X" -StartRange 10.10.10.20 -EndRange 10.10.10.254 -SubnetMask 255.255.255.0

# Set the DNS server to use for all clients to use on the DHCP server
Write-Host "Setting DHCP Scope Options" -ForegroundColor "Yellow"
Set-DhcpServerv4OptionValue -ComputerName $server1 -ScopeId 10.10.10.0 -DnsDomain lab.local
Set-DhcpServerv4Scope -ComputerName $server1 -ScopeId 10.10.10.0 -LeaseDuration 1.00:00:00

# Configure Failover
Write-Host "Configuring DHCP Failover" -ForegroundColor "Yellow"
Add-DhcpServerv4Failover -ComputerName $server1 -Name 'DHCP-Failover' -PartnerServer $server2 -ScopeId 10.10.10.0 -LoadBalancePercent 50 -MaxClientLeadTime 2:00:00 -AutoStateTransition $true -StateSwitchInterval 2:00:00

#Create MAC Allow List DHCP policy
Write-Host "Creating MAC Allow List Policy" -ForegroundColor "Yellow"
$scope = Get-DhcpServerv4Scope 10.10.10.0
Add-DhcpServerv4Policy -ComputerName $server1 -Name "MAC Allow List" -Description "Only MAC's listed in this policy will be issues IP addresses" -ScopeId $scope.scopeid -Condition OR -MacAddress EQ,08*,00*
Add-DhcpServerv4PolicyIPRange -ComputerName $server1 -Name "MAC Allow List" -ScopeId $scope.scopeid -StartRange $scope.StartRange -EndRange $scope.EndRange

#Reserve IP's
Write-Host "Reserving DHCP IPs" -ForegroundColor "Yellow"
Add-DhcpServerv4Reservation -ComputerName $server1 -ScopeId 10.10.10.0 -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $server1 -ScopeId 10.10.10.0) -ClientId 00-00-00-00-00-00 -Name "Node01"
Add-DhcpServerv4Reservation -ComputerName $server1 -ScopeId 10.10.10.0 -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $server1 -ScopeId 10.10.10.0) -ClientId 00-00-00-00-00-01 -Name "Node02"
Add-DhcpServerv4Reservation -ComputerName $server1 -ScopeId 10.10.10.0 -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $server1 -ScopeId 10.10.10.0) -ClientId 00-00-00-00-00-03 -Name "Node03"
Add-DhcpServerv4Reservation -ComputerName $server1 -ScopeId 10.10.10.0 -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $server1 -ScopeId 10.10.10.0) -ClientId 00-00-00-00-00-04 -Name "Node04"
Add-DhcpServerv4Reservation -ComputerName $server1 -ScopeId 10.10.10.0 -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $server1 -ScopeId 10.10.10.0) -ClientId 00-00-00-00-00-05 -Name "Node05"
Add-DhcpServerv4Reservation -ComputerName $server1 -ScopeId 10.10.10.0 -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $server1 -ScopeId 10.10.10.0) -ClientId 00-00-00-00-00-06 -Name "Node06"
Add-DhcpServerv4Reservation -ComputerName $server1 -ScopeId 10.10.10.0 -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $server1 -ScopeId 10.10.10.0) -ClientId 00-00-00-00-00-07 -Name "Node07"
Add-DhcpServerv4Reservation -ComputerName $server1 -ScopeId 10.10.10.0 -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $server1 -ScopeId 10.10.10.0) -ClientId 00-00-00-00-00-08 -Name "Node08"
Add-DhcpServerv4Reservation -ComputerName $server1 -ScopeId 10.10.10.0 -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $server1 -ScopeId 10.10.10.0) -ClientId 00-00-00-00-00-09 -Name "Node09"
Add-DhcpServerv4Reservation -ComputerName $server1 -ScopeId 10.10.10.0 -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $server1 -ScopeId 10.10.10.0) -ClientId 00-00-00-00-00-10 -Name "Node10"

#Convert Leases to Reservation
#Get-DhcpServerv4Lease -ComputerName $server1 -ScopeID 10.10.10.0 | Add-DhcpServerv4Reservation -ComputerName $server1

#Replicate Settings
Write-Host "Forcing Replication" -ForegroundColor "Yellow"
Invoke-DhcpServerv4FailoverReplication -ComputerName $server1 -ScopeID 10.10.10.0 -Force
