module "tware-git-project-with-parent" {
  source                   = "../tware-git-project-with-parent"
  git_projects_with_parent = var.git_projects_with_parent
}
# POST https://gitlab.com/api/v4/groups: 403 {message: 403 Forbidden}
resource "gitlab_group" "groups" {
  for_each = module.tware-git-project-with-parent.unique_groups_for_management_map
  name     = each.value["name"]
  path     = each.value["path"]
}

resource "gitlab_project" "group_projects" {
  for_each         = module.tware-git-project-with-parent.project_data
  name             = replace(each.key, "/", "-")
  namespace_id     = each.value["parent_id"] == "" ? gitlab_group.groups[replace(each.value["parent_path"], "/", "-")].id : each.value["parent_id"]
  path             = replace(each.key, "/", "-")
  visibility_level = "private"
}

# https://github.com/settings/tokens
resource "gitlab_project_mirror" "group_projects_mirrors" {
  for_each                = module.tware-git-project-with-parent.mirrored_project_https_clone_urls
  project                 = gitlab_project.group_projects[each.key]
  # Example:
  #   url     = "https://username:password@github.com/org/repository.git"
  #   url     = "https://github.com/sgoggles/tware-hexagonal-plugin-sbt.git"
  # personal token = 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
  #   url     = "https://sgoggles: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@github.com/sgoggles/tware-hexagonal-plugin-sbt.git"
  url                     = "https://${var.github_mirror_token}@${trimprefix(module.tware-git-project-with-parent.project_data[each.key]["mirror_https_clone_address"], "https://")}"
  enabled                 = true
  keep_divergent_refs     = false
  only_protected_branches = true
}
