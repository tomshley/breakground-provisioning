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

terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "16.8.1"
    }
    github = {
      source  = "integrations/github"
      version = "5.45.0"
    }
  }
}

provider "github" {
  token = sensitive(var.github_token)
  owner = var.github_owner_org
}

provider "gitlab" {
  token = sensitive(var.gitlab_token)
}

module "provisioning-backends-local-gl" {
  providers = {
    gitlab = gitlab
    github = github
  }
  source                  = "../../modules/provisioning-backends-local-gl"
  github_mirror_token     = var.github_mirror_token
  github_owner_group_path = var.github_owner_org
  github_projects_with_parent = [
    (["breakground-provisioning", "tomshley", "tomshley", "public"]),
  ]
  gitlab_projects_with_parent = [
    (["breakground-provisioning", "tomshley", "64355277", "private"]),
  ]
  gitlab_project_mirrors = [
    (["breakground-provisioning", ""])
  ]
}

module "provisioning-generic-deploy-containers" {
  depends_on = [module.provisioning-backends-local-gl]
  source     = "../../modules/provisioning-generic-deploy-containers"
}
# For Debug:
#output "groups" {
#  value = module.provisioning-backends-local-gl.groups
#}
