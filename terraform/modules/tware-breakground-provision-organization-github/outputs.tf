output "gh_repositories" {
  depends_on = [github_repository.repositories]
  value      = github_repository.repositories
}
