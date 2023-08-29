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

#resource "github_organization_settings" "organization" {
#  billing_email = var.organization_settings_billing_email
#  company = var.organization_settings_company
#  blog = var.organization_settings_blog
#  email = var.organization_settings_email
#  twitter_username = var.organization_settings_twitter_username
#  location = var.organization_settings_location
#  name = var.organization_settings_name
#  description = var.organization_settings_description
#  has_organization_projects = true
#  has_repository_projects = true
#  default_repository_permission = "read"
#  members_can_create_repositories = true
#  members_can_create_public_repositories = true
#  members_can_create_private_repositories = true
#  members_can_create_internal_repositories = true
#  members_can_create_pages = true
#  members_can_create_public_pages = true
#  members_can_create_private_pages = true
#  members_can_fork_private_repositories = true
#  web_commit_signoff_required = true
#  advanced_security_enabled_for_new_repositories = false
#  dependabot_alerts_enabled_for_new_repositories=  false
#  dependabot_security_updates_enabled_for_new_repositories = false
#  dependency_graph_enabled_for_new_repositories = false
#  secret_scanning_enabled_for_new_repositories = false
#  secret_scanning_push_protection_enabled_for_new_repositories = false
#}

module "tware-git-project-with-parent" {
  source = "../tware-hydrator-git-repositories-with-parents"
  git_projects_with_parent = var.git_projects_with_parent
}

resource "github_repository" "repositories" {
  for_each   = module.tware-git-project-with-parent.project_data
  name       = replace(each.key, "/", "-")
  visibility = each.value["visibility"]
  auto_init  = false
  #  full_name = replace(each.value["parent_path"], "/", "-")
}

# if initialized:
#resource "github_branch_default" "main"{
#  for_each = github_repository.repositories
#  repository = each.value.name
#  branch     = "main"
#}
#
#resource "github_branch" "develop"{
#  for_each = github_repository.repositories
#  repository = each.value.name
#  branch     = "develop"
#}
