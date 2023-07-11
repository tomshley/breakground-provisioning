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
  providers = {
    gitlab = gitlab
  }
  source = "../../modules/tware-bootstrap-local-gl"
  github_mirror_token = var.github_mirror_token
}
