locals {
  project_data = {
    for pt in var.gitlab_projects_with_parent : pt[0] => {
      parent_id   = pt[2]
      parent_path = trimsuffix(pt[1], "/")
      parent_name = element(split("/", trimsuffix(pt[1], "/")), length(split("/", trimsuffix(pt[1], "/")))-1)
    }
  }
  unique_groups_for_management = distinct([
    for pt in var.gitlab_projects_with_parent : trimsuffix(pt[1], "/") if pt[2] == ""
  ])

  unique_groups_for_management_map = {
    for ug in local.unique_groups_for_management : replace(ug, "/", "-") => {
      name   = element(split("/", trimsuffix(ug, "/")), length(split("/", trimsuffix(ug, "/")))-1)
      path   = ug
      parent = element(split("/", trimsuffix(ug, "/")), length(split("/", trimsuffix(ug, "/")))-2)
    }
  }
}


resource "gitlab_group" "groups" {
  for_each = local.unique_groups_for_management_map
  name     = each.value["name"]
  path     = each.value["path"]
}

resource "gitlab_project" "group_projects" {
  for_each     = local.project_data
  name         = replace(each.key, "/", "-")
  namespace_id = each.value["parent_id"] == "" ? gitlab_group.groups[replace(each.value["parent_path"], "/", "-")].id : each.value["parent_id"]
  path         = replace(each.key, "/", "-")
  visibility_level = "private"
}
