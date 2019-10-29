#############################################################
#                                                           #
#   CURRENTLY NOT SUPPORTED, KEEPING THIS FOR WHEN IT IS    #
#   https://github.com/Microsoft/msphpsql/issues/300        #
#                                                           #
#############################################################

FROM cooptilleuls/php-mssql-alpine:7.2-fpm

RUN apk add --no-cache --update tini

COPY --from=ochinchina/supervisord:latest /usr/local/bin/supervisord /usr/bin/supervisord

RUN apk add --no-cache --update \
        bash \
        nano \
        nginx \
        tzdata \
        icu-dev \
        gettext \
    && mkdir -p \
        /var/cache/nginx /var/www/app \
    && chown -R www-data:www-data \
        /var/cache/nginx /var/lib/nginx /var/tmp/nginx /var/www/app \
    && rm /usr/local/etc/php-fpm.d/*

RUN docker-php-ext-install \
        intl \
        pdo_mysql \
        mysqli

RUN apk add --no-cache --update \
        unixodbc-dev

ENV SERVER_NAME="localhost"
ENV SERVER_ALIAS=""
ENV SERVER_ROOT=/var/www/app
ENV TIMEZONE="Africa/Johannesburg"

COPY supervisord.conf /supervisord.conf
COPY php-fpm-www.conf /usr/local/etc/php-fpm.d/www.conf
COPY nginx.conf /nginx.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
WORKDIR /var/www/app

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
