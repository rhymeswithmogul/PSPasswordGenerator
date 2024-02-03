<#
    PSPasswordGenerator.psm1, code for the PSPasswordGenerator module
    Copyright (C) 2016-2022, 2024 Colin Cogle <colin@colincogle.name>
    Online at <https://github.com/rhymeswithmogul/PSPasswordGenerator>

    This program is free software:  you can redistribute it and/or modify it
    under the terms of the GNU Affero General Public License as published by the
    Free Software Foundation, either version 3 of the License, or (at your
    option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY;  without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License
    for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#>

#Requires -Version 5.1

# .ExternalHelp PSPasswordGenerator-help.xml
Function Get-RandomPassword
{
	[CmdletBinding(DefaultParameterSetName='RandomSecurely')]
	[OutputType([String], ParameterSetName='RandomInsecurely')]
	[OutputType([String], ParameterSetName='WordsInsecurely')]
	[OutputType([Security.SecureString], ParameterSetName='RandomSecurely')]
	[OutputType([Security.SecureString], ParameterSetName='WordsSecurely')]
	[Alias('New-RandomPassword')]
	Param(
		[Parameter(ParameterSetName='RandomInsecurely')]
		[Parameter(ParameterSetName='RandomSecurely')]
		[ValidateRange(1, [UInt32]::MaxValue)]
		[Alias('Count', 'MinLength', 'Size')]
		[UInt32] $Length = 16,

		[Parameter(ParameterSetName='RandomInsecurely')]
		[Parameter(ParameterSetName='RandomSecurely')]
		[Switch] $StartWithLetter,

		[AllowNull()]
		[Alias('Exclude')]
		[String] $ExcludeCharacters,

		[Parameter(ParameterSetName='WordsInsecurely')]
		[Parameter(ParameterSetName='WordsSecurely')]
		[ValidateRange(1, [UInt32]::MaxValue)]
		[UInt32] $Words = 3,

		[Parameter(ParameterSetName='WordsInsecurely', Mandatory)]
		[Parameter(ParameterSetName='WordsSecurely', Mandatory)]
		[ValidateNotNullOrEmpty()]
		[IO.FileInfo] $WordList,

		[Parameter(ParameterSetName='RandomInsecurely', Mandatory)]
		[Parameter(ParameterSetName='WordsInsecurely', Mandatory)]
		[Switch] $AsPlainText,

		[Switch] $NoSymbols,

		[Switch] $UseAmbiguousCharacters,

		[Switch] $UseExtendedAscii
	)

	# Warn the user if they've specified mutually-exclusive options.
	If ($NoSymbols -and $UseExtendedAscii) {
		Write-Warning 'The -NoSymbols parameter was also specified.  No extended ASCII characters will be used.'
	}

	$ret = [SecureString]::new()
	If ($PSCmdlet.ParameterSetName -Like 'Random*') {
		For ($i = 0; $i -lt $Length; $i++) {
			Do {
				Do {
					Do {
						Do {
							$x = Get-Random -Minimum 33 -Maximum 254
							Write-Debug "Considering character: $([char]$x)"
						} While (
							$x -eq 127 `
							-Or (-Not $UseExtendedAscii -And $x -gt 127) `
							-Or ($ExcludeCharacters.IndexOf($x) -ne -1)
						)
						# The above Do..While loop does this:
						#  1. Don't allow ASCII 127 (delete).
						#  2. Don't allow extended ASCII, unless the user wants it.

					} While (-Not $UseAmbiguousCharacters -And ($x -In @(49,73,108,124,48,79)))
					# The above loop disallows 1 (ASCII 49), I (73), l (108),
					# | (124), 0 (48) or O (79) -- unless the user wants those.

				} While ($NoSymbols -And ($x -lt 48 -Or ($x -gt 57 -And $x -lt 65) -Or ($x -gt 90 -And $x -lt 97) -Or $x -gt 122))
				# If the -NoSymbols parameter was specified, this loop will ensure
				# that the character is neither a symbol nor in the extended ASCII
				# character set.

			} While ($i -eq 0 -And $StartWithLetter -And -Not (($x -ge 65 -And $x -le 90) -Or ($x -ge 97 -And $x -le 122)))
			# If the -StartWithLetter parameter was specified, this loop will make
			# sure that the first character is an upper- or lower-case letter.

			Write-Debug "SUCCESS: Adding character: $([char]$x)"
			$ret.AppendChar($x)
		}
	}

	# If we're generating random words:
	Else {
		# There is DEFINITELY room for improvement here.  Loading an entire
		# wordlist into memory can be quite cumbersome.
		$allWords = Get-Content -LiteralPath $WordList -ErrorAction Stop
		$culture  = (Get-Culture).TextInfo

		For ($i = 0; $i -lt $Words; $i++) {
			# Pick a random word from the list.
			$word = Get-Random $allWords

			# Randomly capitalize the first letter of the word.
			If ((Get-Random) % 2) {
				$word = $culture.ToTitleCase($word)
			}

			# Stick something in between the words.
			# Letters are 65-90 (caps) and 97-122 (lower).
			# Don't bother finding a separator if this is the final word.
			If ($i -eq ($Words - 1))
			{
				Write-Debug "WORD=`"$word`""
			}
			Else
			{
				$separator = 0
				Do {
					$ch = (Get-RandomPassword -Length 1 -NoSymbols:$NoSymbols -AsPlainText -UseExtendedAscii:$UseExtendedAscii)
					Write-Debug "Trying separator $ch."
					$separator = [Convert]::ToByte([Char]$ch)
				} While (
					($separator -ge 65 -and $separator -le 90)				<# No uppercase letters #> `
					-or ($separator -ge 97 -and $separator -le 122)			<# No lowercase letters #> `
					-or ($separator -ge 128 -and $separator -le 165)		<# No accented letters  #> `
					-or ($separator -gt 165 -and -Not $UseExtendedAscii)	<# Unwanted extended ASCII #> `
					-or ($ExcludeCharacters.IndexOf($x) -ne -1)
				)
				Write-Debug "WORD=`"$word`", SEP=`"$([Char]$separator)`""

				$word += [Char]$separator
			}

			# SecureStrings can only be appended to one character at a time.
			$word.ToCharArray() | ForEach-Object {
				Write-Debug "Appending character: $_"
				$ret.AppendChar($_)
			}
		}
	}

	If ($AsPlainText) {
		Return (ConvertFrom-SecureString $ret -AsPlainText)
	} Else {
		Return $ret
	}
}
