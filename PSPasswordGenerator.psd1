<#
	PSPasswordGenerator.psm1, manifest for the PSPasswordGenerator module
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
@{

# Script module or binary module file associated with this manifest.
RootModule = 'src/PSPasswordGenerator.psm1'

# Version number of this module.
ModuleVersion = '3.1.0'

# Supported PSEditions
CompatiblePSEditions = @('Desktop', 'Core')

# ID used to uniquely identify this module
GUID = '57d19518-fbda-4501-8733-9f9d95d04c7e'

# Author of this module
Author = 'Colin Cogle'

# Company or vendor of this module
CompanyName = $null

# Copyright statement for this module
Copyright = '(c) 2016-2022, 2024 Colin Cogle. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Generate random passwords with the constraints you want.'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @('Get-RandomPassword')

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = ''

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @('New-RandomPassword')

# List of all files packaged with this module
FileList = @(
	'en-US/about_PSPasswordGenerator.help.txt',
	'en-US/PSPasswordGenerator-help.xml',
	'src/PSPasswordGenerator.psm1',
	'AUTHORS.txt',
	'ChangeLog.md',
	'CODE_OF_CONDUCT.md',
	'CONTRIBUTING.md',
	'LICENSE.txt',
	'NEWS.md',
	'PSPasswordGenerator.psd1',
	'README.md',
	'SECURITY.md'
)

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

	PSData = @{

		# Tags applied to this module. These help with module discovery in online galleries.
		Tags = @('Core', 'desktop', 'entropy', 'generator', 'get', 'Linux', 'macOS', 'maker', 'new', 'pass', 'passcode', 'password', 'PowerShell', 'PasswordGenerator', 'PSModule', 'pwsh', 'random', 'security', 'sysadmin', 'Windows', 'wordlist')

		# A URL to the license for this module.
		LicenseUri = 'https://www.gnu.org/licenses/agpl-3.0.en.html'

		# A URL to the main website for this project.
		ProjectUri = 'https://www.github.com/rhymeswithmogul/PSPasswordGenerator'

		# A URL to an icon representing this module.
		IconUri = 'https://raw.githubusercontent.com/rhymeswithmogul/PSPasswordGenerator/main/icon/PSPasswordGenerator.png'

		# ReleaseNotes of this module
		ReleaseNotes = '- Strings are now generated securely on supported platforms.
- Added a new ExcludeCharacters parameter which does as it says;  generated passwords will not include those characters.
- Packaging improvements.'

		# Flag to indicate whether the module requires explicit user acceptance for install/update/save
		RequireLicenseAcceptance = $false

		# Beta?
		Prerelease = 'git'

	} # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

