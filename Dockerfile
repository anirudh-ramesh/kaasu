FROM alpine:3.15

MAINTAINER Anirudh Ramesh

RUN apk add sqlite
RUN apk add catdoc --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

RUN mkdir /source /destination

COPY crontab /etc/crontabs/root
COPY entrypoint.sh /entrypoint.sh
COPY decode.sh /decode.sh
COPY init.sql /init.sql

RUN cat /init.sql | sqlite3 /store.db
RUN rm /init.sql

RUN chmod 755 /entrypoint.sh

ENTRYPOINT /entrypoint.sh
