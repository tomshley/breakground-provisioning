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
      visibility                 = length(pt) > 3 ? (pt[3] != "" ? pt[3] : "private") : "private"
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

  git_flow_projects_with_branch_defaults_prep = flatten([
    for flow_branch_type, branch_name_list in var.git_flow_structure :
      [
        for branch_name in branch_name_list : [
        for project_name, project_meta in local.project_data :
        {
          flow_branch_type = flow_branch_type
          branch_name      = branch_name
          project_name     = project_name
        }
      ]
      ]

  ])

  git_flow_projects_with_branch_defaults_grouped = flatten([
    for flow_branch_type, branch_name_list in var.git_flow_structure :
    [
      for branch_name in branch_name_list : {
      for project_name, project_meta in local.project_data : flow_branch_type =>
    {
      flow_branch_type = flow_branch_type
      branch_name      = branch_name
      project_name     = project_name
    }...
    }
    ]

  ])

  git_flow_projects_with_branch_defaults = {
    for prep_output_obj in local.git_flow_projects_with_branch_defaults_prep :
    replace(
      "${prep_output_obj["flow_branch_type"]}${prep_output_obj["branch_name"]}${prep_output_obj["project_name"]}",
      "/",
      "-"
    ) => prep_output_obj
  }

  unique_groups_for_management = distinct([
    for pt in var.git_projects_with_parent : trimsuffix(pt[1], "/") if pt[2] == ""
  ])

  unique_groups_known_parent = distinct([
    for pt in var.git_projects_with_parent : trimsuffix(pt[1], "/") if pt[2] != ""
  ])

  unique_groups_known_parent_map = {
    for ug in local.unique_groups_known_parent : replace(ug, "/", "-") => {
      name   = element(split("/", trimsuffix(ug, "/")), length(split("/", trimsuffix(ug, "/"))) - 1)
      path   = ug
      parent = null
    }
  }

  unique_groups_for_management_map = {
    for ug in local.unique_groups_for_management : replace(ug, "/", "-") => {
      name   = element(split("/", trimsuffix(ug, "/")), length(split("/", trimsuffix(ug, "/"))) - 1)
      path   = ug
      parent = element(split("/", trimsuffix(ug, "/")), length(split("/", trimsuffix(ug, "/"))) - 2)
    }
  }

  parent_map_structure = {
    parent_path = null
    parent_key  = null
    group_key   = null
    group_path  = null
    group_name  = null
  }
  required_group_to_parent_path = {
    for k, v in local.unique_groups_for_management_map : k =>
    join("/", slice(split("/", v["path"]), 0, length(split("/", v["path"])) - 1))
  }
  distinct_parent_paths = distinct(flatten([
    for k, v in local.required_group_to_parent_path : v
  ]))
  flattened_parents_with_parent_map = flatten([
    for v1 in local.distinct_parent_paths : [
      for v2 in split("/", v1) : merge(local.parent_map_structure, {
        parent_key  = replace(trimsuffix(element(split(v2, v1), 0), "/"), "/", "-")
        parent_path = trimsuffix(element(split(v2, v1), 0), "/")
        group_name  = v2
        group_path  = v1
        group_key   = "${replace(trimsuffix(element(split(v2, v1), 0), "/"), "/", "-")}-${v2}"
      })
      if element(split(v2, v1), 0) != ""
    ]
  ])
  flattened_required_groups_with_parent_map = flatten([
    for k, v in local.required_group_to_parent_path : merge(local.parent_map_structure, {
      parent_key  = replace(trimsuffix(v, "/"), "/", "-")
      parent_path = v
      group_key   = k
      group_path  = lookup(local.unique_groups_for_management_map, k, {
        path = null
      })[
      "path"
      ]
      group_name = lookup(local.unique_groups_for_management_map, k, {
        name = null
      })[
      "name"
      ]
    })
  ])

  groups_map = {
    for v in concat(local.flattened_required_groups_with_parent_map, local.flattened_parents_with_parent_map) :
    v["group_key"] =>
    v
  }
}
