#!/bin/bash
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi
cp resources/local.conf /etc/fonts/.
grep -q -F "export FREETYPE_PROPERTIES=\"truetype:interpreter-version=38\"" /etc/profile.d/freetype.sh || echo "export FREETYPE_PROPERTIES=\"truetype:interpreter-version=38\"" >> /etc/profile.d/freetype.sh
