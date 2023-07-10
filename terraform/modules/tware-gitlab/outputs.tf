output "gl_repositories" {
  depends_on = [gitlab_project.group_projects]
  value = gitlab_project.group_projects
}