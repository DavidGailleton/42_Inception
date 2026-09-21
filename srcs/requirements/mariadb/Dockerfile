FROM alpine:3.24

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils

RUN mkdir -p /var/lib/mysql /run/mysqld \
  && chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY tools/init-db.sh /usr/local/bin/init-db.sh
RUN chmod +x /usr/local/bin/init-db.sh

EXPOSE 3306

CMD ["init-db.sh"]
