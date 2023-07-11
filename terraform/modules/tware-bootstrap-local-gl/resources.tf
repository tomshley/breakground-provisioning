
module "tware-hexagonal-gitlab" {
  source = "../tware-gitlab"
  git_projects_with_parent = [
    (["breakground-provisioning", "tomshley", "64355277"])
  ]
  github_mirror_token = var.github_mirror_token
}