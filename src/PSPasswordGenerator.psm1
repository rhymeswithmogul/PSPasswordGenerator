<#
    PSPasswordGenerator.psm1, code for the PSPasswordGenerator module
    Copyright (C) 2016-2021 Colin Cogle <colin@colincogle.name>
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

#Requires -Version 3.0

# .ExternalHelp PSPasswordGenerator-help.xml
Function New-RandomPassword {
	[CmdletBinding(DefaultParameterSetName='Securely')]
	[OutputType([String], ParameterSetName='Insecurely')]
	[OutputType([Security.SecureString], ParameterSetName='Securely')]
	[Alias('Get-RandomPassword')]
	Param(
		[Parameter(ParameterSetName='Insecurely')]
		[Switch] $AsPlainText,

		[ValidateRange(1, [UInt32]::MaxValue)]
		[Alias('Count', 'Size')]
		[UInt32] $Length = 16,

		[Switch] $StartWithLetter,
		[Switch] $NoSymbols,
		[Switch] $UseAmbiguousCharacters,
		[Switch] $UseExtendedAscii
	)

	# Warn the user if they've specified mutually-exclusive options.
	If ($NoSymbols -and $UseExtendedAscii) {
		Write-Warning 'The -NoSymbols parameter was also specified.  No extended ASCII characters will be used.'
	}

	$ret = ""
	For ($i = 0; $i -lt $Length; $i++) {
		Do {
			Do {
				Do {
					Do {
						$x = Get-Random -Minimum 33 -Maximum 254
						Write-Debug "Considering character: $([char]$x)"
					} While ($x -eq 127 -Or (-Not $UseExtendedAscii -And $x -gt 127))
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
		$ret += [char]$x
	}

	If ($AsPlainText) {
		Return $ret
	} Else {
		$ss = ConvertTo-SecureString -AsPlainText -Force -String $ret
		Remove-Variable -Name 'ret' -ErrorAction SilentlyContinue
		Return $ss
	}
}
