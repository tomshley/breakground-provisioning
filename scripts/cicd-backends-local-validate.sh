#!/usr/bin/env sh
. "${CI_PROJECT_DIR}/scripts/cicd-bootstrap-gitlab.sh"

cd "${TF_BACKENDS_LOCAL_ROOT}" || exit
