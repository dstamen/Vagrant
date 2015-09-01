# Powershell Script for Vagrant to configure an additional domain controller in the environment
# @davidstamen
# http://davidstamen.com

#set dns server to be primary dc
Set-DnsClientServerAddress -InterfaceIndex 13 -ServerAddresses ("10.10.10.10")

#store credentials
$password = "vagrant" | ConvertTo-SecureString -asPlainText -Force
$username = "lab.local\vagrant"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)

#Installing ADDS and Tools
Install-WindowsFeature 'AD-Domain-Services'  -IncludeAllSubFeature -IncludeManagementTools

#Installing ADDS Forest
Install-ADDSDomainController -DomainName "lab.local" -Credential $credential -SafeModeAdministratorPassword (ConvertTo-SecureString "P@ssword1" -AsPlainText -Force) -Force -NoRebootOnCompletion:$true

#Set DNS to listen on internal network
dnscmd /ResetListenAddresses 10.10.10.11

#add dhcp rsat to configure DHCP with new dns Server
Install-WindowsFeature RSAT-DHCP
Set-DhcpServerv4OptionValue -computername dc01.lab.local -DnsDomain lab.local -DnsServer 10.10.10.10,10.10.10.11

#Wait and reboot
timeout /t 10
shutdown /r /t 5
