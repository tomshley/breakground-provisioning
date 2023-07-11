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
	terraform plan \
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