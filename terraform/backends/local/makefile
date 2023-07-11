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

init:
	terraform init 
    
migrate:
	terraform init \
	-migrate-state

reconfigure:
	terraform init \
	-reconfigure

plan:
	terraform fmt --recursive && terraform plan \
	-lock=true \
	-input=false \
	-var github_user="${GH_USERNAME}" \
	-var github_token="${GH_PASSWORD}" \
	-var github_owner_org="${GH_OWNER_ORG}" \
	-var github_mirror_token="${GH_MIRROR_TOKEN}" \
	-var gitlab_token="${GL_PASSWORD}" \
	-out=.tfstate.plan

apply:
	terraform apply \
	-input=false \
	-auto-approve=true \
	-lock=true \
	.tfstate.plan

destroy:
	terraform destroy \
	-lock=true \
	-var gitlab_token="${GL_PASSWORD}"
