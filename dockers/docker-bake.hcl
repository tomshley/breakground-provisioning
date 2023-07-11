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
    "provisioning"
  ]
}

# region GROUPS
group "os" {
  targets = [
    "os_alpine_3_16"
  ]
}
group "provisioning" {
  targets = [
    "provisioning_terraform_1_4_6"
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
variable "PROVISIONING_TERRAFORM" {
  default = "provisioning_terraform"
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

target "provisioning_terraform_1_4_6" {
  dockerfile = "Dockerfile"
  context    = "./provisioning/terraform/1.4.6"
  tags       = [
    "${REGISTRY}/${PROVISIONING_TERRAFORM}:3.16",
    "${REGISTRY}/${PROVISIONING_TERRAFORM}:latest"
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
