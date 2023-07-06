terraform {
  # backend "http" {}

  required_providers {
    artifactory = {
      source  = "jfrog/artifactory"
      version = "7.10.0"
    }
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
  }
}
provider "artifactory" {
  url          = "https://${var.artifactory_base_url}/artifactory"
  access_token = sensitive("${var.artifactory_access_token}")
}

provider "gitlab" {
  token = sensitive(var.gitlab_token)
}


module "tware-bootstrap-remote" {
  source = "../../modules/tware-bootstrap-remote"
}
