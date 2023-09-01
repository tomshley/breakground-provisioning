module "tware-hydrator-git-repositories-with-parents" {
  source                   = "../tware-hydrator-git-repositories-with-parents"
  git_projects_with_parent = var.git_projects_with_parent
  git_project_mirrors      = var.git_project_mirrors
}

# POST https://gitlab.com/api/v4/groups: 403 {message: 403 Forbidden}
# resource "gitlab_group" "groups" {
#   for_each = module.tware-git-project-with-parent.unique_groups_for_management_map
#   name     = each.value["name"]
#   path     = each.value["path"]
# }
data "gitlab_group" "groups" {
  depends_on = [
    module.tware-hydrator-git-repositories-with-parents
  ]
  for_each  = module.tware-hydrator-git-repositories-with-parents.unique_groups_for_management_map
  full_path = each.value["path"]
}

data gitlab_project_branches "group_projects_branch_production_exists_data" {
  for_each = gitlab_project.group_projects
  project  = each.value.id
}

locals {
  gitlab_project_id_mapping = {
    for k, v in gitlab_project.group_projects : v.id => v.name
  }

  gitlab_project_branchname_flattened = flatten([
    for project_name, v in data.gitlab_project_branches.group_projects_branch_production_exists_data :
    [
      for meta_label, meta_values in v : [
      for branches in v["branches"] : "${project_name}${branches["name"]}"
    ] if meta_label == "branches"
    ]
  ])

  group_projects_branch_production_exists = distinct([
    for k, v in module.tware-hydrator-git-repositories-with-parents.git_flow_projects_with_branch_defaults : k
    if contains(local.gitlab_project_branchname_flattened, "${v["project_name"]}${v["branch_name"]}")
  ])

#  group_projects_branch_production_exists_protectable = concat(local.group_projects_branch_production_exists, [
#    for k, v in gitlab_branch.group_projects_branch_production : k
#  ])
}

resource "gitlab_project" "group_projects" {
  depends_on = [
    module.tware-hydrator-git-repositories-with-parents,
    data.gitlab_group.groups
  ]
  for_each            = module.tware-hydrator-git-repositories-with-parents.project_data
  name                = replace(each.key, "/", "-")
  namespace_id        = each.value["parent_id"] == "" ? data.gitlab_group.groups[replace(each.value["parent_path"], "/", "-")].id : each.value["parent_id"]
  path                = replace(each.key, "/", "-")
  visibility_level    = "private"
  import_url_password = contains(keys(module.tware-hydrator-git-repositories-with-parents.project_data_with_mirrors), each.key) ? split(":", var.github_mirror_token)[1] : ""
  import_url_username = contains(keys(module.tware-hydrator-git-repositories-with-parents.project_data_with_mirrors), each.key) ? split(":", var.github_mirror_token)[0] : ""
  import_url          = contains(keys(module.tware-hydrator-git-repositories-with-parents.project_data_with_mirrors), each.key) ? module.tware-hydrator-git-repositories-with-parents.project_data[each.key]["mirror_https_clone_address"] : ""
  mirror              = false
}

#resource "gitlab_branch" "group_projects_branch_production" {
#  depends_on = [
#    gitlab_project.group_projects
#  ]
#  for_each = {
#    for k, v in module.tware-hydrator-git-repositories-with-parents.git_flow_projects_with_branch_defaults : k => v
#    if v["flow_branch_type"] == "production"
##    && !contains(local.group_projects_branch_production_exists, k)
#  }
#  project = gitlab_project.group_projects[each.value["project_name"]].id
#  name  = each.value["branch_name"]
#  ref  = each.value["branch_name"]
#}
#
#resource "gitlab_branch_protection" "group_projects_protected_branches" {
#  depends_on = [
#    gitlab_branch.group_projects_branch_production,
#    data.gitlab_project_branches.group_projects_branch_production_exists_data
#  ]
#  for_each = {
#    for k, v in module.tware-hydrator-git-repositories-with-parents.git_flow_projects_with_branch_defaults : k => v
#    if (v["flow_branch_type"] == "production" || v["flow_branch_type"] == "integration") && contains(
#      local.group_projects_branch_production_exists_protectable,
#      k
#    )
#  }
#  project = gitlab_project.group_projects[each.value["project_name"]].id
#  branch  = each.value["branch_name"]
#  push_access_level      = "maintainer"
#  merge_access_level     = "maintainer"
#  unprotect_access_level = "maintainer"
#}
#

# https://github.com/settings/tokens
resource "gitlab_project_mirror" "group_projects_mirrors" {
  for_each = gitlab_project.group_projects
  project  = each.value.id
  #   Example:
  #     url     = "https://username:password@github.com/org/repository.git"
  #     url     = "https://${var.github_mirror_token}@${trimprefix(module.tware-git-project-with-parent.project_data[each.key]["mirror_https_clone_address"], "https://")}"
  url                     = "https://${var.github_mirror_token}@${trimprefix(module.tware-hydrator-git-repositories-with-parents.project_data[each.key]["mirror_https_clone_address"], "https://")}"
  enabled                 = true
  keep_divergent_refs     = false
  only_protected_branches = true
}
