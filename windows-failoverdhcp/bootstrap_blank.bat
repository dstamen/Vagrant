timeout /t 15
winrm set winrm/config/client @{TrustedHosts="*"}
