#!/usr/bin/env sh
# shellcheck source=cicd-exports.sh
. "${CI_PROJECT_DIR}/scripts/cicd-exports.sh"

cd "${TF_BACKENDS_REMOTE_ROOT}" || exit
curl --silent "https://gitlab.com/gitlab-org/incubation-engineering/mobile-devops/download-secure-files/-/raw/main/installer" | bash
