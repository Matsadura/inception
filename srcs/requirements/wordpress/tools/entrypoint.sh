#!/bin/bash
set -e

DB_PASS=$(cat $DB_PASSWORD_FILE)
WP_ADMIN_PASS=$(cat $WP_ADMIN_PASSWORD_FILE)
WP_USER_PASS=$(cat $WP_USER_PASSWORD_FILE)

while ! (echo > /dev/tcp/mariadb/3306) >/dev/null 2>&1; do
    sleep 2
done

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    cd /var/www/wordpress
    wp core download --path=/var/www/wordpress --allow-root
    wp config create --path=/var/www/wordpress --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb:3306 --allow-root
    wp core install --path=/var/www/wordpress --url=$DOMAINE_NAME --title="Inception" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASS --role=author --path=/var/www/wordpress --allow-root
fi

mkdir -p /run/php

exec "$@"