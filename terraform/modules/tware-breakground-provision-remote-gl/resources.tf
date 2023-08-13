module "tware-breakground-provision-organization-github" {
  providers = {
    local  = local
    random  = random
    github  = github
  }
  source = "../tware-breakground-provision-organization-github"
  git_projects_with_parent=[
    (["hexagonal-plugin-sbt", "tomshley", "tomshley"])
  ]
}

 module "tware-breakground-provision-organization-gitlab" {
   providers = {
     local  = local
     random  = random
     gitlab  = gitlab
   }
   depends_on = [module.tware-breakground-provision-organization-github]
   source = "../tware-breakground-provision-organization-gitlab"
   git_projects_with_parent = [
#     (["gateway-scala", "tomshley/brands/global/tware/tech/products/gateway", "69749675"]), # path, parent, existing id
#     (["gateway-sdk-scala", "tomshley/brands/global/tware/tech/products/gateway", "69749675"]), # path, parent, existing id
#     (["hexagonal-lib-jvm", "tomshley/brands/global/tware/tech/products/hexagonal", "71327147"]),
     (["hexagonal-plugin-sbt", "tomshley/brands/global/tware/tech/products/hexagonal", "71327147"]),
#     (["hexagonal-sdk-kotlin", "tomshley/brands/global/tware/tech/products/hexagonal", "71327147"]),
#     (["hexagonal-sdk-python", "tomshley/brands/global/tware/tech/products/hexagonal", "71327147"]),
#     (["hexagonal-lib-py", "tomshley/brands/global/tware/tech/products/hexagonal", "71327147"]),
#     (["hexagonal-sdk-java", "tomshley/brands/global/tware/tech/products/hexagonal", "71327147"]),
#     (["hexagonal-sdk-scala", "tomshley/brands/global/tware/tech/products/hexagonal", "71327147"]),
#     (["telemetry-aggregator-scala", "tomshley/brands/global/tware/tech/products/telemetry", "69749919"]),
#     (["tuuid-scala", "tomshley/brands/global/tware/tech/products/tuuid", "69749871"]),
#     (["module-lib-tf", "tomshley/brands/global/tware/tech/products/provisioning", "69749804"]),
#     (["paste-css-lib-less", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
#     (["paste-jammer-scala", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
#     (["paste-pageperf-akkahttp", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
#     (["paste-sdk-py", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
#     (["paste-templating-akkahttp", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
#     (["paste-jammer-py", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
#     (["paste-js-lib", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
#     (["paste-pageperf-gevent2", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
#     (["paste-sdk-scala", "tomshley/brands/global/tware/tech/products/paste", "69749881"]),
#     (["paste-templating-jinja", "tomshley/brands/global/tware/tech/products/paste", "69749881"])
   ]
   git_project_mirrors = [
     (["hexagonal-plugin-sbt", module.tware-breakground-provision-organization-github.gh_repositories["hexagonal-plugin-sbt"].http_clone_url])
   ]
   github_mirror_token = var.github_mirror_token
 }
