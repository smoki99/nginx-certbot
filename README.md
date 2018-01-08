# Demo in Development enhance nginx with certbot recertication functions

Example "docker-compose.yml"

```
  nginx-certbot:
     container_name: nginx-certbot
     image: smoki99/nginx-certbot
     network_mode: bridge
     volumes_from:
       - nginxserver
     volumes:
       - /home/data/nginx/certs/:/etc/letsencrypt:rw
       - /var/run/docker.sock:/var/run/docker.sock
     environment:
       - NGINX=nginxserver
       - EMAIL=your@domain.com
       - domains=domain1.de,www.domain2.de,domain3.com
```
