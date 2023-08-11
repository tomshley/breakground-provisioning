FROM --platform=$BUILDPLATFORM docker/buildx-bin:v0.11 as buildx-bin
FROM --platform=$BUILDPLATFORM docker:24.0.5-dind-alpine3.18

ARG VERSION_BASH=5.2.15-r5
ARG VERSION_CERTS=20230506-r0

COPY --from=buildx-bin /buildx /usr/libexec/docker/cli-plugins/docker-buildx

RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/v3.18/community" >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add ca-certificates=${VERSION_CERTS} bash=${VERSION_BASH} && \
    rm -rf /var/cache/* && \
    mkdir /var/cache/apk -p
