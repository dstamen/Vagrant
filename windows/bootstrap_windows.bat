echo 'Install ADDS'
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Install-WindowsFeature 'AD-Domain-Services'  -IncludeAllSubFeature -IncludeManagementTools"

echo 'Install ADDS Forest'
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Install-ADDSForest -DomainName "lab.local" -DomainNetbiosName "lab" -SafeModeAdministratorPassword (ConvertTo-SecureString "P@ssword1" -AsPlainText -Force) -Verbose -Force"
