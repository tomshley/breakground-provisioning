
# module "tware-gitlab" {
#   source = "../tware-gitlab"
#   gitlab_target_group         = "tware"
#   root_gitlab_path_trailslash = "tomshley/"
#   gitlab_projects_with_parent = [
#     (["hexagonal/lib", "hexagonal"]), # path, parent
#     (["hexagonal/plugins", "hexagonal"]),
#     (["hexagonal/protobuf", "hexagonal"]),
#     (["hexagonal/provisioning", "hexagonal"]),
#     (["hexagonal/quality", "hexagonal"])
#   ]
# }

module "tware-hexagonal-artifactory" {
  source = "../tware-artifactory"
}
