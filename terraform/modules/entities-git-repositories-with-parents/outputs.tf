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

output "project_data" {
  value = local.project_data
}

output "project_data_no_mirrors" {
  value = local.project_data_no_mirrors
}

output "project_data_with_mirrors" {
  value = local.project_data_with_mirrors
}

output "unique_groups_for_management_map" {
  value = local.unique_groups_for_management_map
}

output "unique_groups_known_parent_map" {
  value = local.unique_groups_known_parent_map
}

output "git_flow_projects_with_branch_defaults" {
  value = local.git_flow_projects_with_branch_defaults
}

output "git_flow_projects_with_branch_defaults_grouped" {
  value = local.git_flow_projects_with_branch_defaults_grouped
}

output "groups_map" {
  value = local.groups_map
}
