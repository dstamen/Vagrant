# Powershell Script for Vagrant to install the domain
# @davidstamen
# http://davidstamen.com

#Installing ADDS and Tools
Install-WindowsFeature 'AD-Domain-Services'  -IncludeAllSubFeature -IncludeManagementTools

#Installing ADDS Forest
Install-ADDSForest -DomainName "lab.local" -DomainNetbiosName "lab" -SafeModeAdministratorPassword (ConvertTo-SecureString "P@ssword1" -AsPlainText -Force) -Force
