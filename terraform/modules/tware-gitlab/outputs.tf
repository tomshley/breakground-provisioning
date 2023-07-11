output "gl_repositories" {
  depends_on = [gitlab_project.group_projects]
  value      = merge(gitlab_project.group_projects, gitlab_project.mirrored_group_projects)
}
