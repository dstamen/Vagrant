#set dns server to be primary dc
Set-DnsClientServerAddress -InterfaceIndex 13 -ServerAddresses ("10.10.10.10")

#store credentials
$password = "vagrant" | ConvertTo-SecureString -asPlainText -Force
$username = "lab.local\vagrant"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)

#Installing ADDS and Tools
Install-WindowsFeature 'AD-Domain-Services'  -IncludeAllSubFeature -IncludeManagementTools

#Installing ADDS Forest
Install-ADDSDomainController -DomainName "lab.local" -Credential $credential -SafeModeAdministratorPassword (ConvertTo-SecureString "P@ssword1" -AsPlainText -Force) -Force
