# PowerShell PasswordGenerator Module
This module provides a convenient way to generate passwords that are at most as cryptographically secure as the `Get-Random` cmdlet's source of entropy can provide.

## Installation
You can install the `PasswordGenerator` module from the PowerShell Gallery:
```powershell
Install-Module [-Name] PasswordGenerator [-Repository PSGallery]
```

Or, do a `git clone` into your `${env:PSModulePath}` and work with the latest development version.

This module is compatible with PowerShell 7, and it will be compatible with the legacy version of Windows PowerShell 5.1 for as long as possible.

## Usage
By default, this cmdlet returns password as a `SecureString` object.  This is great for PowerShell scripting, as the password is protected in memory.  For example, you could build a `PSCredential` object with the highest entropy possible that's still compatible with Active Directory Domain Services.  This is a way to configure a Windows Server DHCP Server service.

```powershell
PS> Import-Module PasswordGenerator
PS> $passwd = New-RandomPassword -Length 240 -UseExtendedAscii -UseAmbigiousCharacters
PS> $credentials = [Management.Automation.PSCredential]::new('DOMAIN\_ServiceAccount'), $passwd)

PS> Import-Module DHCPServer
PS> Set-DHCPServerDNSCredential -Credential $credentials
```

However, in many cases, you might be using this module to generate random passwords for use outside of PowerShell.  In that case, supply the `-AsPlainText` parameter.  (As this is a valid use, I won't make you also include the `-Force` parameter.)

```powershell
PS> New-RandomPassword -Length 32 -AsPlainText
i%eS+R5y4q^4wZ#E>(kNCKuU]R}hQZ"H
```

Then, copy and paste that into whatever service or device is asking for a password.

## Disclaimers
This module is not developed, endorsed, or known by Microsoft.