#!/usr/bin/env sh
curl --silent "https://gitlab.com/gitlab-org/incubation-engineering/mobile-devops/download-secure-files/-/raw/main/installer" | bash
mv "${SECURE_FILES_DOWNLOAD_PATH}/*" "${CURRENT_ROOT}/" || exit
