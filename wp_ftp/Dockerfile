FROM wordpress:5.2-php7.1-apache

RUN apt-get update \
    && apt-get install vsftpd -y

COPY docker-entrypoint.sh /usr/local/bin/
COPY vsftpd.conf /etc/vsftpd.conf

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80 21

CMD ["apache2-foreground"]
