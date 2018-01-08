#!/usr/bin/env bash

# Stopping and Restarting so taht new SSL Certicates could be imported by NGINX
echo "Stopping NGINX Docker Container"
NX=$(</nginxservername.txt)

docker stop ${NX}

echo "Starting the renewal"
/usr/bin/certbot renew
echo "Renewal ended"

echo "Starting NGINX Docker Container"
docker start ${NX}
