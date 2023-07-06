env ?= .tfstate.env
include $(env)
export $(shell sed 's/=.*//' $(env))

init:
	terraform init \
    -backend-config=address=${TF_ADDRESS} \
    -backend-config=lock_address=${TF_ADDRESS}/lock \
    -backend-config=unlock_address=${TF_ADDRESS}/lock \
    -backend-config=username=${TF_USERNAME} \
    -backend-config=password=${TF_PASSWORD} \
    -backend-config=lock_method=POST \
    -backend-config=unlock_method=DELETE \
    -backend-config=retry_wait_min=5

migrate:
	terraform init \
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
	terraform init \
	-reconfigure \
    -backend-config=address=${TF_ADDRESS} \
    -backend-config=lock_address=${TF_ADDRESS}/lock \
    -backend-config=unlock_address=${TF_ADDRESS}/lock \
    -backend-config=username=${TF_USERNAME} \
    -backend-config=password=${TF_PASSWORD} \
    -backend-config=lock_method=POST \
    -backend-config=unlock_method=DELETE \
    -backend-config=retry_wait_min=5

# nb: https://developer.godaddy.com/keys?hbi_code=1
plan:
	terraform plan \
	-lock=true \
	-input=false \
	-var gitlab_token="${TF_PASSWORD}" \
	-var state_identifier="${PROJECT_ID}" \
	-var state_username="${TF_USERNAME}" \
	-var state_remote_host="${TF_HOST}" \
	-var artifactory_access_token="${ARTIFACTORY_ACCESS_TOKEN}" \
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
	-var gitlab_token="${TF_PASSWORD}" \
	-var state_identifier="${PROJECT_ID}" \
	-var state_username="${TF_USERNAME}" \
	-var state_remote_host="${TF_HOST}" \
	-var artifactory_access_token="${ARTIFACTORY_ACCESS_TOKEN}"
