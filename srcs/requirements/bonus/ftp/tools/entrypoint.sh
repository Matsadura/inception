#!/bin/bash
set -e

adduser --disabled-password --gecos "" --home /var/www/wordpress $FTP_USER
echo "$FTP_USER:$(cat $FTP_PASSWORD_FILE)" | chpasswd
echo "$FTP_USER" >> /etc/vsftpd.userlist
chown -R $FTP_USER:$FTP_USER /var/www/wordpress

exec "$@"