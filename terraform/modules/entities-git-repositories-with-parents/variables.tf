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

variable "git_projects_with_parent" {
  type        = list(tuple([string, string, string, string]))
  description = "<required:repo-name>, <required:repo-path>, <required (can be blank):parrent-id>- ([\"hexagonal-sdk-kotlin\", \"tomshley/brands/global/tware/tech/products/hexagonal\", \"69749680\"])"
}
variable "git_project_mirrors" {
  type        = list(tuple([string, string]))
  description = "<required:repo-name>, <required:repo-url>"
  default     = []
}
variable "git_flow_structure" {
  type = object(
    {
      production  = list(string)
      integration = list(string)
      feature     = list(string)
      release     = list(string)
      hotfix      = list(string)
      support     = list(string)
    }
  )
  default = {
    production     = ["main"]
    integration    = ["develop"]
    feature        = ["feature/"]
    release        = ["release/"]
    hotfix         = ["hotfix/"]
    support        = ["support/"]
    version_prefix = ["v"]
  }
}
