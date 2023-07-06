
#resource "gitlab_group" "groups" {
#  for_each = local.unique_groups
#  name = replace("/", "-", "${var.root_gitlab_path_trailslash}${var.gitlab_target_group}/${each.key}")
#  path = "${var.root_gitlab_path_trailslash}${var.gitlab_target_group}/${each.key}"
#}

resource "gitlab_project" "group_projects" {
  for_each = { for pt in var.gitlab_projects_with_parent : pt[0] => {
      parent_id = pt[1]
      parent_path = pt[2]
    }
  }
  name         = replace(each.key, "/", "-")
  namespace_id = each.value["parent_id"]
  path = replace(each.key, "/", "-")
}
