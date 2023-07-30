#!/usr/bin/env sh
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
. "${CI_PROJECT_DIR}/scripts/cicd-exports.sh"

cd "${CI_PROJECT_DIR}" || exit

## credit: https://about.gitlab.com/blog/2017/09/05/how-to-automatically-create-a-new-mr-on-gitlab-with-gitlab-ci/
HOST="${CI_API_V4_URL}/projects/"

# This script was adapted from:
# https://about.gitlab.com/2017/09/05/how-to-automatically-create-a-new-mr-on-gitlab-with-gitlab-ci/

# TODO determine URL from git repository URL
#[[ $HOST =~ ^https?://[^/]+ ]] && HOST="${BASH_REMATCH[0]}/api/v4/projects/"

# The branch which we wish to merge into
TARGET_BRANCH=develop;

# The user's token name so that we can open the merge request as the user
TOKEN_NAME=`echo ${GITLAB_USER_LOGIN}_COMMIT_TOKEN | tr "[a-z]" "[A-Z]"`

# See: http://www.tldp.org/LDP/abs/html/parameter-substitution.html search ${!varprefix*}, ${!varprefix@} section
TEST_KEY=`echo ${!TOKEN_NAME}`

# The description of our new MR, we want to remove the branch after the MR has
# been closed
BODY="{
\"project_id\": ${CI_PROJECT_ID},
\"source_branch\": \"${CI_COMMIT_REF_NAME}\",
\"target_branch\": \"${TARGET_BRANCH}\",
\"remove_source_branch\": false,
\"force_remove_source_branch\": false,
\"allow_collaboration\": true,
\"subscribed\" : true,
\"title\": \"${GITLAB_USER_NAME} merge request for: ${CI_COMMIT_REF_SLUG}\"
}";

# Require a list of all the merge request and take a look if there is already
# one with the same source branch
LISTMR=`curl "${HOST}${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${TEST_KEY}"`;
#LISTMR=`curl --silent "${HOST}${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${TEST_KEY}"`;
COUNTBRANCHES=`echo ${LISTMR} | grep -o "\"source_branch\":\"${CI_COMMIT_REF_NAME}\"" | wc -l`;

# No MR found, let's create a new one
if [ ${COUNTBRANCHES} -eq "0" ]; then
  curl -X POST "${HOST}${CI_PROJECT_ID}/merge_requests" \
  --header "PRIVATE-TOKEN:${TEST_KEY}" \
  --header "Content-Type: application/json" \
  --data "${BODY}";

  echo "Opened a new merge request: WIP: ${CI_COMMIT_REF_SLUG} for user ${GITLAB_USER_LOGIN}";
  exit;
fi
echo "No new merge request opened"
    
#
## Look which is the default branch
##TARGET_BRANCH=`curl --silent "${CI_PROJECT_URL}${CI_PROJECT_ID}" --header "PRIVATE-TOKEN:${TEST_KEY}" | python3 -c "import sys, json; print(json.load(sys.stdin)['default_branch'])"`;
#TARGET_BRANCH=`curl "${CI_PROJECT_URL}${CI_PROJECT_ID}" --header "PRIVATE-TOKEN:${TEST_KEY}" | python3 -c "import sys, json; print(json.load(sys.stdin))"`;
#echo "${TARGET_BRANCH}"
#TARGET_BRANCH="develop"
#
## The description of our new MR, we want to remove the branch after the MR has
## been closed
#BODY="{
#    \"id\": ${CI_PROJECT_ID},
#    \"source_branch\": \"${CI_COMMIT_REF_NAME}\",
#    \"target_branch\": \"${TARGET_BRANCH}\",
#    \"remove_source_branch\": true,
#    \"title\": \"WIP: ${CI_COMMIT_REF_NAME}\",
#    \"assignee_id\":\"${GITLAB_USER_ID}\"
#}";
#
#echo "BODY: ${BODY}"
## Require a list of all the merge request and take a look if there is already
## one with the same source branch
##LISTMR=`curl --silent "${CI_PROJECT_URL}${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${TEST_KEY}"`;
#echo "${CI_PROJECT_URL}${CI_PROJECT_ID}/merge_requests?state=opened --header PRIVATE-TOKEN:${TEST_KEY}";
#LISTMR=`curl "${CI_PROJECT_URL}${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${TEST_KEY}"`;
#echo "LISTMR: ${LISTMR}"
#COUNTBRANCHES=`echo ${LISTMR} | grep -o "\"source_branch\":\"${CI_COMMIT_REF_NAME}\"" | wc -l`;
#echo "COUNTBRANCHES: ${COUNTBRANCHES}"
#
## No MR found, let's create a new one
#if [ ${COUNTBRANCHES} -eq "0" ]; then
#    curl -X POST "${CI_PROJECT_URL}${CI_PROJECT_ID}/merge_requests" \
#        --header "PRIVATE-TOKEN:${TEST_KEY}" \
#        --header "Content-Type: application/json" \
#        --data "${BODY}";
#
#    echo "Opened a new merge request: WIP: ${CI_COMMIT_REF_NAME} and assigned to you";
#    exit;
#fi
#
#echo "No new merge request opened";
