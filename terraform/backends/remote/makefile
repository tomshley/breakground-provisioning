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

env ?= .tfstate.env
include $(env)
export $(shell sed 's/=.*//' $(env))

clean:
	rm -rf .terraform .terraform.lock.hcl

artifact:
	tofu show -no-color .tfstate.plan > .tfstate.plan.txt
	tofu show -json .tfstate.plan | jq '[.resource_changes[] | select(.change.actions[0] != "no-op")] | length' > .tfstate.plan.changes
	tofu show -json .tfstate.plan | jq -r '([.resource_changes[].change.actions?]|flatten)|{"create":(map(select(.=="create"))|length),"update":(map(select(.=="update"))|length),"delete":(map(select(.=="delete"))|length)}' > .tfstate.plan.json

init:
	tofu init \
	-backend-config=address=${TF_ADDRESS} \
	-backend-config=lock_address=${TF_ADDRESS}/lock \
	-backend-config=unlock_address=${TF_ADDRESS}/lock \
	-backend-config=username=${TF_USERNAME} \
	-backend-config=password=${TF_PASSWORD} \
	-backend-config=lock_method=POST \
	-backend-config=unlock_method=DELETE \
	-backend-config=retry_wait_min=5

migrate:
	tofu init \
	-migrate-state \
	-backend-config=address=${TF_ADDRESS} \
	-backend-config=lock_address=${TF_ADDRESS}/lock \
	-backend-config=unlock_address=${TF_ADDRESS}/lock \
	-backend-config=username=${TF_USERNAME} \
	-backend-config=password=${TF_PASSWORD} \
	-backend-config=lock_method=POST \
	-backend-config=unlock_method=DELETE \
	-backend-config=retry_wait_min=5

reconfigure:
	tofu init \
	-reconfigure \
	-backend-config=address=${TF_ADDRESS} \
	-backend-config=lock_address=${TF_ADDRESS}/lock \
	-backend-config=unlock_address=${TF_ADDRESS}/lock \
	-backend-config=username=${TF_USERNAME} \
	-backend-config=password=${TF_PASSWORD} \
	-backend-config=lock_method=POST \
	-backend-config=unlock_method=DELETE \
	-backend-config=retry_wait_min=5

validate: init
	tofu fmt -recursive -diff -check

plan-no-lock: clean init
	tofu plan \
	-input=false \
	-var github_user="${GH_USERNAME}" \
	-var github_token="${GH_PASSWORD}" \
	-var github_owner_org="${GH_OWNER_ORG}" \
	-var github_mirror_token="${GH_MIRROR_TOKEN}" \
	-var gitlab_token="${GL_PASSWORD}" \
	-var state_identifier="${TF_PROJECT_ID}" \
	-var state_username="${TF_USERNAME}" \
	-var state_remote_host="${TF_HOST}" \
	-var artifactory_url="${ARTIFACTORY_URL}" \
	-var artifactory_access_token="${ARTIFACTORY_ACCESS_TOKEN}" \
	-out=.tfstate.plan

# nb: https://developer.godaddy.com/keys?hbi_code=1
_planonly:
	tofu plan \
	-lock=true \
	-input=false \
	-var github_user="${GH_USERNAME}" \
	-var github_token="${GH_PASSWORD}" \
	-var github_owner_org="${GH_OWNER_ORG}" \
	-var github_mirror_token="${GH_MIRROR_TOKEN}" \
	-var gitlab_token="${GL_PASSWORD}" \
	-var state_identifier="${TF_PROJECT_ID}" \
	-var state_username="${TF_USERNAME}" \
	-var state_remote_host="${TF_HOST}" \
	-var artifactory_url="${ARTIFACTORY_URL}" \
	-var artifactory_access_token="${ARTIFACTORY_ACCESS_TOKEN}" \
	-out=.tfstate.plan

plan: clean init _planonly artifact

_applyonly:
	tofu apply \
	-input=false \
	-auto-approve=true \
	-lock=true \
	.tfstate.plan

apply: clean init _planonly _applyonly artifact

destroy: init
	tofu destroy \
	-lock=true \
	-var github_user="${GH_USERNAME}" \
	-var github_token="${GH_PASSWORD}" \
	-var github_owner_org="${GH_OWNER_ORG}" \
	-var github_mirror_token="${GH_MIRROR_TOKEN}" \
	-var gitlab_token="${GL_PASSWORD}" \
	-var state_identifier="${TF_PROJECT_ID}" \
	-var state_username="${TF_USERNAME}" \
	-var state_remote_host="${TF_HOST}" \
	-var artifactory_url="${ARTIFACTORY_URL}" \
	-var artifactory_access_token="${ARTIFACTORY_ACCESS_TOKEN}"
