FROM --platform=$BUILDPLATFORM alpine:3.18

ARG VERSION_BASH=5.2.15-r5
ARG VERSION_CERTS=20230506-r0

RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/community" >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add ca-certificates=${VERSION_CERTS} bash=${VERSION_BASH} && \
    rm -rf /var/cache/* && \
    mkdir /var/cache/apk -p
