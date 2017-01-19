# Dotfiles-and-Configs
Various dotfiles and other documentation for my Arch Linux Installation(s)

## Descriptions

- `.Xmodmap` ... Contains keyboard mappings which enable umlaut keys when pressing capslock + specific key (capslock + a = ä)
- `.aliases` ... Shell aliases
- `install.sh` ... Executes all necessary scripts and creates all symlinks in order to properly set up a machine with these files
- `maxima_tempfiles.sh` ... Adds maxima config file so that it stops leaving files in the home directory
- `fix_unknown_media_type.sh` ... Fixes an annoying error that stems from KDE Cachegrind and it's dependencies and always prints messages when using pacman.
- `font_fontrendering.sh` ... Enables smooth font rendering.

## Notes

### GPG

#### export private key
`gpg -ao <file name> --export-secret-key "email address"

#### import private key
`gpg --import <file name>

### Symlinks
 
Always use absolute paths!

`ln -s <source> <target>`
