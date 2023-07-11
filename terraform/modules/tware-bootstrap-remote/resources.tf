module "tware-github" {
  providers = {
    local  = local
    random = random
    github = github
  }
  source = "../tware-github"
  #  git_projects_with_parent=[]
  git_projects_with_parent = [(["tware-hexagonal-plugin-sbt", "tomshley", "tomshley"])]
}

module "tware-gitlab" {
  providers = {
    local  = local
    random = random
    gitlab = gitlab
  }
  depends_on = [module.tware-github]
  source     = "../tware-gitlab"
  git_projects_with_parent = [
    (["gateway-scala", "tomshley/brands/global/tware/tech/products/gateway", "69749675"]), # path, parent, existing id
    (["gateway-sdk-scala", "tomshley/brands/global/tware/tech/products/gateway", "69749675"]),
    # path, parent, existing id
    (["hexagonal-lib-jvm", "tomshley/brands/global/tware/tech/products/hexagonal", "69749680"]),
    (["hexagonal-plugin-sbt", "tomshley/brands/global/tware/tech/products/hexagonal", "69749680"]),
    (["hexagonal-sdk-kotlin", "tomshley/brands/global/tware/tech/products/hexagonal", "69749680"]),
    (["hexagonal-sdk-python", "tomshley/brands/global/tware/tech/products/hexagonal", "69749680"]),
    (["hexagonal-lib-py", "tomshley/brands/global/tware/tech/products/hexagonal", "69749680"]),
    (["hexagonal-sdk-java", "tomshley/brands/global/tware/tech/products/hexagonal", "69749680"]),
    (["hexagonal-sdk-scala", "tomshley/brands/global/tware/tech/products/hexagonal", "69749680"]),
    (["telemetry-aggregator-scala", "tomshley/brands/global/tware/tech/products/telemetry", "69749919"]),
    (["tuuid-scala", "tomshley/brands/global/tware/tech/products/tuuid", "69749871"]),
    (["module-lib-tf", "tomshley/brands/global/tware/tech/products/provisioning", "69749804"]),
    (["paste-css-lib-less", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
    (["paste-jammer-scala", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
    (["paste-pageperf-akkahttp", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
    (["paste-sdk-py", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
    (["paste-templating-akkahttp", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
    (["paste-jammer-py", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
    (["paste-js-lib", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
    (["paste-pageperf-gevent2", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
    (["paste-sdk-scala", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
    (["paste-templating-jinja", "tomshley/brands/global/tware/tech/products/paste", "69749881"])
  ]
  git_project_mirrors = [
    (["hexagonal-plugin-sbt", module.tware-github.gh_repositories["tware-hexagonal-plugin-sbt"].http_clone_url])
  ]
  github_mirror_token = var.github_mirror_token
}

#module "tware-hexagonal-artifactory" {
#  source = "../tware-artifactory"
#}
