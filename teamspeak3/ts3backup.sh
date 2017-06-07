#!/bin/bash

installation_folder=/home/teamspeak/teamspeak3-server_linux-amd64/
synchronized_folder=/home/teamspeak/Backup/
fingerprint=<insert public key>
user_id=<insert user id>

tar -zcvf ${installation_folder}ts3backup.tar \
${installation_folder}query_ip_blacklist.txt \
${installation_folder}query_ip_whitelist.txt \
${installation_folder}ts3server.sqlitedb \
${installation_folder}ts3server.ini \
${installation_folder}files/internal \
/etc/systemd/system/teamspeak.service

gpg --keyserver pgp.mit.edu --recv-keys ${fingerprint}
gpg --batch --yes --trust-model always --output ${synchronized_folder}backup.gpg --encrypt --recipient ${user_id} ${installation_folder}ts3backup.tar

cd ${synchronized_folder}
git add -A
git commit -m "Update backup"
HOME=/home/teamspeak git push
