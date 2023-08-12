FROM --platform=$BUILDPLATFORM docker/buildx-bin:v0.11 as buildx-bin
FROM --platform=$BUILDPLATFORM docker:24.0.5-dind-alpine3.18

COPY --from=buildx-bin /buildx /usr/libexec/docker/cli-plugins/docker-buildx

WORKDIR /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
