module "tware-breakground-provision-organization-github" {
  providers = {
    local  = local
    random  = random
    github  = github
  }
  source = "../tware-breakground-provision-organization-github"
  git_projects_with_parent=[
    (["gateway-scala", "tomshley", "tomshley", "private"]),
    (["gateway-sdk-scala", "tomshley", "tomshley", "private"]),
    (["hexagonal-lib-jvm", "tomshley", "tomshley", "private"]),
    (["hexagonal-plugin-sbt", "tomshley", "tomshley", "public"]),
    (["hexagonal-sdk-kotlin", "tomshley", "tomshley", "private"]),
    (["hexagonal-sdk-python", "tomshley", "tomshley", "private"]),
    (["hexagonal-lib-py", "tomshley", "tomshley", "private"]),
    (["hexagonal-sdk-java", "tomshley", "tomshley", "private"]),
    (["hexagonal-sdk-scala", "tomshley", "tomshley", "private"]),
    (["telemetry-aggregator-scala", "tomshley", "tomshley", "private"]),
    (["tuuid-scala", "tomshley", "tomshley", "private"]),
    (["module-lib-tf", "tomshley", "tomshley", "private"]),
    (["cicd-lib-docker", "tomshley", "tomshley", "private"]),
    (["microcontainer-lib-docker", "tomshley", "tomshley", "private"]),
    (["paste-css-lib-less", "tomshley", "tomshley", "private"]),
    (["paste-jammer-scala", "tomshley", "tomshley", "private"]),
    (["paste-pageperf-akkahttp", "tomshley", "tomshley", "private"]),
    (["paste-sdk-py", "tomshley", "tomshley", "private"]),
    (["paste-templating-akkahttp", "tomshley", "tomshley", "private"]),
    (["paste-jammer-py", "tomshley", "tomshley", "private"]),
    (["paste-js-lib", "tomshley", "tomshley", "public"]),
    (["paste-pageperf-gevent2", "tomshley", "tomshley", "private"]),
    (["paste-sdk-scala", "tomshley", "tomshley", "private"]),
    (["paste-templating-jinja", "tomshley", "tomshley", "private"])
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
     (["gateway-scala", "tomshley/brands/global/tware/tech/products/gateway", "71640761", "private"]), # path, parent, existing id
     (["gateway-sdk-scala", "tomshley/brands/global/tware/tech/products/gateway", "71640761", "private"]), # path, parent, existing id
     (["hexagonal-lib-jvm", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765", "private"]),
     (["hexagonal-plugin-sbt", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765", "private"]),
     (["hexagonal-sdk-kotlin", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765", "private"]),
     (["hexagonal-sdk-python", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765", "private"]),
     (["hexagonal-lib-py", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765", "private"]),
     (["hexagonal-sdk-java", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765", "private"]),
     (["hexagonal-sdk-scala", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765", "private"]),
     (["telemetry-aggregator-scala", "tomshley/brands/global/tware/tech/products/telemetry", "71640773", "private"]),
     (["tuuid-scala", "tomshley/brands/global/tware/tech/products/tuuid", "71640783", "private"]),
     (["module-lib-tf", "tomshley/brands/global/tware/tech/products/provisioning", "71640772", "private"]),
     (["cicd-lib-docker", "tomshley/brands/global/tware/tech/products/provisioning", "71640772", "private"]),
     (["microcontainer-lib-docker", "tomshley/brands/global/tware/tech/products/provisioning", "71640772", "private"]),
     (["paste-css-lib-less", "tomshley/brands/global/tware/tech/products/paste", "71640769", "private"]),
     (["paste-jammer-scala", "tomshley/brands/global/tware/tech/products/paste", "71640769", "private"]),
     (["paste-pageperf-akkahttp", "tomshley/brands/global/tware/tech/products/paste", "71640769", "private"]),
     (["paste-sdk-py", "tomshley/brands/global/tware/tech/products/paste", "71640769", "private"]),
     (["paste-templating-akkahttp", "tomshley/brands/global/tware/tech/products/paste", "71640769", "private"]),
     (["paste-jammer-py", "tomshley/brands/global/tware/tech/products/paste", "71640769", "private"]),
     (["paste-js-lib", "tomshley/brands/global/tware/tech/products/paste", "71640769", "private"]),
     (["paste-pageperf-gevent2", "tomshley/brands/global/tware/tech/products/paste", "71640769", "private"]),
     (["paste-sdk-scala", "tomshley/brands/global/tware/tech/products/paste", "71640769", "private"]),
     (["paste-templating-jinja", "tomshley/brands/global/tware/tech/products/paste", "71640769", "private"]),
     (["hotsourcer-npm", "tomshley/brands/global/tware/tech/products/hotsource", "72615114", "private"])
   ]
   git_project_mirrors = [
     (["gateway-scala", module.tware-breakground-provision-organization-github.gh_repositories["gateway-scala"].http_clone_url]),
     (["gateway-sdk-scala", module.tware-breakground-provision-organization-github.gh_repositories["gateway-sdk-scala"].http_clone_url]),
     (["hexagonal-lib-jvm", module.tware-breakground-provision-organization-github.gh_repositories["hexagonal-lib-jvm"].http_clone_url]),
     (["hexagonal-plugin-sbt", module.tware-breakground-provision-organization-github.gh_repositories["hexagonal-plugin-sbt"].http_clone_url]),
     (["hexagonal-sdk-kotlin", module.tware-breakground-provision-organization-github.gh_repositories["hexagonal-sdk-kotlin"].http_clone_url]),
     (["hexagonal-sdk-python", module.tware-breakground-provision-organization-github.gh_repositories["hexagonal-sdk-python"].http_clone_url]),
     (["hexagonal-lib-py", module.tware-breakground-provision-organization-github.gh_repositories["hexagonal-lib-py"].http_clone_url]),
     (["hexagonal-sdk-java", module.tware-breakground-provision-organization-github.gh_repositories["hexagonal-sdk-java"].http_clone_url]),
     (["hexagonal-sdk-scala", module.tware-breakground-provision-organization-github.gh_repositories["hexagonal-sdk-scala"].http_clone_url]),
     (["telemetry-aggregator-scala", module.tware-breakground-provision-organization-github.gh_repositories["telemetry-aggregator-scala"].http_clone_url]),
     (["tuuid-scala", module.tware-breakground-provision-organization-github.gh_repositories["tuuid-scala"].http_clone_url]),
     (["module-lib-tf", module.tware-breakground-provision-organization-github.gh_repositories["module-lib-tf"].http_clone_url]),
     (["cicd-lib-docker", module.tware-breakground-provision-organization-github.gh_repositories["cicd-lib-docker"].http_clone_url]),
     (["microcontainer-lib-docker", module.tware-breakground-provision-organization-github.gh_repositories["microcontainer-lib-docker"].http_clone_url]),
     (["paste-css-lib-less", module.tware-breakground-provision-organization-github.gh_repositories["paste-css-lib-less"].http_clone_url]),
     (["paste-jammer-scala", module.tware-breakground-provision-organization-github.gh_repositories["paste-jammer-scala"].http_clone_url]),
     (["paste-pageperf-akkahttp", module.tware-breakground-provision-organization-github.gh_repositories["paste-pageperf-akkahttp"].http_clone_url]),
     (["paste-sdk-py", module.tware-breakground-provision-organization-github.gh_repositories["paste-sdk-py"].http_clone_url]),
     (["paste-templating-akkahttp", module.tware-breakground-provision-organization-github.gh_repositories["paste-templating-akkahttp"].http_clone_url]),
     (["paste-jammer-py", module.tware-breakground-provision-organization-github.gh_repositories["paste-jammer-py"].http_clone_url]),
     (["paste-js-lib", module.tware-breakground-provision-organization-github.gh_repositories["paste-js-lib"].http_clone_url]),
     (["paste-pageperf-gevent2", module.tware-breakground-provision-organization-github.gh_repositories["paste-pageperf-gevent2"].http_clone_url]),
     (["paste-sdk-scala", module.tware-breakground-provision-organization-github.gh_repositories["paste-sdk-scala"].http_clone_url]),
     (["paste-templating-jinja", module.tware-breakground-provision-organization-github.gh_repositories["paste-templating-jinja"].http_clone_url]),
   ]
   github_mirror_token = var.github_mirror_token
   github_owner_group_path = var.github_owner_group_path
 }
# For Debug:
#output "groups" {
#  value = module.tware-breakground-provision-organization-gitlab.groups
#}
