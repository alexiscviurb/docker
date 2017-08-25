FROM alpine
MAINTAINER Alexis Cvirkun Urbanskyy <alexiscviurb@gmail.com>

RUN set -x \
	&& addgroup -g 82 -S www-data \
	&& adduser -u 82 -D -S -G www-data www-data

ENV GIT_PROTOCOL https
ENV GIT_BRANCH master
ENV GIT_TEST_FILE README.md
ENV GIT_FOLDER /data

RUN apk add --no-cache git

COPY up.sh /

CMD /up.sh
