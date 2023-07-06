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
	-var gitlab_token="${TF_PASSWORD}" \
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
	-var gitlab_token="${TF_PASSWORD}" 