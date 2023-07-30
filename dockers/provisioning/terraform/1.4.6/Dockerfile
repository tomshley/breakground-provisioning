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

FROM --platform=$BUILDPLATFORM registry.gitlab.com/tomshley/breakground-provisioning/lang_python3:3.11

ARG VERSION_JQ=1.6-r3
ARG VERSION_OPENSSL=3.1.1-r3
ARG VERSION_ALPINE_TERRAFORM=1.4.6-r1
ARG VERSION_GIT=2.40.1-r0
ARG VERSION_MAKE=4.4.1-r1
ARG VERSION_GCOMPAT=1.1.0-r1
ARG VERSION_OPENSSH=9.3_p2-r0
ARG VERSION_CURL=8.2.1-r0
ARG VERSION_GITFLOW=1.12.3-r1

RUN apk add --no-cache \
      git-flow=${VERSION_GITFLOW} \
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

COPY files/cicd-backends-local-validate.sh /usr/bin/cicd-backends-local-validate.sh
COPY files/cicd-backends-remote-plan-apply.sh /usr/bin/cicd-backends-remote-plan-apply.sh
COPY files/cicd-backends-remote-plan.sh /usr/bin/cicd-backends-remote-plan.sh
COPY files/cicd-backends-remote-validate.sh /usr/bin/cicd-backends-remote-validate.sh
COPY files/cicd-bootstrap-gitconfig.sh /usr/bin/cicd-bootstrap-gitconfig.sh
COPY files/cicd-bootstrap-gitlab-dockers.sh /usr/bin/cicd-bootstrap-gitlab-dockers.sh
COPY files/cicd-bootstrap-gitlab-tf-backends-local.sh /usr/bin/cicd-bootstrap-gitlab-tf-backends-local.sh
COPY files/cicd-bootstrap-gitlab-tf-backends-remote.sh /usr/bin/cicd-bootstrap-gitlab-tf-backends-remote.sh
COPY files/cicd-bootstrap-gitlab.sh /usr/bin/cicd-bootstrap-gitlab.sh
COPY files/cicd-dockers-build-push.sh /usr/bin/cicd-dockers-build-push.sh
COPY files/cicd-dockers-build.sh /usr/bin/cicd-dockers-build.sh
COPY files/cicd-exports.sh /usr/bin/cicd-exports.sh
COPY files/cicd-flow-feature-gitlab-merge-request.sh /usr/bin/cicd-flow-feature-gitlab-merge-request.sh
COPY files/cicd-flow-feature-update.sh /usr/bin/cicd-flow-feature-update.sh
COPY files/cicd-flow-release-finish.sh /usr/bin/cicd-flow-release-finish.sh
COPY files/cicd-flow-release-publish.sh /usr/bin/cicd-flow-release-publish.sh
COPY files/cicd-flow-release-start.sh /usr/bin/cicd-flow-release-start.sh
COPY files/gitlab-terraform.sh /usr/bin/gitlab-terraform.sh

RUN chmod +x /usr/bin/cicd-backends-local-validate.sh
RUN chmod +x /usr/bin/cicd-backends-remote-plan-apply.sh
RUN chmod +x /usr/bin/cicd-backends-remote-plan.sh
RUN chmod +x /usr/bin/cicd-backends-remote-validate.sh
RUN chmod +x /usr/bin/cicd-bootstrap-gitconfig.sh
RUN chmod +x /usr/bin/cicd-bootstrap-gitlab-dockers.sh
RUN chmod +x /usr/bin/cicd-bootstrap-gitlab-tf-backends-local.sh
RUN chmod +x /usr/bin/cicd-bootstrap-gitlab-tf-backends-remote.sh
RUN chmod +x /usr/bin/cicd-bootstrap-gitlab.sh
RUN chmod +x /usr/bin/cicd-dockers-build-push.sh
RUN chmod +x /usr/bin/cicd-dockers-build.sh
RUN chmod +x /usr/bin/cicd-exports.sh
RUN chmod +x /usr/bin/cicd-flow-feature-gitlab-merge-request.sh
RUN chmod +x /usr/bin/cicd-flow-feature-update.sh
RUN chmod +x /usr/bin/cicd-flow-release-finish.sh
RUN chmod +x /usr/bin/cicd-flow-release-publish.sh
RUN chmod +x /usr/bin/cicd-flow-release-start.sh
RUN chmod +x /usr/bin/gitlab-terraform.sh

# use this for direct access to TF, not for GitLab Usage: ENTRYPOINT ["terraform"]
ENTRYPOINT []
