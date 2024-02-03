# PSPasswordGenerator change log

## Version 3.1.0 (coming soon)
- This version is more secure, as the generated password is now built in memory as a `[SecureString]`, and only converted from one when this cmdlet is run with `-AsPlainText`.
- Added a new `-ExcludeCharacters` parameter which does as it says;  generated passwords will not include those characters.  Thanks to [GitHub user @wwc-trevor](https://github.com/wwc-trevor) for [the great idea](https://github.com/rhymeswithmogul/PSPasswordGenerator/issues/4) and for testing my work.
- Packaging improvements.

## Version 3.0.0 (March 17, 2022)
- We can now generate human-friendly passwords from wordlists.
- This cmdlet has been renamed `Get-RandomPassword`, as "Get" is a better verb than "New" in this case.

## Version 2.0.1 (January 13, 2021)
Generated passwords are now properly removed from memory once they are displayed to the user.  Previously, this did not work, and would occasionally create a spurious error message.

## Version 2.0.0 (December 12, 2020)
- Initial public release to GitHub and PowerShell Gallery.
- Made `SecureString` output the default, with the `-AsPlainText` parameter introduced to emulate the earlier behavior from the 1.x versions.
- Help!  There's help now.  Plenty of it.

# Versions 1.0.0 (2016) through 1.2.1 (whenever)
These versions were a single script that this author used for his own use, and probably shared it with a few friends and colleagues. They weren't released publicly.
