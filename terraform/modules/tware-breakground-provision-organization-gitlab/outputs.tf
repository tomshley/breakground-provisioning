output "gl_repositories" {
  depends_on = [gitlab_project.group_projects_no_mirror]
  value      = merge(gitlab_project.group_projects_no_mirror, gitlab_project.group_projects_with_mirror)
}
