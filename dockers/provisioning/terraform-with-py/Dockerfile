#
# Copyright 2023 Tomshley LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# @author Thomas Schena @sgoggles <https://github.com/sgoggles> | <https://gitlab.com/sgoggles>
#
FROM --platform=$BUILDPLATFORM docker/buildx-bin:v0.11 as buildx-bin
FROM --platform=$BUILDPLATFORM registry.gitlab.com/tomshley/breakground-provisioning/cicd_scripts:latest as cicd-scripts
FROM --platform=$BUILDPLATFORM registry.gitlab.com/tomshley/breakground-provisioning/os_alpine:3.16

ARG VERSION_JQ=1.6-r3
ARG VERSION_OPENSSL=3.1.3-r0
ARG VERSION_GIT=2.40.1-r0
ARG VERSION_MAKE=4.4.1-r1
ARG VERSION_GCOMPAT=1.1.0-r1
ARG VERSION_OPENSSH=9.3_p2-r0
ARG VERSION_CURL=8.3.0-r0
ARG VERSION_GITFLOW=1.12.3-r1
ARG VERSION_ALPINE_EDGE_DOCKER=23.0.6-r5
ARG VERSION_ALPINE_EDGE_DOCKER_COMPOSE=2.17.3-r6
ARG VERSION_ALPINE_EDGE_TERRAFORM=1.4.6-r3
ARG VERSION_PYTHON3=3.11.5-r0
ENV PYTHONUNBUFFERED=1

COPY --from=buildx-bin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
COPY --from=cicd-scripts /opt/tomshley/breakground-provisioning/cicd/bin/. /opt/tomshley/breakground-provisioning/cicd/bin/

RUN apk add --no-cache \
      git-flow=${VERSION_GITFLOW} \
      jq=${VERSION_JQ} \
      openssl=${VERSION_OPENSSL} \
      git=${VERSION_GIT} \
      make=${VERSION_MAKE} \
      curl=${VERSION_CURL} \
      openssh=${VERSION_OPENSSH} \
      python3=${VERSION_PYTHON3} \
      gcompat=${VERSION_GCOMPAT} && \
    echo "@edge-community https://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
    apk add \
      --no-cache \
      terraform@edge-community=${VERSION_ALPINE_EDGE_TERRAFORM} \
      docker@edge-community=${VERSION_ALPINE_EDGE_DOCKER} \
      docker-cli-compose@edge-community=${VERSION_ALPINE_EDGE_DOCKER_COMPOSE} && \
    rm -rf /var/cache/* && \
    mkdir /var/cache/apk -p && \
    cd /usr/local/bin && \
    ln -sf python3 /usr/bin/python && \
    ln -s /opt/tomshley/breakground-provisioning/cicd/bin/*/ .

WORKDIR /

# use this for direct access to TF, not for GitLab Usage: ENTRYPOINT ["terraform"]
ENTRYPOINT []
