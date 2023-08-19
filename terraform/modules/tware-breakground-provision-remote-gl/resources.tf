module "tware-breakground-provision-organization-github" {
  providers = {
    local  = local
    random  = random
    github  = github
  }
  source = "../tware-breakground-provision-organization-github"
  git_projects_with_parent=[
    (["gateway-scala", "tomshley", "tomshley"]),
    (["gateway-sdk-scala", "tomshley", "tomshley"]),
    (["hexagonal-lib-jvm", "tomshley", "tomshley"]),
    (["hexagonal-plugin-sbt", "tomshley", "tomshley"]),
    (["hexagonal-sdk-kotlin", "tomshley", "tomshley"]),
    (["hexagonal-sdk-python", "tomshley", "tomshley"]),
    (["hexagonal-lib-py", "tomshley", "tomshley"]),
    (["hexagonal-sdk-java", "tomshley", "tomshley"]),
    (["hexagonal-sdk-scala", "tomshley", "tomshley"]),
    (["telemetry-aggregator-scala", "tomshley", "tomshley"]),
    (["tuuid-scala", "tomshley", "tomshley"]),
    (["module-lib-tf", "tomshley", "tomshley"]),
    (["cicd-lib-docker", "tomshley", "tomshley"]),
    (["microcontainer-lib-docker", "tomshley", "tomshley"]),
    (["paste-css-lib-less", "tomshley", "tomshley"]),
    (["paste-jammer-scala", "tomshley", "tomshley"]),
    (["paste-pageperf-akkahttp", "tomshley", "tomshley"]),
    (["paste-sdk-py", "tomshley", "tomshley"]),
    (["paste-templating-akkahttp", "tomshley", "tomshley"]),
    (["paste-jammer-py", "tomshley", "tomshley"]),
    (["paste-js-lib", "tomshley", "tomshley"]),
    (["paste-pageperf-gevent2", "tomshley", "tomshley"]),
    (["paste-sdk-scala", "tomshley", "tomshley"]),
    (["paste-templating-jinja", "tomshley", "tomshley"])
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
     (["gateway-scala", "tomshley/brands/global/tware/tech/products/gateway", "71640761"]), # path, parent, existing id
     (["gateway-sdk-scala", "tomshley/brands/global/tware/tech/products/gateway", "71640761"]), # path, parent, existing id
     (["hexagonal-lib-jvm", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765"]),
     (["hexagonal-plugin-sbt", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765"]),
     (["hexagonal-sdk-kotlin", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765"]),
     (["hexagonal-sdk-python", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765"]),
     (["hexagonal-lib-py", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765"]),
     (["hexagonal-sdk-java", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765"]),
     (["hexagonal-sdk-scala", "tomshley/brands/global/tware/tech/products/hexagonal", "71640765"]),
     (["telemetry-aggregator-scala", "tomshley/brands/global/tware/tech/products/telemetry", "71640773"]),
     (["tuuid-scala", "tomshley/brands/global/tware/tech/products/tuuid", "71640783"]),
     (["module-lib-tf", "tomshley/brands/global/tware/tech/products/provisioning", "71640772"]),
     (["cicd-lib-docker", "tomshley/brands/global/tware/tech/products/provisioning", "71640772"]),
     (["microcontainer-lib-docker", "tomshley/brands/global/tware/tech/products/provisioning", "71640772"]),
     (["paste-css-lib-less", "tomshley/brands/global/tware/tech/products/paste", "71640769"]),
     (["paste-jammer-scala", "tomshley/brands/global/tware/tech/products/paste", "71640769"]),
     (["paste-pageperf-akkahttp", "tomshley/brands/global/tware/tech/products/paste", "71640769"]),
     (["paste-sdk-py", "tomshley/brands/global/tware/tech/products/paste", "71640769"]),
     (["paste-templating-akkahttp", "tomshley/brands/global/tware/tech/products/paste", "71640769"]),
     (["paste-jammer-py", "tomshley/brands/global/tware/tech/products/paste", "71640769"]),
     (["paste-js-lib", "tomshley/brands/global/tware/tech/products/paste", "71640769"]),
     (["paste-pageperf-gevent2", "tomshley/brands/global/tware/tech/products/paste", "71640769"]),
     (["paste-sdk-scala", "tomshley/brands/global/tware/tech/products/paste", "71640769"]),
     (["paste-templating-jinja", "tomshley/brands/global/tware/tech/products/paste", "71640769"])
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
 }
