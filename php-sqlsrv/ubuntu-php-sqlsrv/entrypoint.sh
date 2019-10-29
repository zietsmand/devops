#!/bin/sh -e

cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime 
echo "$TIMEZONE" > /etc/timezone

SERVER_NAME=${VIRTUAL_HOST:-${SERVER_NAME:-localhost}}

envsubst '$SERVER_NAME $SERVER_ALIAS $SERVER_ROOT' < /nginx.conf > /etc/nginx/nginx.conf

supervisord -c /etc/supervisor/conf.d/supervisord.conf
