
module "tware-hexagonal-gitlab" {
  source = "../tware-gitlab"
  gitlab_projects_with_parent = [
    (["breakground-provisioning", "64355277", "tomshley"]),
  ]
}