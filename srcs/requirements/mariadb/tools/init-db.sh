#!/bin/sh
set -e

if [ ! -d /var/lib/mysql/mysql ]; then
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db --rpm > /dev/null

  printf '%s\n' \
    "USE mysql;" \
    "FLUSH PRIVILEGES;" \
    "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" \
    "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" \
    "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;" \
    "DELETE FROM mysql.user WHERE User='';" \
    "DROP DATABASE IF EXISTS test;" \
    "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" \
    "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" \
    "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';" \
    "FLUSH PRIVILEGES;" \
    > /tmp/bootstrap.sql

  mariadbd --user=mysql --bootstrap --skip-networking < /tmp/bootstrap.sql
  rm /tmp/bootstrap.sql
fi

exec mariadbd --user=mysql --skip-networking=0 --bind-address=0.0.0.0
