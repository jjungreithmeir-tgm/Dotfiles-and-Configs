#!/bin/bash
#
# Thanks to Willem van Engen for providing the CUPS backend script.
# (http://willem.engen.nl/projects/cupssmb/)
#
# Dependencies:
# cups, samba (smbclient), gtk3-print-backends (optional)
#
# Known issues:
# Currently every print job is recognized as a failure by CUPS. This leads
# to the default action of pausing the printer. By changing the default action
# to 'abort job' it is possible to avoid the pausing after every job.
# Unfortunately this more or less cancels every job which makes debugging quite
# hard when a printing job was _really_ unsuccessful.
#
# This script was developed and tested on Arch Linux.
# Copyright (C) 2016 by Jakob Jungreithmeir and Thomas Fellner.

user="$(whoami)"
samba_auth_file="/etc/samba/printing.auth"

# Gaining superuser rights
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Installing printer driver
#cd /tmp
#git clone https://aur.archlinux.org/openprinting-ppds-postscript-ricoh.git
#cd openprinting-ppds-postscript-ricoh
#makepkg
#pacman -U --no- openprinting-ppds-postscript-ricoh-20161206-1-any.pkg.tar.xz

# Properly configuring samba
# https://bugs.archlinux.org/task/3743
# TODO check if file already exists
touch /etc/samba/smb.conf

# Ask for credentials
read -p "Please enter your TGM username: " tgm_username
read -s -p "Please enter your password: " tgm_password
read -s -p "Confirm your password: " tgm_password_2

# Confirm whether the same password was entered twice
until [ $tgm_password == $tgm_password_2 ]; do
    echo "Did you enter the password correctly?"
    read -s -p "Please enter your password again: " tgm_password
    read -s -p "Confirm your password: " tgm_password_2
done

# Save credentials to auth file and set correct permissions to restrict access
echo "username = ${tgm_username}" > ${samba_auth_file}
echo "password = ${tgm_password}" >> ${samba_auth_file}
echo "domain = TGM" >> ${samba_auth_file}
chmod 600 ${samba_auth_file}

# Configure CUPS
systemctl stop org.cups.cupsd.service
cp smbc /usr/lib/cups/backend/
cp RicohMPC3004_FollowYou.ppd /etc/cups/ppd
chown $user /usr/lib/cups/backend/smbc
cat printers.conf >> /etc/cups/printers.conf
systemctl start org.cups.cupsd.service
