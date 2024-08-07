#!/bin/sh -e
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
# shellcheck source=cicd-exports.sh

. "/opt/tomshley/breakground-provisioning/cicd/bin/cicd-exports.sh"
. "/opt/tomshley/breakground-provisioning/cicd/bin/cicd-bootstrap-gitconfig.sh"
. "/opt/tomshley/breakground-provisioning/cicd/bin/cicd-bootstrap-gitlfs.sh"

CI_PROJECT_URL_TRIMMED=$(echo ${CI_PROJECT_URL} | sed 's/https\?:\/\///')
GITLAB_PROJECT_HTTPS_URL="https://${GITLAB_USER_LOGIN}:${GL_PASSWORD}@${CI_PROJECT_URL_TRIMMED}.git"
echo "${GITLAB_PROJECT_HTTPS_URL}"
git remote set-url origin "${GITLAB_PROJECT_HTTPS_URL}"

