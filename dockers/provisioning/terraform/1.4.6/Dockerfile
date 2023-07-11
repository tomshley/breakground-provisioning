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

FROM --platform=$BUILDPLATFORM registry.gitlab.com/tomshley/breakground-provisioning/os_alpine:3.16

ARG VERSION_JQ=1.6-r3
ARG VERSION_OPENSSL=3.1.1-r1
ARG VERSION_ALPINE_TERRAFORM=1.5.2-r0
ARG VERSION_GIT=2.40.1-r0
ARG VERSION_MAKE=4.4.1-r1
ARG VERSION_GCOMPAT=1.1.0-r1
ARG VERSION_OPENSSH=9.3_p1-r3
ARG VERSION_CURL=8.1.2-r0

RUN apk add --no-cache \
      jq=${VERSION_JQ} \
      openssl=${VERSION_OPENSSL} \
      git=${VERSION_GIT} \
      make=${VERSION_MAKE} \
      curl=${VERSION_CURL} \
      openssh=${VERSION_OPENSSH} \
      gcompat=${VERSION_GCOMPAT} && \
    echo "@edge-community https://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
    apk add \
      --no-cache \
      terraform@edge-community=${VERSION_ALPINE_TERRAFORM} && \
    rm -rf /var/cache/* && \
    mkdir /var/cache/apk -p

WORKDIR /
COPY files/gitlab-terraform.sh /usr/bin/gitlab-terraform
RUN chmod +x /usr/bin/gitlab-terraform

# use this for direct access to TF, not for GitLab Usage: ENTRYPOINT ["terraform"]
ENTRYPOINT []
