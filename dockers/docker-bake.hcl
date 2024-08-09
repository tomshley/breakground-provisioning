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
    "cicd",
    "provisioning"
  ]
}

# region GROUPS
group "os" {
  targets = [
    "os_alpine"
  ]
}
group "cicd" {
  targets = [
    "cicd_scripts"
  ]
}
group "provisioning" {
  targets = [
    "provisioning_terraform_with_py"
  ]
}
# endregion

# region REGISTRIES
variable "REGISTRY" {
  default = "registry.gitlab.com/${TOMSHLEY_BREAKGROUND_DOCKERS_GROUPNAME}/${TOMSHLEY_DOCKERS_BUILD_PROJECT_NAME}"
}
variable "OS_ALPINE" {
  default = "os_alpine"
}
variable "CICD_SCRIPTS" {
  default = "cicd_scripts"
}
variable "PROVISIONING_TERRAFORM_WITH_PY" {
  default = "provisioning_terraform_with_py"
}
variable "TOMSHLEY_BREAKGROUND_DOCKERS_GROUPNAME" {
  default = "DOCKERS_GROUPNAME"
}
variable "TOMSHLEY_DOCKERS_BUILD_PROJECT_NAME" {
  default = "PROJECTNAME"
}
variable "TOMSHLEY_DOCKERS_BUILD_REF" {
  default = "BUILDSLUG"
}
variable "TOMSHLEY_DOCKERS_BUILD_REF_LATEST" {
  default = "latest"
}
# endregion

target "os_alpine" {
  dockerfile = "Dockerfile"
  context    = "./os/alpine"
  args = {
    TOMSHLEY_DOCKERS_BUILD_REF = "${TOMSHLEY_DOCKERS_BUILD_REF}"
  }
  tags       = [
    "${REGISTRY}/${OS_ALPINE}:3.19",
    "${REGISTRY}/${OS_ALPINE}:${TOMSHLEY_DOCKERS_BUILD_REF}",
    "${REGISTRY}/${OS_ALPINE}:${TOMSHLEY_DOCKERS_BUILD_REF_LATEST}"
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
target "provisioning_terraform_with_py" {
  dockerfile = "Dockerfile"
  context    = "./provisioning/terraform-with-py"
  contexts = {
    cicd_scripts_docker_build_ref = "target:cicd_scripts"
    os_alpine_docker_build_ref = "target:os_alpine"
  }
  args = {
    TOMSHLEY_DOCKERS_BUILD_REF = "${TOMSHLEY_DOCKERS_BUILD_REF}"
  }
  tags       = [
    "${REGISTRY}/${PROVISIONING_TERRAFORM_WITH_PY}:${TOMSHLEY_DOCKERS_BUILD_REF}",
    "${REGISTRY}/${PROVISIONING_TERRAFORM_WITH_PY}:${TOMSHLEY_DOCKERS_BUILD_REF_LATEST}"
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
target "cicd_scripts" {
  dockerfile = "Dockerfile"
  context    = "./cicd/scripts"
  contexts = {
    os_alpine_docker_build_ref = "target:os_alpine"
  }
  args = {
    TOMSHLEY_DOCKERS_BUILD_REF = "${TOMSHLEY_DOCKERS_BUILD_REF}"
  }
  tags       = [
    "${REGISTRY}/${CICD_SCRIPTS}:${TOMSHLEY_DOCKERS_BUILD_REF}",
    "${REGISTRY}/${CICD_SCRIPTS}:${TOMSHLEY_DOCKERS_BUILD_REF_LATEST}"
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
