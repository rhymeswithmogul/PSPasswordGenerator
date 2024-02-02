# PSPasswordGenerator
History of user-visible changes.
Last update: 2024-02-01

## PSPasswordGenerator version 3.0.1, in development
This version builds the password in-memory as a `[SecureString]`, which means it is never stored insecurely.

## PSPasswordGenerator version 3.0.0, released 3/17/2022
Not dead yet!  In this version, the cmdlet's verb has been changed.  It is now called `Get-RandomPassword` (but `New-RandomPassword` still works.)

Also, what makes it worth a major change?  We can now generate passwords that are made of random words.   Use the `-Words` and `-WordList` parameters and generate more readable passwords, like:
 - `hemolytic<sheeptick=Planned`
 - `Pachydermatouspowder³Est`
 - `blackberries<kitakyushu#imcompressibility%roadway`

## PSPasswordGenerator version 2.0.1, released 1/13/2021
This is a bug-fix release with no visible changes.

## PSPasswordGenerator version 2.0.0, released 12/12/2020
This is the first public release, so everything is new to the world. If you happen to have an earlier version, you'll notice that passwords are now returned as SecureString objects.  To restore the earlier behavior, add the `-AsPlainText` parameter.

To learn more about this module, run these commands:
 - `Get-Help New-RandomPassword`
 - `Get-Help about_PSPasswordGenerator`
