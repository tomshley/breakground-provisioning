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

locals {
  # this data manipulation will work around some errors with GH and GL around branches not existing
  branch_list_data_structure = {
    project_name     = null
    branch_name      = null
    flow_branch_type = null
  }
  default_branch_data_structure = {
    project_name = null
    branch_name  = null
    lookup = null
  }
  git_flow_projects_with_branch_names_grouped_flattened = flatten([
    for v in var.git_flow_projects_with_branch_defaults_grouped : [
      for k2, v2 in v : [for v3 in v2 : "${v3["flow_branch_type"]};${v3["project_name"]};${v3["branch_name"]}"]
    ]
  ])

  # these are the default desired branches based on the git flow configuration
  git_flow_projects_with_branch_names_grouped_by_branch = {
    for v in local.git_flow_projects_with_branch_names_grouped_flattened : split(
      ";",
      v
    )[
    1
    ] => v...
    if contains(var.git_flow_target_default_branch_types, split(
      ";",
      v
    )[
    0
    ])
  }

  git_flow_projects_with_branch_names_grouped = {
    for v in local.git_flow_projects_with_branch_names_grouped_flattened : split(
      ";",
      v
    )[
    0
    ] => "${
      split(
      ";",
      v
      )[1]
    }${
      split(
      ";",
      v
      )[2]
    }"...
  }

  project_branches_by_project_name_from_existing_as_branch_list = flatten([
    for v1 in var.existing_projects_branches : merge(local.branch_list_data_structure, {
      project_name     = v1["project_name"]
      branch_name      = v1["branch_name"]
      flow_branch_type = one([
        for v2 in local.git_flow_projects_with_branch_names_grouped_by_branch[v1["project_name"]] :split(";", v2)[0]
        if v1["branch_name"] == split(";", v2)[2]
      ])
    })
  ])
  target_managed_project_branches_by_project_name_as_branch_list = flatten([
    for v1 in var.managed_projects : [
      for v2 in flatten(local.git_flow_projects_with_branch_names_grouped_by_branch[v1["project_name"]]) :
      merge(local.branch_list_data_structure, {
        project_name     = v1["project_name"],
        branch_name      = split(";", v2)[2]
        flow_branch_type = split(";", v2)[0]
      })
    ]
  ])
  project_branches_by_project_name_from_existing = {
    for v1 in local.
    project_branches_by_project_name_from_existing_as_branch_list : v1["flow_branch_type"] => join(
      ";",
      values(v1)
    )... if v1["flow_branch_type"] != null
  }

  target_managed_project_branches_by_project_name_mapped_strings = {
    for v1 in local.
    target_managed_project_branches_by_project_name_as_branch_list : v1["flow_branch_type"] => join(
      ";",
      values(v1)
    )...
  }

  target_managed_project_branches_by_project_name_without_existing = {
    for k1, v1 in local.target_managed_project_branches_by_project_name_mapped_strings : k1 => {
      for v2 in v1 : "${split(";", v2)[1]}${split(";", v2)[0]}${split(";", v2)[2]}" => merge(local.default_branch_data_structure, {
        project_name = split(";", v2)[2]
        branch_name = split(";", v2)[0]
        lookup = "${split(";", v2)[0]};${split(";", v2)[1]};${split(";", v2)[2]}"
      })
    }
  }

  target_managed_project_branches_by_project_name = local.target_managed_project_branches_by_project_name_without_existing

  # this will check for existing, but creates a circular dependency
#  target_managed_project_branches_by_project_name = {
#    for k1, v1 in local.target_managed_project_branches_by_project_name_without_existing : k1 => {
#      for k2, v2 in v1 : k2 => merge(v2, {
#        managed=true
#      }) if !contains(local.project_branches_by_project_name_from_existing[k1], v2["lookup"])
#    }
#  }
}
