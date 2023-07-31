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

group "default" {
  targets = [
    "os",
    "builders",
    "lang",
    "cicd",
    "provisioning"
  ]
}

# region GROUPS
group "os" {
  targets = [
    "os_alpine_3_16"
  ]
}
group "builders" {
  targets = [
    "builders_dindx_0_1_0"
  ]
}
group "lang" {
  targets = [
    "lang_python3_3_11"
  ]
}
group "cicd" {
  targets = [
    "cicd_scripts_0_1_0"
  ]
}
group "provisioning" {
  targets = [
    "provisioning_terraform_with_docker_0_1_0"
  ]
}
# endregion

# region REGISTRIES
variable "REGISTRY" {
  default = "registry.gitlab.com/tomshley/breakground-provisioning"
}
variable "OS_ALPINE" {
  default = "os_alpine"
}
variable "BUILDERS_DINDX" {
  default = "builders_dindx"
}
variable "LANG_PYTHON3" {
  default = "lang_python3"
}
variable "CICD_SCRIPTS" {
  default = "cicd_scripts"
}
variable "PROVISIONING_TERRAFORM_WITH_DOCKER" {
  default = "provisioning_terraform_with_docker"
}
# endregion

target "os_alpine_3_16" {
  dockerfile = "Dockerfile"
  context    = "./os/alpine/3.16"
  tags       = [
    "${REGISTRY}/${OS_ALPINE}:3.16",
    "${REGISTRY}/${OS_ALPINE}:latest"
  ]

  platforms = [
    "linux/386",
    "linux/amd64",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64/v8",
    "linux/ppc64le",
    "linux/s390x"
  ]
}

target "lang_python3_3_11" {
  dockerfile = "Dockerfile"
  context    = "./lang/python3/3.11"
  tags       = [
    "${REGISTRY}/${LANG_PYTHON3}:3.11",
    "${REGISTRY}/${LANG_PYTHON3}:latest"
  ]

  platforms = [
    "linux/386",
    "linux/amd64",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64/v8",
    "linux/ppc64le",
    "linux/s390x"
  ]
}
target "provisioning_terraform_with_docker_0_1_0" {
  dockerfile = "Dockerfile"
  context    = "./provisioning/terraform-with-docker/0.1.0"
  tags       = [
    "${REGISTRY}/${PROVISIONING_TERRAFORM_WITH_DOCKER}:0.1.0",
    "${REGISTRY}/${PROVISIONING_TERRAFORM_WITH_DOCKER}:latest"
  ]

  platforms = [
    "linux/386",
    "linux/amd64",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64/v8",
    "linux/ppc64le",
    "linux/s390x"
  ]
}
target "builders_dindx_0_1_0" {
  dockerfile = "Dockerfile"
  context    = "./builders/dindx/0.1.0"
  tags       = [
    "${REGISTRY}/${BUILDERS_DINDX}:0.1.0",
    "${REGISTRY}/${BUILDERS_DINDX}:latest"
  ]

  platforms = [
    "linux/386",
    "linux/amd64",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64/v8",
    "linux/ppc64le",
    "linux/s390x"
  ]
}
target "cicd_scripts_0_1_0" {
  dockerfile = "Dockerfile"
  context    = "./cicd/scripts/0.1.0"
  tags       = [
    "${REGISTRY}/${CICD_SCRIPTS}:0.1.0",
    "${REGISTRY}/${CICD_SCRIPTS}:latest"
  ]

  platforms = [
    "linux/386",
    "linux/amd64",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64/v8",
    "linux/ppc64le",
    "linux/s390x"
  ]
}
