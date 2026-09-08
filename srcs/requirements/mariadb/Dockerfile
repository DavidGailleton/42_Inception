FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils

RUN mkdir -p /var/lib/mysql /run/mysqld \
  && chown -R mysql:mysql /var/lib/mysql /run/mysqld

ARG MYSQL_ROOT_PASSWORD=rootpass
ARG MYSQL_DATABASE=wordpress
ARG MYSQL_USER=wp_user
ARG MYSQL_PASSWORD=wp_pass

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db --rpm > /dev/null

RUN printf '%s\n' \
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
  > /tmp/bootstrap.sql \
  && mysqld --user=mysql --bootstrap --skip-networking < /tmp/bootstrap.sql \
  && rm /tmp/bootstrap.sql

EXPOSE 3306

CMD ["mysqld", "--user=mysql"]
