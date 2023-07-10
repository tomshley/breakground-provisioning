locals {
  project_data = {
    for pt in var.git_projects_with_parent : pt[0] => {
      parent_id   = pt[2]
      parent_path = trimsuffix(pt[1], "/")
      parent_name = element(split("/", trimsuffix(pt[1], "/")), length(split("/", trimsuffix(pt[1], "/")))-1)
      mirror_address = pt[3]
    }
  }
  unique_groups_for_management = distinct([
    for pt in var.git_projects_with_parent : trimsuffix(pt[1], "/") if pt[2] == ""
  ])

  unique_groups_for_management_map = {
    for ug in local.unique_groups_for_management : replace(ug, "/", "-") => {
      name   = element(split("/", trimsuffix(ug, "/")), length(split("/", trimsuffix(ug, "/")))-1)
      path   = ug
      parent = element(split("/", trimsuffix(ug, "/")), length(split("/", trimsuffix(ug, "/")))-2)
    }
  }
}
