module "tware-git-project-with-parent" {
  source                   = "../tware-git-project-with-parent"
  git_projects_with_parent = var.git_projects_with_parent
  git_project_mirrors      = var.git_project_mirrors
}

locals {
  project_data_no_mirrors = {
    for k, v in module.tware-git-project-with-parent.project_data : k => v if v["mirror_https_clone_address"] == ""
  }
  project_data_with_mirrors = {
    for k, v in module.tware-git-project-with-parent.project_data : k => v if v["mirror_https_clone_address"] != ""
  }
}

# POST https://gitlab.com/api/v4/groups: 403 {message: 403 Forbidden}
# resource "gitlab_group" "groups" {
#   for_each = module.tware-git-project-with-parent.unique_groups_for_management_map
#   name     = each.value["name"]
#   path     = each.value["path"]
# }
data "gitlab_group" "groups" {
  for_each  = module.tware-git-project-with-parent.unique_groups_for_management_map
  full_path = each.value["path"]
}

resource "gitlab_project" "group_projects" {
  for_each         = local.project_data_no_mirrors
  name             = replace(each.key, "/", "-")
  namespace_id     = each.value["parent_id"] == "" ? data.gitlab_group.groups[replace(each.value["parent_path"], "/", "-")].id : each.value["parent_id"]
  path             = replace(each.key, "/", "-")
  visibility_level = "private"
}

resource "gitlab_project" "mirrored_group_projects" {
  for_each            = local.project_data_with_mirrors
  name                = replace(each.key, "/", "-")
  namespace_id        = each.value["parent_id"] == "" ? data.gitlab_group.groups[replace(each.value["parent_path"], "/", "-")].id : each.value["parent_id"]
  path                = replace(each.key, "/", "-")
  visibility_level    = "private"
  import_url_password = split(":", var.github_mirror_token)[1]
  import_url_username = split(":", var.github_mirror_token)[0]
  import_url          = module.tware-git-project-with-parent.project_data[each.key]["mirror_https_clone_address"]
  mirror              = false
}

resource "gitlab_branch_protection" "main" {
  for_each = merge(gitlab_project.group_projects, gitlab_project.mirrored_group_projects)

  project                = each.value.id
  branch                 = "main"
  push_access_level      = "maintainer"
  merge_access_level     = "maintainer"
  unprotect_access_level = "maintainer"
}

resource "gitlab_branch_protection" "develop" {
  for_each = merge(gitlab_project.group_projects, gitlab_project.mirrored_group_projects)

  project                = each.value.id
  branch                 = "develop"
  push_access_level      = "maintainer"
  merge_access_level     = "maintainer"
  unprotect_access_level = "maintainer"
}

# https://github.com/settings/tokens
resource "gitlab_project_mirror" "group_projects_mirrors" {
  for_each                = gitlab_project.mirrored_group_projects
  project                 = each.value.id
  #   Example:
  #     url     = "https://username:password@github.com/org/repository.git"
  #     url     = local.project_data_with_mirrors[each.key]["mirror_https_clone_address"]
  #  url                     = "https://${var.github_mirror_token}@${trimprefix(module.tware-git-project-with-parent.project_data[each.key]["mirror_https_clone_address"], "https://")}"
  url                     = "https://${var.github_mirror_token}@${trimprefix(module.tware-git-project-with-parent.project_data[each.key]["mirror_https_clone_address"], "https://")}"
  enabled                 = true
  keep_divergent_refs     = false
  only_protected_branches = true
}
