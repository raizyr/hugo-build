FROM alpine:3.3
MAINTAINER Chris McNabb <raizyr@gmail.com>

ENV HUGO_VERSION 0.15
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux_amd64

RUN apk add --no-cache perl git py-pygments

ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /usr/local/
RUN tar xzf /usr/local/${HUGO_BINARY}.tar.gz -C /usr/local/ \
	&& ln -s /usr/local/${HUGO_BINARY}/${HUGO_BINARY} /usr/local/bin/hugo \
	&& rm /usr/local/${HUGO_BINARY}.tar.gz

RUN mkdir /hugosite
WORKDIR /hugosite

EXPOSE 1313
CMD hugo version
