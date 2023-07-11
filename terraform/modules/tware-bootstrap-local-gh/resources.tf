module "tware-hexagonal-github" {
  source = "../tware-gitlab"
  github_root_organization = "tomshley"

  git_projects_with_parent = [
    (["dayzero-provisioning"])
  ]
}
