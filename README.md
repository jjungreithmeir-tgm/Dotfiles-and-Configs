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
