terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "15.11.0"
    }
  }
}

provider "gitlab" {
  token = sensitive(var.gitlab_token)
}

module "tware-bootstrap-local-gl" {
  source = "../../modules/tware-bootstrap-local-gl"

}