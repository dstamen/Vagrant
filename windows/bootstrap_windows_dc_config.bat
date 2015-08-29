timeout /t 60 /NOBREAK

echo ## add permissions
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-ADGroupMember 'Domain Admins' Vagrant"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-ADGroupMember 'Enterprise Admins' Vagrant"

echo ## create ous
@powershell -NoProfile -ExecutionPolicy Bypass -Command "New-ADOrganizationalUnit 'Lab Users'"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "New-ADOrganizationalUnit 'Lab Groups'"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "New-ADOrganizationalUnit 'Lab Servers'"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "New-ADOrganizationalUnit 'Lab Desktops'"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "New-ADOrganizationalUnit 'Security Groups' -path 'OU=Lab Groups,dc=lab,dc=local'"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "New-ADOrganizationalUnit 'Distribution Groups' -path 'OU=Lab Groups,dc=lab,dc=local'"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "New-ADOrganizationalUnit 'Service Accounts' -path 'OU=Lab Users,dc=lab,dc=local'"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "New-ADOrganizationalUnit 'User Accounts' -path 'OU=Lab Users,dc=lab,dc=local'"
@powershell -NoProfile -ExecutionPolicy Bypass -Command "New-ADOrganizationalUnit 'Admin Accounts' -path 'OU=Lab Users,dc=lab,dc=local'"
