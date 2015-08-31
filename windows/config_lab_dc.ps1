# wait 1min to boot
timeout /t 60 /NOBREAK

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
