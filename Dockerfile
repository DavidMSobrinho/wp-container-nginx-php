FROM alpine:3.12.1 as builder

ENV VERSAO_WP 5.5.3


RUN apk update && \
    apk add curl && \
    curl -o wp.tar.gz -fSL "https://wordpress.org/wordpress-${VERSAO_WP}.tar.gz" && \
    tar -xzvf wp.tar.gz -C /tmp;

WORKDIR /tmp/wordpress


FROM nginx:1.19.3-alpine as wordpress-alpine-lxp

COPY --from=builder /tmp/wordpress /usr/share/nginx/html/

RUN apk update --no-cache && \
    apk add --no-cache php7-fpm php7-mysqli php7-json 

COPY default.conf /etc/nginx/conf.d/default.conf
COPY www.conf /etc/php7/php-fpm.d/www.conf

COPY config.php	   /usr/share/nginx/html/wp-config.php
COPY entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

