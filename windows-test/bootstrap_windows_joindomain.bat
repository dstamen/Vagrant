@powershell.exe;"$domain = 'lab.local';$password = 'vagrant' | ConvertTo-SecureString -asPlainText -Force;$username = '$domain\vagrant';$credential = New-Object System.Management.Automation.PSCredential($username,$password);Add-Computer -DomainName $domain -Credential $credential;Restart-Computer"
