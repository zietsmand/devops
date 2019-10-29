#!/bin/sh -e

cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime 
echo "$TIMEZONE" > /etc/timezone

# jwilder/nginx-proxy support
SERVER_NAME=${VIRTUAL_HOST:-${SERVER_NAME:-localhost}}

envsubst '$SERVER_NAME $SERVER_ALIAS $SERVER_ROOT' < /nginx.conf > /etc/nginx/nginx.conf

supervisord -c /supervisord.conf
