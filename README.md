# Demo in Development enhance nginx with certbot recertication functions

Example "docker-compose.yml"

```
  nginx-certbot:
     container_name: nginx-certbot
     image: smoki99/nginx-certbot:latest
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

It is important that the nginx also exposes the volume:

* /usr/share/nginx/html

Alternate the command to start the certbot temporarily:
```
docker run -e NGINX=nginxserver -e EMAIL=your@domain.com -e domains=domain1.de,www.domain2.de,domain3.com -v /var/run/docker.sock:/var/run/docker.sock -v /home/data/Nginx/certs/:/etc/letsencrypt:rw -v /usr/share/ --volumes-from nginxserver smoki99/nginx-certbot:latest

```

Add in the localhost.conf of NGINX for each server this path for the authentication of the domain

```
  location /.well-known/ {
     root /usr/share/nginx/html;
     allow all;
     default_type "text/plain";
  }
```

After the certicates where sucessfull created you should find them in your defined certs directory in "live" subdirectory:

```
[root@CentOS-73-64-minimal live]# pwd
/home/data/Nginx/certs/live
[root@CentOS-73-64-minimal live]# ls
domain1.de www.domain2.de domain3.com
```

When the certificates was successfully created you can add them to your localhost.conf:

```
server {
  listen 0.0.0.0:443;
  server_name www.domain2.de;
  access_log /var/log/nginx/domain2.log;

  ssl on;
  ssl_certificate /etc/nginx/certs/live/www.domain2.de/fullchain.pem;
  ssl_certificate_key /etc/nginx/certs/live/www.domain2.de/privkey.pem;
  ssl_session_cache shared:SSL:10m;

  location / {
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header HOST $http_host;
      proxy_set_header X-NginX-Proxy true;

      proxy_pass http://XXXXXXX:2368;
      proxy_redirect off;
  }
client_max_body_size 10M; # Allow 10 MB files to be uploaded
}

```
