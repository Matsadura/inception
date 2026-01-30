#!/usr/bin/bash
set -e

DB_PASS=$(cat $DB_PASSWORD_FILE)
DB_ROOT_PASS=$(cat $DB_ROOT_PASSWORD_FILE)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [[ ! -d "/var/lib/mysql/$DB_NAME" ]]; then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
	mysqld --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
FLUSH PRIVILEGES;
EOF

fi

exec mysqld --user=mysql --bind-address=0.0.0.0
