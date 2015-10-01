# Powershell Script for Vagrant to install and configure DHCP
# @davidstamen
# http://davidstamen.com
cd c:\vagrant\scripts

$username = "vagrant"
$password = "vagrant"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr

# Install the DHCP Role
Write-Host "Installing DHCP Server Role" -ForegroundColor "Red"
$csv = Import-CSV .\dhcpservers.csv
foreach ($server in $csv) {
  Install-WindowsFeature DHCP -IncludeAllSubFeature -IncludeManagementTools -Computer $server.Name -Credential $cred -Verbose
}

# Authorize the DHCP server in Active Directory
#$server = hostname
#Add-DhcpServerInDC -DnsName $server -IPAddress $server1

# Create an IPv4 DHCP scope
Write-Host "Adding DHCP Scopes" -ForegroundColor "Red"
$csv = Import-CSV .\createscopes.csv
foreach ($scope in $csv) {
    Add-DhcpServerv4Scope -ComputerName $scope.Server -Name $scope.Name -StartRange $scope.Start -EndRange $scope.End -SubnetMask $scope.mask -Verbose
}

# Set the DNS server to use for all clients to use on the DHCP server
Write-Host "Setting DHCP Scope Options" -ForegroundColor "Red"
$csv = Import-CSV .\scopeoptions.csv
foreach ($scope in $csv) {
  Set-DhcpServerv4OptionValue -ComputerName $scope.Server -ScopeId $scope.scopeID -DnsDomain $scope.DNSDomain -Verbose
  Set-DhcpServerv4Scope -ComputerName $scope.Server -ScopeId $scope.scopeID -LeaseDuration $scope.Lease -Verbose
}

# Configure Failover
Write-Host "Configuring DHCP Failover" -ForegroundColor "Red"
$csv = Import-CSV .\scopefailover.csv
foreach ($scope in $csv) {
  Add-DhcpServerv4Failover -ComputerName $scope.Server -Name $scope.scopeID -PartnerServer $scope.PartnerServer -ScopeId $scope.scopeID -LoadBalancePercent $scope.LoadBalancePercent -MaxClientLeadTime $scope.MaxClientLeadTime -AutoStateTransition ([System.Convert]::ToBoolean($scope.AutoStateTransition)) -StateSwitchInterval $scope.StateSwitchInterval -Verbose
}

#Create MAC Allow List DHCP policy
Write-Host "Creating MAC Allow List Policy" -ForegroundColor "Red"
$csv = Import-CSV .\scopepolicy.csv
foreach ($scope in $csv) {
  $maclist = @()
  $operator = $scope.Operator
  $maclist+=$operator
  $maclist+=$Scope.MAC1
  $maclist+=$Scope.MAC2
  Add-DhcpServerv4Policy -ComputerName $scope.Server -Name $scope.Name -Description $scope.Description -ScopeId $scope.ScopeID -Condition $scope.Condition -MacAddress $maclist -Verbose
  Add-DhcpServerv4PolicyIPRange -ComputerName $scope.Server -Name $scope.Name -ScopeId $scope.ScopeID -StartRange (Get-DHCPServerv4Scope $scope.ScopeID).StartRange -EndRange (Get-DHCPServerv4Scope $scope.ScopeID).EndRange -Verbose
}

#Reserve IP's
Write-Host "Reserving DHCP IPs" -ForegroundColor "Red"
$csv = Import-CSV .\scopereservations.csv
foreach ($scope in $csv) {
  Add-DhcpServerv4Reservation -ComputerName $scope.Server -ScopeId $scope.ScopeID -IPAddress (Get-DhcpServerv4FreeIPAddress -ComputerName $scope.Server -ScopeId $scope.ScopeID) -ClientId $Scope.MAC -Name $scope.Name -Verbose

  #Replicate Settings
  Write-Host "Forcing Replication" -ForegroundColor "Red"
  Get-DhcpServerv4Failover -ComputerName $scope.Server|Invoke-DhcpServerv4FailoverReplication -ComputerName $scope.Server -Force -Verbose
}

#Convert Leases to Reservation
#Get-DhcpServerv4Lease -ComputerName $server1 -ScopeID 10.10.10.0 | Add-DhcpServerv4Reservation -ComputerName $server1
