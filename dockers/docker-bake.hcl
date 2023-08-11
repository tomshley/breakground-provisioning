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
    "builders_dindx_latest"
  ]
}
group "cicd" {
  targets = [
    "cicd_scripts_latest"
  ]
}
group "provisioning" {
  targets = [
    "provisioning_terraform_with_py_dindx_latest"
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
variable "CICD_SCRIPTS" {
  default = "cicd_scripts"
}
variable "PROVISIONING_TERRAFORM_WITH_PY_DINDX" {
  default = "provisioning_terraform_with_py_dindx"
}
variable "TOMSHLEY_BREAKGROUND_BUILD_VERSION" {
  default = "v0.0.0-DEV"
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
target "provisioning_terraform_with_py_dindx_latest" {
  dockerfile = "Dockerfile"
  context    = "./provisioning/terraform-with-py-dindx"
  tags       = [
    "${REGISTRY}/${PROVISIONING_TERRAFORM_WITH_PY_DINDX}:${TOMSHLEY_BREAKGROUND_BUILD_VERSION}",
    "${REGISTRY}/${PROVISIONING_TERRAFORM_WITH_PY_DINDX}:latest"
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
target "builders_dindx_latest" {
  dockerfile = "Dockerfile"
  context    = "./builders/dindx"
  tags       = [
    "${REGISTRY}/${BUILDERS_DINDX}:${TOMSHLEY_BREAKGROUND_BUILD_VERSION}",
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
target "cicd_scripts_latest" {
  dockerfile = "Dockerfile"
  context    = "./cicd/scripts"
  tags       = [
    "${REGISTRY}/${CICD_SCRIPTS}:${TOMSHLEY_BREAKGROUND_BUILD_VERSION}",
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
