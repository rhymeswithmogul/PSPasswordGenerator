---
external help file: PSPasswordGenerator-help.xml
Module Name: PSPasswordGenerator
online version: https://github.com/rhymeswithmogul/PSPasswordGenerator/blob/main/man/en-US/New-RandomPassword.md
schema: 2.0.0
---

# New-RandomPassword

## SYNOPSIS
Creates a random password.

## SYNTAX

### RandomSecurely (Default)
```
New-RandomPassword [-Length <UInt32>] [-StartWithLetter] [-NoSymbols] [-UseAmbiguousCharacters]
 [-UseExtendedAscii] [<CommonParameters>]
```

### RandomInsecurely
```
New-RandomPassword [-Length <UInt32>] [-StartWithLetter] [-AsPlainText] [-NoSymbols] [-UseAmbiguousCharacters]
 [-UseExtendedAscii] [<CommonParameters>]
```

### WordsSecurely
```
New-RandomPassword [-Words <UInt32>] -WordList <FileInfo> [-NoSymbols] [-UseAmbiguousCharacters]
 [-UseExtendedAscii] [<CommonParameters>]
```

### WordsInsecurely
```
New-RandomPassword [-Words <UInt32>] -WordList <FileInfo> [-AsPlainText] [-NoSymbols] [-UseAmbiguousCharacters]
 [-UseExtendedAscii] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet creates a random password with the specified parameters.  You can generate passwords with any length you want, or with as many random words as you want; and include or restrict characters depending on what constrains your password must abide by.

## EXAMPLES

### Example 1
```powershell
PS C:\> $secureStr = New-RandomPassword -Length 32
```

Generates a 32-character password and saves it as a SecureString object.  This can be used in PowerShell scripts.  For one example, run Get-Help about_PSPasswordGenerator.

### Example 2
```powershell
PS C:\> New-RandomPassword -AsPlainText -Length 16
\#aT*fAg]u5$):%a
```

Generates a 16-character password and prints it to the output stream.  You can then copy and paste it for use outside of PowerShell, or pipe it to a command such as Out-File to store it (probably insecurely).

### Example 3
```powershell
PS C:\> New-RandomPassword -AsPlainText -Words 3 -WordList 'mywordlist.txt'
stern4Trainer%exocycloida
```

Generates a three-word password and prints it to the output stream.  You can then copy and paste it for use outside of PowerShell, or pipe it to a command such as Out-File to store it (probably insecurely).  Note that you must supply a wordlist to the cmdlet.

### Example 4
```powershell
PS C:\> $svcAccountPassword = New-RandomPassword -Length 240 -UseAmbigiousCharacters -UseExtendedAscii
```

Generates a 240-character password that can be as random as possible.  This is good practice for making service accounts in Active Directory Domain Services, where a human will never need to type the password by hand.

## PARAMETERS

### -AsPlainText
By default, the password is returned as a [System.Security.SecureString].  Specify this parameter to return it as a regular, cleartext [System.String], where it can simply be printed to the output stream, saved into a varible, or copied and pasted in an interactive session.

```yaml
Type: SwitchParameter
Parameter Sets: RandomInsecurely, WordsInsecurely
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Length
The generated password will always be of the specified length.  You can specify any length between 1 and 4,294,967,295 characters inclusive.  Entropy tends to increases along with the value of this parameter.

```yaml
Type: UInt32
Parameter Sets: RandomSecurely, RandomInsecurely
Aliases: Count, MinLength, Size

Required: False
Position: Named
Default value: 16
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoSymbols
If this switch is specified, the resulting password will only contain letters and numbers.  This might be useful for services that restrict or prohibit the use of special characters, or for situations where special characters may not be escaped correctly.  Entropy decreases when this parameter is specified;  this can be counteracted by increasing the -Length parameter.

Using this parameter causes the -UseExtendedAscii parameter to have no effect.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartWithLetter
If this switch is specified, the first character of the password will be either an uppercase or lowercase letter.  This slightly decreases entropy, but decreases it further as the password length increases.

```yaml
Type: SwitchParameter
Parameter Sets: RandomSecurely, RandomInsecurely
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseAmbiguousCharacters
By default, ambigious characters such as '1', 'I', 'l', and '|'; as well as '0' and 'O'; will not be used, so that the password is a little easier for a human to read and type.  If you would like these similar-looking characters to be used in the password, specify this switch, and they will be returned to the character pool.  Specifying this switch slightly increases entropy.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseExtendedAscii
By default, the extended ASCII character set is not used.  Specify this switch to make your passwords more random and contain far more entropy.  However, you will no longer be able to type them on a standard keyboard.  In addition, some services may not permit these special characters.  However, specifying this switch greatly increases entropy, as the character pool is roughly doubled.

If the -NoSymbols parameter is specified, then this parameter has no effect.

Note that this will not affect any words pulled from a wordlist.  If your wordlist contains extended ASCII (or Unicode) characters, NOT using this switch will have no effect.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WordList
A plain text file containing one word per line.  This will be loaded into memory when generating a password containing words.

```yaml
Type: FileInfo
Parameter Sets: WordsSecurely, WordsInsecurely
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Words
When generating a password made up of random words, the password should contain this many words.  Each word will be separated by a single number, symbol (only if -NoSymbols is not specified), or an extended ASCII character (only if -UseExtendedAscii is specified).

```yaml
Type: UInt32
Parameter Sets: WordsSecurely, WordsInsecurely
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
This cmdlet does not accept pipeline input.

## OUTPUTS

### System.Security.SecureString
If the -AsPlainText parameter is not specified.

### System.String
If the -AsPlainText parameter is specified.

## NOTES
This cmdlet can generate passwords with very high entropy, but they might be longer or stronger than your service allows.  For example, this cmdlet could generate a password with 4.2 billion characters, but Microsoft 365 passwords are limited to 256 characters.  Make good passwords, but be aware of your service's limits.

Also, when generating passwords of random words, note that the size of your wordlist will have a direct effect on performance.

## RELATED LINKS

[about_PSPasswordGenerator]()