# Powershell Script for Vagrant to configure the domain environment after deployment
# @davidstamen
# http://davidstamen.com

# Wait 30 seconds
timeout /t 30

# Add Permissions to Vagrant Account
Add-ADGroupMember 'Domain Admins' Vagrant
Add-ADGroupMember 'Enterprise Admins' Vagrant

# Create OU's
New-ADOrganizationalUnit 'Lab Users'
New-ADOrganizationalUnit 'Lab Groups'
New-ADOrganizationalUnit 'Lab Servers'
New-ADOrganizationalUnit 'Lab Desktops'
New-ADOrganizationalUnit 'Security Groups' -path 'OU=Lab Groups,dc=lab,dc=local'
New-ADOrganizationalUnit 'Distribution Groups' -path 'OU=Lab Groups,dc=lab,dc=local'
New-ADOrganizationalUnit 'Service Accounts' -path 'OU=Lab Users,dc=lab,dc=local'
New-ADOrganizationalUnit 'User Accounts' -path 'OU=Lab Users,dc=lab,dc=local'
New-ADOrganizationalUnit 'Admin Accounts' -path 'OU=Lab Users,dc=lab,dc=local'

# Create Users
Import-Module ActiveDirectory
import-csv c:\vagrant\scripts\Users.csv | % {New-ADUser -GivenName $_.GivenName -Surname $_.Surname -Name $_.Name -DisplayName $_.DisplayName -Path $_.Path -Enabled $true -AccountPassword (ConvertTo-SecureString $_.AccountPassword -AsPlainText -force) -PasswordNeverExpires $true -SamAccountName $_.SamAccountName -UserPrincipalName ($_.SamAccountName + "@lab.local")}
