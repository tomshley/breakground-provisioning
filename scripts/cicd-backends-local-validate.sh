#!/usr/bin/env sh
. "${CI_PROJECT_DIR}/scripts/cicd-bootstrap-gitlab-tf-backends-local.sh"

make validate
