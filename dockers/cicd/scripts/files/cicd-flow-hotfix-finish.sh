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

# Step 1: Checkout a branch we can commit to
echo "Running Hotfix Finish"
echo "Running Hotfix Finish: fetch"
git fetch
echo "Running Hotfix Finish: checkout"
git checkout "${GITLAB_CI_BRANCH}"
echo "Running Hotfix Finish: branch"
git branch --set-upstream-to origin/"${GITLAB_CI_BRANCH}"
echo "Running Hotfix Finish: pull"
git pull origin "${GITLAB_CI_BRANCH}" --rebase --prune

# Step 2: Bump the version and commit. Assume on hotfix branch
echo "${TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT}" > "${TOMSHLEY_PROJECT_VERSION_SRC}"
echo "Running Hotfix Finish: add to git"
git add "${TOMSHLEY_PROJECT_VERSION_SRC}"
echo "Running Hotfix Finish: commit"
git commit -m "$(git log --format='%B' -n 1) | bumping version to ${TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT}"
echo "Running Hotfix Finish: push"
git push --set-upstream origin "${GITLAB_CI_BRANCH}"

# Step 3: run the git flow sequence for hotfix and tag
export GIT_MERGE_AUTOEDIT=no
git checkout main
git pull origin main --rebase --prune
git merge --no-ff --no-edit "${GITLAB_CI_BRANCH}" -m "${TOMSHLEY_FLOW_HOTFIX_FINISH_MESSAGE} | main"
git tag -a ${TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT} -m "${TOMSHLEY_FLOW_HOTFIX_FINISH_MESSAGE}"
git checkout develop
git pull origin develop --rebase --prune
git merge --no-ff --no-edit "${GITLAB_CI_BRANCH}" -m "${TOMSHLEY_FLOW_HOTFIX_FINISH_MESSAGE} | develop | [skip ci]"; \
git branch -d "${GITLAB_CI_BRANCH}"
git push origin main
git push origin develop
git push origin --tags
git push origin :"${GITLAB_CI_BRANCH}"
unset GIT_MERGE_AUTOEDIT
