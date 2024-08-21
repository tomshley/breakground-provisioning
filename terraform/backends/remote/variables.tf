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

variable "github_user" {
  type = string
}
variable "github_token" {
  type = string
}
variable "github_owner_org" {
  type = string
}
variable "github_mirror_token" {
  type = string
}
variable "gitlab_token" {
  type = string
}
variable "state_identifier" {
  type = string
}
variable "state_username" {
  type = string
}
variable "state_remote_host" {
  type = string
}
variable "artifactory_url" {
  type = string
}
variable "artifactory_access_token" {
  type = string
}

