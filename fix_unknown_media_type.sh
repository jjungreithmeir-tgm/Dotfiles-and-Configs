#!/bin/bash
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi
rm /usr/share/mime/packages/kde.xml
update-mime-database /usr/share/mime
