#!/usr/bin/env bash

cd $WP_ROUTE

wp core download --force --allow-root

wp config create --path=$WP_ROUTE --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST:$DB_PORT --dbprefix=wp_

# Only include port if it's not the default (80/443)
if [ "$NGINX_PORT" != "443" ] && [ "$NGINX_PORT" != "80" ]; then
    INSTALL_URL="${WP_URL}:${NGINX_PORT}"
else
    INSTALL_URL="${WP_URL}"
fi

if ! wp core is-installed --allow-root --path=$WP_ROUTE; then
wp core install --url=$INSTALL_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --allow-root
wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASS --allow-root
wp option update comments_notify 0 --allow-root --path=$WP_ROUTE
wp option update moderation_notify 0 --allow-root --path=$WP_ROUTE
fi

php-fpm8.2 -F
