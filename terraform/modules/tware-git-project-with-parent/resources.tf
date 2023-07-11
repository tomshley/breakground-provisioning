locals {
  mirrored_project_https_clone_urls = {
    for mp in var.git_project_mirrors : mp[0] => mp[1]
  }
  project_data = {
    for pt in var.git_projects_with_parent : pt[0] => {
      parent_id                  = pt[2]
      parent_path                = trimsuffix(pt[1], "/")
      parent_name                = element(split("/", trimsuffix(pt[1], "/")), length(split("/", trimsuffix(pt[1], "/"))) - 1)
      mirror_https_clone_address = lookup(local.mirrored_project_https_clone_urls, pt[0], "")
      repository_files_default = {
        gitignore = {
          filename = ".gitignore"
          content  = templatefile("${path.module}/templates/.gitignore.tftpl", {})
        }
        license = {
          filename = "LICENSE"
          content  = templatefile("${path.module}/templates/LICENSE.tftpl", {})
        }

        readme = {
          filename = "README.md"
          content  = templatefile("${path.module}/templates/README.md.tftpl", { repository_name = pt[0] })
        }

        version = {
          filename = "VERSION"
          content  = templatefile("${path.module}/templates/VERSION.tftpl", {})
        }
      }
    }
  }
  unique_groups_for_management = distinct([
    for pt in var.git_projects_with_parent : trimsuffix(pt[1], "/") if pt[2] == ""
  ])

  unique_groups_for_management_map = {
    for ug in local.unique_groups_for_management : replace(ug, "/", "-") => {
      name   = element(split("/", trimsuffix(ug, "/")), length(split("/", trimsuffix(ug, "/"))) - 1)
      path   = ug
      parent = element(split("/", trimsuffix(ug, "/")), length(split("/", trimsuffix(ug, "/"))) - 2)
    }
  }
}
