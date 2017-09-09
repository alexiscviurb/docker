FROM node:alpine

MAINTAINER Alexis Cvirkun Urbanskyy <alexiscviurb@gmail.com>

ENV APP_DATA /data

RUN npm install -g --unsafe-perm @angular/cli

EXPOSE 4200

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
