locals {
  project_data_prep_with_mirror_urls = {
    for mp in var.git_project_mirrors : mp[0] =>  {
      mirror_https_clone_address = mp[1]
    }
  }

  project_data_prep_no_mirror_urls = {
    for pd in var.git_projects_with_parent : pd[0] => {
      mirror_https_clone_address = ""
    } if !contains(keys(local.project_data_prep_with_mirror_urls), pd[0])
  }

  project_data_mapped = {
    for pt in var.git_projects_with_parent : pt[0] => {
      parent_id                  = pt[2]
      parent_path                = trimsuffix(pt[1], "/")
      parent_name                = element(split("/", trimsuffix(pt[1], "/")), length(split("/", trimsuffix(pt[1], "/"))) - 1)
      visibility                 = length(pt) > 4 ? (pt[3] != "" ? pt[3] : "private") : "private"
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

  project_data_no_mirrors = {
    for k, v in local.project_data_prep_no_mirror_urls : k => merge(v, lookup(local.project_data_mapped, k, {}))
  }

  project_data_with_mirrors = {
    for k, v in local.project_data_prep_with_mirror_urls : k => merge(v, lookup(local.project_data_mapped, k, {}))
  }

  project_data = merge(local.project_data_with_mirrors, local.project_data_no_mirrors)

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
