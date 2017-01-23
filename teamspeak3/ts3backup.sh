#!/bin/bash

if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

installation_folder = /home/teamspeak/teamspeak3-server_linux-amd64/

tar -zcvf ${installation_folder}ts3backup.tar \
${installation_folder}query_ip_blacklist.txt \
${installation_folder}query_ip_whitelist.txt \
${installation_folder}ts3server.sqlitedb ts3server.ini \
${installation_folder}files/internal \
/etc/systemd/system/teamspeak.service
