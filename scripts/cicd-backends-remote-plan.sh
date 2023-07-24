#!/usr/bin/env sh
. "${CI_PROJECT_DIR}/scripts/cicd-bootstrap-gitlab-terraform-remote.sh"
make plan
