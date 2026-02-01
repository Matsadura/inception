#!/bin/bash
set -e

# 1. Define a logging function for clear output
log() {
    echo -e "\033[0;32m[Inception-WP] $(date +'%H:%M:%S')\033[0m $1"
}

log "Starting WordPress entrypoint script..."

# 2. Variable Validation (Helpful to debug empty variables)
if [ -z "$DB_PASSWORD_FILE" ] || [ -z "$WP_ADMIN_PASSWORD_FILE" ]; then
    echo "Error: Password secret files are not defined!"
    exit 1
fi

log "Reading secrets..."
DB_PASS=$(cat $DB_PASSWORD_FILE)
WP_ADMIN_PASS=$(cat $WP_ADMIN_PASSWORD_FILE)
WP_USER_PASS=$(cat $WP_USER_PASSWORD_FILE)

# 3. Wait for Database (With feedback)
log "Waiting for MariaDB connection on mariadb:3306..."
attempt=0
while ! (echo > /dev/tcp/mariadb/3306) >/dev/null 2>&1; do
    attempt=$((attempt+1))
    echo "  [Retrying...] MariaDB not reachable yet (Attempt $attempt)"
    sleep 2
done
log "Success: Connected to MariaDB!"

# 4. WordPress Installation
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    log "No wp-config.php found. Installing WordPress..."
    
    # Check permissions before starting
    log "Current directory owner: $(ls -ld /var/www/wordpress | awk '{print $3:$4}')"
    
    cd /var/www/wordpress

    log "Downloading WordPress Core..."
    wp core download --path=/var/www/wordpress --allow-root

    log "Creating config file..."
    wp config create --path=/var/www/wordpress --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb:3306 --allow-root

    log "Installing WordPress site..."
    wp core install --path=/var/www/wordpress --url=$DOMAINE_NAME --title="Inception" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

    log "Creating secondary user ($WP_USER)..."
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASS --role=author --path=/var/www/wordpress --allow-root
    
    log "WordPress installation finished."
else
    log "wp-config.php already exists. Skipping installation."
fi

# 5. Final startup
mkdir -p /run/php
log "Starting PHP-FPM..."

# Execute the CMD passed from Dockerfile (usually php-fpm -F)
exec "$@"