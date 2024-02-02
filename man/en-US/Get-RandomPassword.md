---
external help file: PSPasswordGenerator-help.xml
Module Name: PSPasswordGenerator
online version: https://github.com/rhymeswithmogul/PSPasswordGenerator/blob/main/man/en-US/Get-RandomPassword.md
schema: 2.0.0
---

# Get-RandomPassword

## SYNOPSIS
Creates a random password.

## SYNTAX

### RandomSecurely (Default)
```
Get-RandomPassword [-Length <UInt32>] [-StartWithLetter] [-ExcludeCharacters <String>] [-NoSymbols]
 [-UseAmbiguousCharacters] [-UseExtendedAscii] [<CommonParameters>]
```

### RandomInsecurely
```
Get-RandomPassword [-Length <UInt32>] [-StartWithLetter] [-ExcludeCharacters <String>] [-AsPlainText]
 [-NoSymbols] [-UseAmbiguousCharacters] [-UseExtendedAscii] [<CommonParameters>]
```

### WordsSecurely
```
Get-RandomPassword -WordList <FileInfo> [-ExcludeCharacters <String>] [-Words <UInt32>] [-NoSymbols]
 [-UseAmbiguousCharacters] [-UseExtendedAscii] [<CommonParameters>]
```

### WordsInsecurely
```
Get-RandomPassword -WordList <FileInfo> [-ExcludeCharacters <String>] [-Words <UInt32>] [-AsPlainText]
 [-NoSymbols] [-UseAmbiguousCharacters] [-UseExtendedAscii] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet creates a random password with the specified parameters.  You can generate passwords with any length you want, or with as many random words as you want; and include or restrict characters depending on what constrains your password must abide by.

## EXAMPLES

### Example 1
```powershell
PS C:\> $secureStr = Get-RandomPassword -Length 32
```

Generates a 32-character password and saves it as a SecureString object.  This can be used in PowerShell scripts.  For one example, run Get-Help about_PSPasswordGenerator.

### Example 2
```powershell
PS C:\> Get-RandomPassword -AsPlainText -Length 16
\#aT*fAg]u5$):%a
```

Generates a 16-character password and prints it to the output stream.  You can then copy and paste it for use outside of PowerShell, or pipe it to a command such as Out-File to store it (probably insecurely).

### Example 3
```powershell
PS C:\> Get-RandomPassword -AsPlainText -Words 3 -WordList 'mywordlist.txt'
stern4Trainer%exocycloida
```

Generates a three-word password and prints it to the output stream.  You can then copy and paste it for use outside of PowerShell, or pipe it to a command such as Out-File to store it (probably insecurely).  Note that you must supply a wordlist to the cmdlet.

### Example 4
```powershell
PS C:\> $svcAccountPassword = Get-RandomPassword -Length 240 -UseAmbigiousCharacters -UseExtendedAscii
```

Generates a 240-character password that can be as random as possible.  This is good practice for making service accounts in Active Directory Domain Services, where a human will never need to type the password by hand.

### Example 5
```powershell
PS C:\> $RicohPassword = Get-RandomPassword -Length 15 -ExcludeCharacters '\#%&'
```

I've seen some printers that fail to parse passwords that contain certain characters.  This invocation will create a 15-character password that does not contain a backslash, pound sign, percent sign, or ampersand.  Note that the PowerShell runtime may attempt to parse this string, so it should be enclosed in single quotes.

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
By default, the extended ASCII character set is not used.  Specify this switch to make your passwords more random and contain far more entropy.  However, you will no longer be able to type them easily on a standard keyboard.  In addition, some services may not permit these special characters.  However, specifying this switch greatly increases entropy, as the character pool is roughly doubled.

If the -NoSymbols parameter is specified, then this parameter has no effect.

When using WordList mode, this will only affect the separator characters.  It not affect any words pulled from a wordlist.

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

### -ExcludeCharacters
To create a password that does not use certain characters, specify this parameter.  Anything in the string will be excluded from consideration.

Note that when using this to generate a word-based password, this will only exclude the characters from being used to separate words.  To exclude certain characters from words, edit the wordlist.

The PowerShell runtime may attempt to parse some special characters inside the string, such as the dollar sign, backticks, parentheses, and/or curly braces.  Please make sure you escape any special characters properly, or enclose the string in single quotes to prevent the runtime from parsing the string.


```yaml
Type: String
Parameter Sets: (All)
Aliases: Exclude

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