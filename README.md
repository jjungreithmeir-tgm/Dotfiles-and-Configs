# Dotfiles-and-Configs
Various dotfiles and other documentation for my Arch Linux Installation(s)

## Descriptions

- `.Xmodmap` ... Contains keyboard mappings which enable umlaut keys when pressing capslock + specific key (capslock + a = ä)
- `.aliases` ... Shell aliases
- `install.sh` ... Executes all necessary scripts and creates all symlinks in order to properly set up a machine with these files
- `maxima_tempfiles.sh` ... Adds maxima config file so that it stops leaving files in the home directory
- `fix_unknown_media_type.sh` ... Fixes an annoying error that stems from KDE Cachegrind and it's dependencies and always prints messages when using pacman.
- `font_fontrendering.sh` ... Enables smooth font rendering.
- `htmlWatchdog.sh` ... Takes a given url and downloads the html page. It then saves the page and creates a checksum which can be compared at later stages to check if the site has changed. Is primarily used in an automated Jenkins Job which checks semi-dead sites for updates.

## Notes

### General

- After adding a user to a new group simply execute `newgrp <group name>` to update the entry.
- Don't forget to enable the following options in your `/etc/pacman.conf`: `Color`, `ILoveCandy`, `VerbosePkgLists`
- Add `Defaults insults` to the `/etc/sudoers` file for a more interesting administration experience! Use `visudo` to edit this file safely.

### GPG

#### export private key
`gpg -ao <file name> --export-secret-key "email address"`

#### import private key
`gpg --import <file name>`

### Symlinks

Always use absolute paths!

`ln -s <source> <target>`

### CUPS

Add your user to the `lp` and the `sys` group otherwise you will encounter an authentication problem when accessing the web interface via `localhost:631` or `127.0.0.1:631`.

If your printers are not showing up in some applications (e.g. evince, firefox) then simply install `gtk3-print-backends`.

### Teamspeak 3

Essential files which should be included in a backup:

- `ts3server.sqlitedb` - contains channels, settings, user, permissions
- `ts3server.ini`
- `query_ip_whitelist.txt`
- `query_ip_blacklist.txt`
- `files/internal` - all the icon logos, etc.

Teamspeak also offers the possibility to [format text with BB codes](http://forum.teamspeak.com/misc.php?do=bbcode).

### Steam

If all source games fail to properly update and/or download with the error message `corrupt update files` and the steam folder lies on an NTFS formatted drive then you need to change the mounting options in `/etc/fstab` to `defaults,exec,uid=1000,gid=1000`.

## Contributions

### AUR packages

- [texlive-tikz-uml](https://aur.archlinux.org/packages/texlive-tikz-uml/)
- [texlive-coffee-stains](https://aur.archlinux.org/packages/texlive-coffee-stains/)
