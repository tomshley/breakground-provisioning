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

variable "existing_projects_branches" {
  type = list(object({
    project_name = string
    branch_name  = string
  }))
  description = "existing_projects_branches = [{project_name = \"\" branch_name = \"\"}]"
  default = []
}
variable "managed_projects" {
  type = list(object({
    project_name = string
    project_id   = string
  }))
  description = "managed_projects = [{project_name = \"\" project_id = \"\" }]"
  default = []
}
variable "git_flow_projects_with_branch_defaults_grouped" {
  type = any
  description = "value from tware-hydrator-git-repositories-with-parents.git_flow_projects_with_branch_defaults_grouped"
}
variable "git_flow_target_default_branch_types" {
  type = list(string)
  default = ["production", "integration"]
}

