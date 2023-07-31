#!/bin/sh -e
#
# Copyright 2023 Tomshley LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# @author Thomas Schena @sgoggles <https://github.com/sgoggles> | <https://gitlab.com/sgoggles>
#
. "/usr/bin/cicd-exports.sh"

cd "${CI_PROJECT_DIR}" || exit

curl --silent "https://gitlab.com/gitlab-org/incubation-engineering/mobile-devops/download-secure-files/-/raw/main/installer" | bash
if test -f "${CI_PROJECT_DIR}/.tfstate.env"; then
  # shellcheck disable=SC1097
  while IFS== read -r key value; do
    # shellcheck disable=SC2163
    printf -v "$key" %s "$value" && export "$key"
  done <"${CI_PROJECT_DIR}/.tfstate.env"
fi
