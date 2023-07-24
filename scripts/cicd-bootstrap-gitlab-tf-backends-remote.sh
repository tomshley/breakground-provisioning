#!/usr/bin/env sh
export CI_PROJECT_DIR="/Volumes/sgoggles_ssd/⌐■_■-workbench/projects/tomshley/breakground-provisioning"

# shellcheck source=cicd-exports.sh
. "${CI_PROJECT_DIR}/scripts/cicd-bootstrap-gitlab.sh"

cd "${TF_BACKENDS_REMOTE_ROOT}" || exit

curl --silent "https://gitlab.com/gitlab-org/incubation-engineering/mobile-devops/download-secure-files/-/raw/main/installer" | bash

