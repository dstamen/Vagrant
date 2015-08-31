$domain = "lab.local"
$password = "vagrant" | ConvertTo-SecureString -asPlainText -Force
$username = "$domain\vagrant"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer -DomainName $domain -Credential $credential -OUPath "OU=Lab Servers,dc=lab,dc=local"
timeout /t 10 /nobreak
shutdown /r /t 5
