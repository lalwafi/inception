#!/usr/bin/env bash

set -e

# Ensure datadir exists
mkdir -p $DB_INSTALL
chown mysql:mysql $DB_INSTALL

# Initialize database if needed
if [ ! -d "$DB_INSTALL/mysql" ]; then
    mysql_install_db --datadir=$DB_INSTALL --user=mysql
fi

# Configure bind address
echo >> $DB_CONF_ROUTE
echo "[mysqld]" >> $DB_CONF_ROUTE
echo "bind-address=0.0.0.0" >> $DB_CONF_ROUTE
echo "port=$DB_PORT" >> $DB_CONF_ROUTE

# Start MariaDB
mysqld_safe &
mysql_pid=$!

# Wait for MariaDB to be ready
until mysqladmin ping >/dev/null 2>&1; do
  echo -n "."; sleep 0.2
done

# Create database and users (only on first initialization)
if [ ! -d "$DB_INSTALL/$DB_NAME" ]; then
    mysql -u root << SQL
CREATE DATABASE IF NOT EXISTS $DB_NAME;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
FLUSH PRIVILEGES;
SQL
fi

# Keep container running
wait $mysql_pid
