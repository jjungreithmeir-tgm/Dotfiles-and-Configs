#!/bin/bash
# $1 is supposed to be the link to the site to be watched.

if [ $# -eq 0 ]
  then
    echo "No link supplied."
    exit 1
fi

temp_dir="/tmp/"
html_file="package.html"
checksum_file="checksum.txt"

wget -q -O ${temp_dir}${html_file} $1
if [ -f ${checksum_file} ]; then
    echo "Previous saved check found."
    if md5sum --status -c ${checksum_file}; then
        echo "Nothing has changed."
        exit 0
    else
        echo "The monitored site has changed since the last check!"
        exit 1
    fi
else
    echo "Setting up initial check."
    md5sum ${temp_dir}${html_file} > ${checksum_file}
fi
