#!/bin/bash
#
# Thanks to Willem van Engen for providing the CUPS backend script.
# (http://willem.engen.nl/projects/cupssmb/)
#
# Dependencies:
# cups, samba (smbclient), readline, gtk3-print-backends (optional)
#
# Known issues:
# - Currently every print job is recognized as a failure by CUPS. This leads
# to the default action of pausing the printer. By changing the default action
# to 'abort job' it is possible to avoid the pausing after every job.
# Unfortunately this more or less cancels every job which makes debugging quite
# hard when a printing job was _really_ unsuccessful.
#
# - All the documents _lose_ their name by printing them. On the printer all
# of them shop up under the same generic name. This happens because the file is
# piped into the smbclient (somehow) and it has to be renamed to address it.
#
# This script was developed and tested on Arch Linux.
# Copyright (C) 2017 by Jakob Jungreithmeir and Thomas Fellner.

user="$(whoami)"
samba_auth_file="/etc/samba/printing.auth"
samba_conf="/etc/samba/smb.conf"

# Checking if dependencies are met
if ! ldconfig -p | grep --quiet samba; then
    echo "Samba is currently not installed."
    echo "Aborting setup."
    exit 1
fi;
if ! ldconfig -p | grep --quiet cups; then
    echo "Cups is currently not installed."
    echo "Aborting setup."
    exit 1
fi;

# Gaining superuser rights
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Properly configuring samba
# https://bugs.archlinux.org/task/3743
if [ ! -f $samba_conf ]; then
    echo "Creating empty samba config file."
    touch $samba_conf
    chmod 644 $samba_conf
fi

# Ask for credentials
read -p "Please enter your TGM username: " tgm_username
read -s -p "Please enter your password: " tgm_password
echo
read -s -p "Confirm your password: " tgm_password_2
echo

# Confirm whether the same password was entered twice
until [ $tgm_password == $tgm_password_2 ]; do
    echo "Did you enter the password correctly?"
    read -s -p "Please enter your password again: " tgm_password
    echo
    read -s -p "Confirm your password: " tgm_password_2
    echo
done

# Save credentials to auth file and set correct permissions to restrict access
echo "username = ${tgm_username}" > ${samba_auth_file}
echo "password = ${tgm_password}" >> ${samba_auth_file}
echo "domain = TGM" >> ${samba_auth_file}
chmod 644 ${samba_auth_file}

# Configure CUPS
systemctl stop org.cups.cupsd.service
cp smbc /usr/lib/cups/backend/
cp RicohMPC3004_FollowYou.ppd /etc/cups/ppd
chown $user /usr/lib/cups/backend/smbc
cat printers.conf >> /etc/cups/printers.conf
systemctl start org.cups.cupsd.service

echo "Setup successful!"
