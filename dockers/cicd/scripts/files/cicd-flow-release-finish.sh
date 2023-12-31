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

. "/opt/tomshley/breakground-provisioning/cicd/bin/cicd-bootstrap-gitlab-gitconfig.sh"
. "/opt/tomshley/breakground-provisioning/cicd/bin/cicd-flow-release-publish-prep.sh"


export GIT_MERGE_AUTOEDIT=no
git checkout main
git pull origin main --rebase --prune
git merge --no-ff --no-edit release/${TOMSHLEY_BREAKGROUND_BUILD_VERSION} -m "${TOMSHLEY_FLOW_RELEASE_FINISH_MESSAGE} | main"
git tag -a ${TOMSHLEY_BREAKGROUND_BUILD_VERSION} -m "${TOMSHLEY_FLOW_RELEASE_FINISH_MESSAGE}"
git checkout develop
git pull origin develop --rebase --prune
git merge --no-ff --no-edit release/${TOMSHLEY_BREAKGROUND_BUILD_VERSION} -m "${TOMSHLEY_FLOW_RELEASE_FINISH_MESSAGE} | develop | [skip ci]"; \
git branch -d release/${TOMSHLEY_BREAKGROUND_BUILD_VERSION}
git push origin main
git push origin develop
git push origin --tags
git push origin :release/${TOMSHLEY_BREAKGROUND_BUILD_VERSION}
unset GIT_MERGE_AUTOEDIT
