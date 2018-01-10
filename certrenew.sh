#!/usr/bin/env bash

# Stopping and Restarting so taht new SSL Certicates could be imported by NGINX
echo "Stopping NGINX Docker Container"
NX=$(</nginxservername.txt)

echo "Starting the renewal"
/usr/bin/certbot renew
echo "Renewal ended"

echo "Reload NGINX Docker Container"
docker exec ${NX} service nginx reload
