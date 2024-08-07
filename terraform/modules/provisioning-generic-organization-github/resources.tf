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
# For reference:
# resource "github_organization_settings" "organization" {
#   billing_email = var.organization_settings_billing_email
#   company = var.organization_settings_company
#   blog = var.organization_settings_blog
#   email = var.organization_settings_email
#   twitter_username = var.organization_settings_twitter_username
#   location = var.organization_settings_location
#   name = var.organization_settings_name
#   description = var.organization_settings_description
#   has_organization_projects = true
#   has_repository_projects = true
#   default_repository_permission = "read"
#   members_can_create_repositories = true
#   members_can_create_public_repositories = true
#   members_can_create_private_repositories = true
#   members_can_create_internal_repositories = true
#   members_can_create_pages = true
#   members_can_create_public_pages = true
#   members_can_create_private_pages = true
#   members_can_fork_private_repositories = true
#   web_commit_signoff_required = true
#   advanced_security_enabled_for_new_repositories = false
#   dependabot_alerts_enabled_for_new_repositories=  false
#   dependabot_security_updates_enabled_for_new_repositories = false
#   dependency_graph_enabled_for_new_repositories = false
#   secret_scanning_enabled_for_new_repositories = false
#   secret_scanning_push_protection_enabled_for_new_repositories = false
# }

locals {
  all_branches_to_protect = {
    for k, v in module.tware-git-project-with-parent.git_flow_projects_with_branch_defaults : k => v
    if contains(keys(github_repository.repositories), v["project_name"])
  }
  public_only_branches_to_protect = {
    for k, v in local.all_branches_to_protect : k => v
    if github_repository.repositories[v["project_name"]].visibility == "public"
  }
  public_only_prod_int_branches_to_protect = {
    for k, v in local.public_only_branches_to_protect : k => v
    if (v["flow_branch_type"] == "production" || v["flow_branch_type"] == "integration")
  }
}
module "tware-git-project-with-parent" {
  source                   = "../entities-git-repositories-with-parents"
  git_projects_with_parent = var.git_projects_with_parent
}


resource "github_repository" "repositories" {
  for_each  = module.tware-git-project-with-parent.project_data
  name = replace(each.key, "/", "-")
  #   Note: You may want to disable this this until if you are having trouble playing nice
  #   with the new settings in GH that come along with visibility
  visibility = each.value["visibility"]
  auto_init = false

  security_and_analysis {
    #   Note: this is an example of how to include scanning settings
    #     secret_scanning_push_protection {
    #       status = "disabled"
    #     }
    #     secret_scanning {
    #       status = "disabled"
    #     }
    #     Note: this is used if advanced security is purchased
    #     advanced_security {
    #       status = "disabled"
    #     }
  }
}

resource "github_branch_protection" "repositories_protected_branches" {
  for_each       = local.public_only_prod_int_branches_to_protect
  repository_id  = github_repository.repositories[each.value["project_name"]].id
  pattern        = each.value["branch_name"]
  enforce_admins = true
}
