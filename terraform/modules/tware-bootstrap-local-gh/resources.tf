
module "tware-hexagonal-github" {
  source = "../tware-gitlab"
  github_root_organization = "tomshley"
 
  github_dayzero_repositories = [
    (["dayzero-provisioning"])
  ]
}