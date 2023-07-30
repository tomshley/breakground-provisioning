#!/usr/bin/env sh
. "${CI_PROJECT_DIR}/scripts/cicd-bootstrap-gitlab.sh"
cd "${DOCKERS_LOCAL_ROOT}" || exit
make push
