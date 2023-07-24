#!/usr/bin/env sh
# shellcheck source=cicd-exports.sh
. "${CI_PROJECT_DIR}/scripts/cicd-bootstrap-gitlab.sh"

cd "${TF_BACKENDS_REMOTE_ROOT}" || exit
export CURRENT_ROOT="${TF_BACKENDS_REMOTE_ROOT}"

. "${CI_PROJECT_DIR}/scripts/cicd-utility-gitlab-grab-secure-files.sh"
