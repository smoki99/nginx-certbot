#!/usr/bin/env bash

echo "Starting Up Certification Imange"

# Check environment variable for nginx server is set

if [ -z "$NGINX"]; then
    echo "Error: Please set the variable NGINX, which defines the nginx server"
    exit 1
fi

if [ -z "$EMAIL"]; then
    echo "Error: Please set an emailaddress to used"
    exit 1
fi

if [ ! "$(docker ps -q -f name=$NGINX)" ]; then
    echo "Error: the defined docker container $NGINX is not running"
    exit 1
fi

echo ${NGINX} > /nginxservername.txt

echo "Error: create new domainkeys"
IFS=',' read -ra ADDR <<< "$domains"
for domain in "${ADDR[@]}"; do
    echo "Processing ${domain}"
    certbot certonly --verbose --noninteractive --quiet --standalone --agree-tos --email="${email}" -d "${domain}"
 done

# Start cron
/usr/sbin/crond -f -s /crontab.txt
