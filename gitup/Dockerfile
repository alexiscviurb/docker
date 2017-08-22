FROM alpine
MAINTAINER Alexis Cvirkun Urbanskyy <alexiscviurb@gmail.com>

ENV GIT_PROTOCOL https
ENV GIT_BRANCH master
ENV GIT_TEST_FILE README.md
ENV GIT_FOLDER /data

RUN apk add --no-cache git

COPY up.sh /

CMD /up.sh
