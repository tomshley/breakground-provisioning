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

variable "github_mirror_token" {
  type = string
}
variable "github_owner_group_path" {
  type = string
}
variable "github_projects_with_parent" {
  type = list(tuple([string, string, string, string]))
}
variable "gitlab_projects_with_parent" {
  type = list(tuple([string, string, string, string]))
}
variable "gitlab_project_mirrors" {
  type        = list(tuple([string, string]))
  description = "<required:target-name>, <required:mirror-name>"
  default     = []
}
