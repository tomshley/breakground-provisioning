#!/usr/bin/env sh
. "${CI_PROJECT_DIR}/scripts/cicd-bootstrap-gitlab-tf-local-remote.sh"
make validate
