FROM alpine:3.6

MAINTAINER Christian Mueller <christian.mueller@vr-worlds.de>

RUN apk add --no-cache bash certbot

# Install also docker with connection, so that we can restart nginx
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update
RUN apk add docker

COPY ./crontab.txt /crontab.txt
COPY ./run.sh /run.sh
COPY ./certrenew.sh /certrenew.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
