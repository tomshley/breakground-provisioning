#
# Copyright 2023 Tomshley LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# @author Thomas Schena @sgoggles <https://github.com/sgoggles> | <https://gitlab.com/sgoggles>
#

terraform {
  backend "http" {}

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "15.11.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = sensitive(var.github_token)
  owner = var.github_owner_org
}
provider "gitlab" {
  token = sensitive(var.gitlab_token)
}
module "provisioning-backends-remote-gl" {
  providers = {
    random = random
    local  = local
    gitlab = gitlab
    github = github
  }
  source                  = "../../modules/provisioning-backends-remote-gl"
  github_mirror_token     = var.github_mirror_token
  github_owner_group_path = var.github_owner_org
  github_projects_with_parent = [
    (["gateway-scala", "tomshley", "tomshley", "private"]),
    (["gateway-sdk-scala", "tomshley", "tomshley", "private"]),
    (["hexagonal-lib-jvm", "tomshley", "tomshley", "public"]),
    (["hexagonal-plugins-sbt", "tomshley", "tomshley", "public"]),
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
    (["paste-templating-jinja", "tomshley", "tomshley", "private"]),
    (["dbflags-java-example", "tomshley", "tomshley", "public"]),
  ]
  gitlab_projects_with_parent = [
    (["gateway-scala", "tomshley/brands/global/tware/tech/products/gateway", "", "private"]),     # path, parent, existing
    (["gateway-sdk-scala", "tomshley/brands/global/tware/tech/products/gateway", "", "private"]), # path, parent, exi
    (["hexagonal-lib-jvm", "tomshley/brands/global/tware/tech/products/hexagonal", "", "private"]),
    (["hexagonal-plugin-sbt", "tomshley/brands/global/tware/tech/products/hexagonal", "", "private"]),
    (["hexagonal-plugins-sbt", "tomshley/brands/global/tware/tech/products/hexagonal", "", "private"]),
    (["hexagonal-sdk-kotlin", "tomshley/brands/global/tware/tech/products/hexagonal", "", "private"]),
    (["hexagonal-sdk-python", "tomshley/brands/global/tware/tech/products/hexagonal", "", "private"]),
    (["hexagonal-lib-py", "tomshley/brands/global/tware/tech/products/hexagonal", "", "private"]),
    (["hexagonal-sdk-java", "tomshley/brands/global/tware/tech/products/hexagonal", "", "private"]),
    (["hexagonal-sdk-scala", "tomshley/brands/global/tware/tech/products/hexagonal", "", "private"]),
    (["telemetry-aggregator-scala", "tomshley/brands/global/tware/tech/products/telemetry", "", "private"]),
    (["tuuid-scala", "tomshley/brands/global/tware/tech/products/tuuid", "", "private"]),
    (["module-lib-tf", "tomshley/brands/global/tware/tech/products/provisioning", "", "private"]),
    (["cicd-lib-docker", "tomshley/brands/global/tware/tech/products/provisioning", "", "private"]),
    (["microcontainer-lib-docker", "tomshley/brands/global/tware/tech/products/provisioning", "", "private"]),
    (["paste-css-lib-less", "tomshley/brands/global/tware/tech/products/paste", "", ""]),
    (["paste-jammer-scala", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-pageperf-akkahttp", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-sdk-py", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-templating-akkahttp", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-jammer-py", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-js-lib", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-pageperf-gevent2", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-sdk-scala", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-templating-jinja", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["hotsourcer-npm", "tomshley/brands/global/tware/tech/products/hotsource", "", "private"]),
    (["dbflags-java", "tomshley/brands/global/tware/tech/products/examples/data", "", "private"]),
    (["www-tomshley-com", "tomshley/brands/usa/tomshleyllc/tech", "", "private"]),
  ]
  gitlab_project_mirrors = [
    (["gateway-scala", ""]),
    (["gateway-sdk-scala", ""]),
    (["hexagonal-lib-jvm", ""]),
    (["hexagonal-plugins-sbt", ""]),
    (["hexagonal-sdk-kotlin", ""]),
    (["hexagonal-sdk-python", ""]),
    (["hexagonal-lib-py", ""]),
    (["hexagonal-sdk-java", ""]),
    (["hexagonal-sdk-scala", ""]),
    (["telemetry-aggregator-scala", ""]),
    (["tuuid-scala", ""]),
    (["module-lib-tf", ""]),
    (["cicd-lib-docker", ""]),
    (["microcontainer-lib-docker", ""]),
    (["paste-css-lib-less", ""]),
    (["paste-jammer-scala", ""]),
    (["paste-pageperf-akkahttp", ""]),
    (["paste-sdk-py", ""]),
    (["paste-templating-akkahttp", ""]),
    (["paste-jammer-py", ""]),
    (["paste-js-lib", ""]),
    (["paste-pageperf-gevent2", ""]),
    (["paste-sdk-scala", ""]),
    (["paste-templating-jinja", ""]),
    (["dbflags-java", "dbflags-java-example"]),
  ]
}
