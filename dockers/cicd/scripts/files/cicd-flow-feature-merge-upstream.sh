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
. "/opt/tomshley/breakground-provisioning/cicd/bin/cicd-exports.sh"
. "/opt/tomshley/breakground-provisioning/cicd/bin/cicd-bootstrap-envvars-gitlab.sh"

cd "${CI_PROJECT_DIR}" || exit


# set the -sbt- build to release not, snapshot
echo "integration script running ${TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT}"

. "/opt/tomshley/breakground-provisioning/cicd/bin/cicd-bootstrap-gitlab-gitconfig.sh"


export GIT_MERGE_AUTOEDIT=no
git checkout develop
git pull origin develop --rebase --prune
git checkout "${GITLAB_CI_BRANCH}"
git merge --no-ff --no-edit develop -m "${TOMSHLEY_MERGE_INTEGRATION_MESSAGE}"
git push origin "${GITLAB_CI_BRANCH}"
