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

export DOCKERS_LOCAL_ROOT="${CI_PROJECT_DIR}/dockers"
export TF_BACKENDS_LOCAL_ROOT="${CI_PROJECT_DIR}/terraform/backends/local"
export TF_BACKENDS_REMOTE_ROOT="${CI_PROJECT_DIR}/terraform/backends/remote"
export TF_STATE_NAME=tomshley-breakground-provisioning
export TOMSHLEY_BREAKGROUND_BUILD_VERSION=$(cat ${CI_PROJECT_DIR}/VERSION)
export TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT=$(echo $TWARE_BUILD_VERSION | awk 'BEGIN { FS="." } { $3++;  if ($3 > 99) { $3=0; $2++; if ($2 > 99) { $2=0; $1++ } } } { printf "v%d.%d.%d\n", $1, $2, $3 }')
export SECURE_FILES_DOWNLOAD_PATH=./
export TOMSHLEY_BREAKGROUND_RELEASE="false"
export TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT="${TOMSHLEY_BREAKGROUND_BUILD_VERSION_NEXT}"
