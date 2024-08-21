locals {
  docker_virtual_includes_grouped = {
    for v in var.docker_repositories_virtual_include : replace(v[0], "/", "-") => replace(v[1], "/", "-")...
  }
  sbt_virtual_includes_grouped = {
    for v in var.sbt_repositories_virtual_include : replace(v[0], "/", "-") => replace(v[1], "/", "-")...
  }
}

resource "artifactory_local_docker_v2_repository" "docker_repository_local" {
  for_each        = {for v in var.docker_repositories_local : replace(v, "/", "-") => v}
  key             = "${each.key}-dockers"
  tag_retention   = 3
  max_unique_tags = 25
  xray_index      = true
}

resource "artifactory_virtual_docker_repository" "docker_repository_virtual" {
  for_each = {
    for v in var.docker_repositories_virtual : replace(v[0], "/", "-") => v[1]
  }
  key                                                = "${each.value}-dockers"
  repositories                                       = [
    for v in lookup(local.docker_virtual_includes_grouped, each.key, []) :
    artifactory_local_docker_v2_repository.docker_repository_local[v].key
  ]
  description                                        = "A virtual repo for ${each.key}"
  notes                                              = "N/A"
  includes_pattern                                   = "**"
  excludes_pattern                                   = ""
  default_deployment_repo                            = "deprecated-dockers-transitioned"
  repo_layout_ref                                    = "simple-default"
  artifactory_requests_can_retrieve_remote_artifacts = true
}

resource "artifactory_local_sbt_repository" "sbt_repository_local" {
  for_each = {for v in var.sbt_repositories_local : replace(v, "/", "-") => v}
  key      = "${each.key}-sbt"
  property_sets = [
    "artifactory"
  ]
}

resource "artifactory_virtual_sbt_repository" "sbt_repository_virtual" {
  for_each                                 = {for v in var.sbt_repositories_virtual : replace(v[0], "/", "-") => v[1]}
  key                                      = "${each.value}-sbt"
  repositories                             = [
    for v in lookup(local.sbt_virtual_includes_grouped, each.key, []) :
    artifactory_local_sbt_repository.sbt_repository_local[v].key
  ]
  description                              = "A virtual repo for ${each.key}"
  notes                                    = "N/A"
  includes_pattern                         = "**"
  pom_repository_references_cleanup_policy = "discard_active_reference"
}
