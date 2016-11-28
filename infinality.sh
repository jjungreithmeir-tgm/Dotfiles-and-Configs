#!/bin/bash
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi
grep -q -F "infinality" /etc/pacman.conf || (echo "[infinality-bundle]
Server = http://bohoomil.com/repo/\$arch

[infinality-bundle-multilib]
Server = http://bohoomil.com/repo/multilib/\$arch

[infinality-bundle-fonts]
Server = http://bohoomil.com/repo/fonts" >> /etc/pacman.conf

rm -rf /etc/pacman.d/gnupg
pacman-key --init
dirmngr </dev/null
pacman-key --populate archlinux
pacman-key -r 962DDE58
pacman-key --lsign-key 962DDE58

pacman -S --noconfirm infinality-bundle ibfonts-meta-base)
