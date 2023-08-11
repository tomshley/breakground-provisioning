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
# shellcheck source=cicd-exports.sh
. "/opt/tomshley/breakground-provisioning/cicd/bin/cicd-bootstrap-gitlab.sh"

cd "${DOCKERS_LOCAL_ROOT}" || exit

curl --silent "https://gitlab.com/gitlab-org/incubation-engineering/mobile-devops/download-secure-files/-/raw/main/installer" | bash

docker info
docker-compose --version
docker buildx version
docker buildx rm toqen_tware_microcontainers_buildx
docker buildx create --name toqen_tware_microcontainers_buildx
docker buildx use toqen_tware_microcontainers_buildx
docker buildx inspect toqen_tware_microcontainers_buildx --bootstrap
