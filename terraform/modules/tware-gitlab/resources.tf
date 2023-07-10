module "tware-git-project-with-parent" {
  source = "../tware-git-project-with-parent"
  git_projects_with_parent = var.git_projects_with_parent
}

resource "gitlab_group" "groups" {
  for_each = module.tware-git-project-with-parent.unique_groups_for_management_map
  name     = each.value["name"]
  path     = each.value["path"]
}

resource "gitlab_project" "group_projects" {
  for_each     = module.tware-git-project-with-parent.project_data
  name         = replace(each.key, "/", "-")
  namespace_id = each.value["parent_id"] == "" ? gitlab_group.groups[replace(each.value["parent_path"], "/", "-")].id : each.value["parent_id"]
  path         = replace(each.key, "/", "-")
  visibility_level = "private"
}
