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
      version = "3.6.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.1"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "16.8.1"
    }
    github = {
      source  = "integrations/github"
      version = "5.45.0"
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
    (["paste-core-scala", "tomshley", "tomshley", "public"]),
    (["paste-jammer-akkahttp", "tomshley", "tomshley", "private"]),
    (["paste-lib", "tomshley", "tomshley", "public"]),
    (["paste-templating-scala", "tomshley", "tomshley", "private"]),
    (["paste-tests-scala", "tomshley", "tomshley", "private"]),
    (["aws-gen-ai-builder-session-20231101", "tomshley", "tomshley", "public"]),
    (["aws-reinvent-2023", "tomshley", "tomshley", "public"]),
    (["dbflags-java-example", "tomshley", "tomshley", "private"]),
    (["eda-example", "tomshley", "tomshley", "public"]),
    (["eda-person-org-concept", "tomshley", "tomshley", "public"]),
    (["eda-example-infra-tf", "tomshley", "tomshley", "public"]),
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
    (["paste-common", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-jammer", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-monolith", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-resources", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-templating", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["paste-tests", "tomshley/brands/global/tware/tech/products/paste", "", "private"]),
    (["hotsourcer-npm", "tomshley/brands/global/tware/tech/products/hotsource", "", "private"]),
    (["dbflags-java", "tomshley/brands/global/tware/tech/products/examples/data", "", "private"]),
    (["aws-gen-ai-builder-session-20231101", "tomshley/brands/global/tware/tech/products/examples", "", "private"]),
    (["aws-reinvent-2023", "tomshley/brands/global/tware/tech/products/examples", "", "private"]),
    (["eda-scala-pulsar", "tomshley/brands/global/tware/tech/products/examples", "", "private"]),
    (["eda-person-org-concept", "tomshley/brands/global/tware/tech/products/examples", "", "private"]),
    (["eda-pulsar-aws-tf", "tomshley/brands/global/tware/tech/products/examples", "", "private"]),
    (["www-tomshley-com", "tomshley/brands/usa/tomshleyllc/tech", "", "private"]),
    (["functionals-reactive-example", "tomshley/brands/global/docs/architecture/execution/functional", "", "private"]),
    (["infosec-reactive", "tomshley/brands/global/docs/architecture/execution/infosec", "", "private"]),
    (["operational-reactive", "tomshley/brands/global/docs/architecture/execution/operational", "", "private"]),
    (["reactive-patterns", "tomshley/brands/global/docs/architecture/execution/patterns", "", "private"]),
    (["people-process-conways", "tomshley/brands/global/docs/architecture/execution/people", "", "private"]),
    (["reactive-principles", "tomshley/brands/global/docs/architecture/execution/principles", "", "private"]),
    (["fast-architecture-playbook", "tomshley/brands/global/docs/architecture/execution/technology/playbooks", "", "private"]),
    (["domain-driven-design", "tomshley/brands/global/docs/architecture/execution/technology/learning", "", "private"]),
    (["event-driven-modeling", "tomshley/brands/global/docs/architecture/execution/technology/learning", "", "private"]),
    (["reactive-event-driven", "tomshley/brands/global/docs/architecture/execution/technology/learning", "", "private"]),
    (["data-centric", "tomshley/brands/global/docs/architecture/execution/technology/themes", "", "private"]),
    (["recurring-revenue", "tomshley/brands/global/docs/architecture/strategy", "", "private"]),
    (["2023-community-banking", "tomshley/brands/global/docs/architecture/trends", "", "private"]),
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
    (["paste-common", "paste-core-scala"]),
    (["paste-jammer", "paste-jammer-akkahttp"]),
    (["paste-resources", "paste-lib"]),
    (["paste-templating", "paste-templating-scala"]),
    (["paste-tests", "paste-tests-scala"]),
    (["aws-gen-ai-builder-session-20231101", ""]),
    (["aws-reinvent-2023", ""]),
    (["dbflags-java", "dbflags-java-example"]),
    (["eda-scala-pulsar", "eda-example"]),
    (["eda-person-org-concept", "eda-person-org-concept"]),
    (["eda-pulsar-aws-tf", "eda-example-infra-tf"]),
  ]
}
