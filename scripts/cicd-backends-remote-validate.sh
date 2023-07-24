#!/usr/bin/env sh
. "${CI_PROJECT_DIR}/scripts/cicd-bootstrap-gitlab-terraform.sh"
cd "${TF_BACKENDS_REMOTE_ROOT}" || exit
make validate
