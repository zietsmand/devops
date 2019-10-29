FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y \
        gnupg2 \
        curl \
        nano \
        nginx \
        supervisor \
        php \
        php-gd \
        php-fpm \
        php-intl \
        php-mysql \
        php-curl \
        php-phar \
        php-tokenizer \
        php-iconv \
        php-json \
        php-mbstring \
        php-oauth \
        php-opcache \
        php-pdo \
        php-fileinfo \
        php-sqlite3 \
        php-soap \
        php-zip \
        php-mysqli \
        php-simplexml \
        php-xmlwriter \
        php-xml \
        php-dev \
        php-pear

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install -y \
        mssql-tools \
        msodbcsql17 \
        unixodbc-dev \
    && pecl install \
        sqlsrv \
        pdo_sqlsrv \
    && printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.2/mods-available/sqlsrv.ini \
    && printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.2/mods-available/pdo_sqlsrv.ini \
    && phpenmod -v 7.2 sqlsrv pdo_sqlsrv \
    && mkdir -p /var/log/supervisor \
        /var/www/app \
        /run/php \
    && chown -R www-data:www-data \
        /var/www/app

ENV SERVER_NAME="localhost"
ENV SERVER_ALIAS=""
ENV SERVER_ROOT=/var/www/app
ENV TIMEZONE="Africa/Johannesburg"

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /nginx.conf
COPY default /etc/nginx/sites-available/default
COPY php-fpm-www.conf /etc/php/7.2/fpm/pool.d/www.conf
COPY entrypoint.sh /var/entrypoint.sh
COPY entrypoint.sh /var/entrypoint.sh

EXPOSE 80 443

RUN apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
    && chmod +x /var/entrypoint.sh

ENTRYPOINT [ "/var/entrypoint.sh" ]
