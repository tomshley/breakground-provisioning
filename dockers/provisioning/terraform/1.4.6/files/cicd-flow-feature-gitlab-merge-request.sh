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
. "${PWD}/cicd-exports.sh"

cd "${CI_PROJECT_DIR}" || exit

curl --silent "https://gitlab.com/gitlab-org/incubation-engineering/mobile-devops/download-secure-files/-/raw/main/installer" | bash
if test -f "${CI_PROJECT_DIR}/.tfstate.env"; then
  # shellcheck disable=SC1097
  while IFS== read -r key value; do
    # shellcheck disable=SC2163
    printf -v "$key" %s "$value" && export "$key"
  done <"${CI_PROJECT_DIR}/.tfstate.env"
fi

## credit: https://about.gitlab.com/blog/2017/09/05/how-to-automatically-create-a-new-mr-on-gitlab-with-gitlab-ci/
GITLAB_API_PROJECT_HOST="${CI_API_V4_URL}/projects/"

TARGET_BRANCH=develop;

GL_MERGE_REQUEST_BODY="{
\"project_id\": ${CI_PROJECT_ID},
\"source_branch\": \"${CI_COMMIT_REF_NAME}\",
\"target_branch\": \"${TARGET_BRANCH}\",
\"remove_source_branch\": false,
\"force_remove_source_branch\": false,
\"allow_collaboration\": true,
\"subscribed\" : true,
\"title\": \"WIP: ${CI_COMMIT_REF_NAME}\",
\"assignee_id\":\"${GITLAB_USER_ID}\"
}";

# An alternate example of \"title\": \"${GITLAB_USER_NAME} merge request for: ${CI_COMMIT_REF_SLUG}\"

EXISTING_REQUESTS_FOR_BRANCH=`curl --silent "${GITLAB_API_PROJECT_HOST}${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${GL_PASSWORD}" | python3 -c "import os, sys, json; print(len([x for x in json.load(sys.stdin) if x.get('source_branch') == os.environ.get('CI_COMMIT_REF_NAME')]))"`;

if [ ${EXISTING_REQUESTS_FOR_BRANCH} -eq "0" ]; then
  curl -X POST "${GITLAB_API_PROJECT_HOST}${CI_PROJECT_ID}/merge_requests" \
  --header "PRIVATE-TOKEN:${GL_PASSWORD}" \
  --header "Content-Type: application/json" \
  --data "${GL_MERGE_REQUEST_BODY}";

  echo "Opened a new merge request: WIP: ${CI_COMMIT_REF_SLUG} for user ${GITLAB_USER_LOGIN}";
  exit;
fi
  echo "No new merge request opened"
