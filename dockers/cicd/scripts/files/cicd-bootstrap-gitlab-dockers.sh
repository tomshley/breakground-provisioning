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

. "/opt/tomshley/breakground-provisioning/cicd/bin/cicd-bootstrap-gitlab.sh"

cd "${DOCKERS_LOCAL_ROOT}" || exit

echo "RUNNING THE DOCKER BUILD"

echo 'docker buildx create --name tomshley_tware_breakground_buildx'
echo 'docker buildx rm tomshley_tware_microcontainers_buildx'
echo 'docker buildx use tomshley_tware_breakground_buildx'
echo 'docker buildx inspect tomshley_tware_breakground_buildx --bootstrap'
echo 'docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" "$CI_REGISTRY"'

