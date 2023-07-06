
module "tware-hexagonal-gitlab" {
  source = "../tware-gitlab"
  gitlab_projects_with_parent = [
    (["breakground-provisioning", "tomshley", "64355277"]),
  ]
}