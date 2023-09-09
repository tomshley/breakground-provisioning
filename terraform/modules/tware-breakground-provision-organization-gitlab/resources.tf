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

module "tware-hydrator-git-repositories-with-branches" {
  source                     = "../tware-hydrator-git-repositories-with-branches"
  #  existing_projects_branches = [
  #    {
  #      project_name = ""
  #      branch_name = ""
  #    }
  #  ]
  #  managed_projects = [
  #    {
  #      project_name = ""
  #      project_id = ""
  #    }
  #  ]
  existing_projects_branches = flatten([
    for k1, v1 in data.gitlab_project_branches.group_projects_branch_production_exists_data :
    [
      for v2 in v1["branches"] :
      {
        project_name = k1
        branch_name  = v2["name"]
      }
    ]
  ])
  managed_projects = [
    for k1, v1 in gitlab_project.group_projects :
    {
      project_name = v1["name"]
      project_id   = v1["id"]
    }
  ]
  git_flow_projects_with_branch_defaults_grouped = module.tware-hydrator-git-repositories-with-parents.git_flow_projects_with_branch_defaults_grouped
}

resource "gitlab_project" "group_projects" {
  depends_on = [
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

# TODO - investigate this:
# https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project
# Default Branch Protection Workaround
# Projects are created with default branch protection. Since this default branch protection
# is not currently managed via Terraform, to workaround this limitation, you can remove the
# default branch protection via the API and create your desired Terraform managed branch
# protection. In the gitlab_project resource, define a local-exec provisioner which invokes
# the /projects/:id/protected_branches/:name API via curl to delete the branch protection
# on the default branch using a DELETE request. Then define the desired branch protection
# using the gitlab_branch_protection resource.

#resource "gitlab_branch" "group_projects_branch_production" {
#  depends_on = [
#    module.tware-hydrator-git-repositories-with-branches
#  ]
#  for_each = lookup(module.tware-hydrator-git-repositories-with-branches.target_managed_project_branches_by_project_name, "production", {})
#  project = gitlab_project.group_projects[each.value["project_name"]].id
#  name    = each.value["branch_name"]
#  ref     = each.value["branch_name"]
#}

resource "gitlab_branch" "group_projects_branch_integration" {
  depends_on = [
    module.tware-hydrator-git-repositories-with-branches
  ]
  for_each = lookup(module.tware-hydrator-git-repositories-with-branches.target_managed_project_branches_by_project_name, "integration", {})
  project = gitlab_project.group_projects[each.value["project_name"]].id
  name    = each.value["branch_name"]
  ref     = trimprefix(
    element([
      for v in module.tware-hydrator-git-repositories-with-branches.git_flow_projects_with_branch_names_grouped["production"] :
      v if startswith(v, each.value["project_name"])
    ], 0),
    each.value["project_name"]
  )
}

resource "gitlab_branch_protection" "group_projects_protected_branches" {
  depends_on = [
    gitlab_branch.group_projects_branch_integration
  ]
  for_each = merge(
    lookup(module.tware-hydrator-git-repositories-with-branches.target_managed_project_branches_by_project_name, "production", {}),
    lookup(module.tware-hydrator-git-repositories-with-branches.target_managed_project_branches_by_project_name, "integration", {})
  )
  project = gitlab_project.group_projects[each.value["project_name"]].id
  branch  = each.value["branch_name"]
  push_access_level      = "maintainer"
  merge_access_level     = "maintainer"
  unprotect_access_level = "maintainer"
}

# https://github.com/settings/tokens
resource "gitlab_project_mirror" "group_projects_mirrors" {
  for_each = {
    for k, v in gitlab_project.group_projects : k=>v
    if contains(
      keys(
        module.tware-hydrator-git-repositories-with-parents.project_data_with_mirrors
      ),
      k
    )
  }
  project  = each.value.id
  #   Example:
  #     url     = "https://username:password@github.com/org/repository.git"
  #     url     = "https://${var.github_mirror_token}@${trimprefix(module.tware-git-project-with-parent.project_data[each.key]["mirror_https_clone_address"], "https://")}"
  url                     = "https://${var.github_mirror_token}@${trimprefix(module.tware-hydrator-git-repositories-with-parents.project_data[each.key]["mirror_https_clone_address"], "https://")}"
  enabled                 = true
  keep_divergent_refs     = false
  only_protected_branches = true
}