FROM alpine:3.6

MAINTAINER Christian Mueller <christian.mueller@vr-worlds.de>

RUN apk add --no-cache bash certbot

COPY ./run.sh /run.sh

RUN chmod +x /run.sh

CMD ["/run.sh"]
