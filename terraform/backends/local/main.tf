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

module "tware-breakground-provision-local-gl" {
  providers = {
    gitlab = gitlab
  }
  source              = "../../modules/tware-breakground-provision-local-gl"
  github_mirror_token = var.github_mirror_token
}

module "tware-breakground-provision-deploy-containers" {
  source              = "../../modules/tware-breakground-provision-deploy-containers"
}
