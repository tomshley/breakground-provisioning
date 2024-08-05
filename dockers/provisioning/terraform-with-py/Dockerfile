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
ARG TOMSHLEY_DOCKERS_BUILD_REF
FROM --platform=$BUILDPLATFORM docker/buildx-bin:v0.11 as buildx-bin
FROM --platform=$BUILDPLATFORM cicd_scripts_docker_build_ref as cicd-scripts
FROM --platform=$BUILDPLATFORM os_alpine_docker_build_ref

ENV PYTHONUNBUFFERED=1

COPY --from=buildx-bin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
COPY --from=cicd-scripts /opt/tomshley/breakground-provisioning/cicd/bin/. /opt/tomshley/breakground-provisioning/cicd/bin/

RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
      echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
      echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
      apk update && \
      apk upgrade && \
      apk add --no-cache \
      iptables@edge \
      libseccomp@edge && \
    apk add --no-cache \
      bash \
      jq \
      openssl \
      make \
      curl \
      openssh \
      gcompat \
      git-flow \
      git-lfs \
      git \
      python3 && \
    apk add --no-cache \
      docker@community \
      docker-cli-buildx@community \
      docker-cli-compose@community && \
    apk add --no-cache \
      opentofu@testing && \
    rm -rf /var/cache/* && \
    mkdir /var/cache/apk -p && \
    cd /usr/local/bin && \
    ln -sf python3 /usr/bin/python && \
    ln -s /opt/tomshley/breakground-provisioning/cicd/bin/*/ .

WORKDIR /

# use this for direct access to TF, not for GitLab Usage: ENTRYPOINT ["terraform"]
ENTRYPOINT []
