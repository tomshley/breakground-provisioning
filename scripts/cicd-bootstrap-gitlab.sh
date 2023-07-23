#!/usr/bin/env sh
# shellcheck source=cicd-exports.sh
. cicd-exports.sh

cd "${TF_ROOT}" || exit
curl --silent "https://gitlab.com/gitlab-org/incubation-engineering/mobile-devops/download-secure-files/-/raw/main/installer" | bash
