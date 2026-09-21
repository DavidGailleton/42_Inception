FROM alpine:3.24

RUN apk update && apk add --no-cache \
  php83-fpm \
  php83-mysqli \
  php83-curl \
  php83-dom \
  php83-exif \
  php83-fileinfo \
  php83-gd \
  php83-intl \
  php83-mbstring \
  php83-openssl \
  php83-phar \
  php83-session \
  php83-simplexml \
  php83-xml \
  php83-zip

# Listen on all interfaces so nginx (another container) can reach php-fpm
RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php83/php-fpm.d/www.conf

WORKDIR /var/www

RUN wget -q https://wordpress.org/latest.tar.gz \
  && tar xf latest.tar.gz \
  && rm latest.tar.gz \
  && chown -R nobody:nobody /var/www/wordpress

EXPOSE 9000

# -F: stay in the foreground so the container keeps running
CMD ["php-fpm83", "-F"]
