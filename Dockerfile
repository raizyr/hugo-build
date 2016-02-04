FROM alpine:3.3
MAINTAINER Chris McNabb <raizyr@gmail.com>

ENV HUGO_VERSION 0.15
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux_amd64

ENV S3CMD_VERSION 1.6.1
ENV S3CMD_BINARY s3cmd-${S3CMD_VERSION}

RUN apk add --no-cache perl git py-pygments py-dateutil

ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /usr/local/
RUN tar xzf /usr/local/${HUGO_BINARY}.tar.gz -C /usr/local/ \
	&& ln -s /usr/local/${HUGO_BINARY}/${HUGO_BINARY} /usr/local/bin/hugo \
	&& rm /usr/local/${HUGO_BINARY}.tar.gz

ADD https://github.com/s3tools/s3cmd/releases/download/v${S3CMD_VERSION}/${S3CMD_BINARY}.tar.gz /usr/local/
RUN tar xzf /usr/local/${S3CMD_BINARY}.tar.gz -C /usr/local/ \
  && ln -s /usr/local/${S3CMD_BINARY}/s3cmd /usr/local/bin/s3cmd \
  && rm /usr/local/${S3CMD_BINARY}.tar.gz

RUN mkdir /hugosite
WORKDIR /hugosite

EXPOSE 1313
CMD hugo version
