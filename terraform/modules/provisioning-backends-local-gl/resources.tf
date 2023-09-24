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

module "provisioning-generic-organization-github" {
  source                   = "../provisioning-generic-organization-github"
  git_projects_with_parent = [
    (["breakground-provisioning", "tomshley", "tomshley", "public"]),
  ]
}

module "provisioning-generic-organization-gitlab" {
  source = "../provisioning-generic-organization-gitlab"
  git_projects_with_parent = [
    (["breakground-provisioning", "tomshley", "64355277", "private"]),
  ]
  github_mirror_token = var.github_mirror_token

  git_project_mirrors = [
    (["breakground-provisioning", module.provisioning-generic-organization-github.gh_repositories["breakground-provisioning"].http_clone_url])
  ]
  github_owner_group_path = var.github_owner_group_path
}
