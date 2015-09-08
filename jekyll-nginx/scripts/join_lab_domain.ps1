# Powershell Script for Vagrant to join servers to the domain
# @davidstamen
# http://davidstamen.com

#generate credentials
$domain = "lab.local"
$password = "vagrant" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\vagrant"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)

#join to domain
Add-Computer -DomainName $domain -Credential $credential -OUPath "OU=Lab Servers,dc=lab,dc=local"

#wait and then reboot
timeout /t 10
shutdown /r /t 5
