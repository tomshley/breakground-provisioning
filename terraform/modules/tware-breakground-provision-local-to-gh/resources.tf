module "tware-hexagonal-github" {
  source = "../tware-breakground-provision-organization-gitlab"
  github_root_organization = "tomshley"

  git_projects_with_parent = [
    (["dayzero-provisioning"])
  ]
}
