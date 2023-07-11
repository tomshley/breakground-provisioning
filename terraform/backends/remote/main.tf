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
module "tware-breakground-provision-remote-gl" {
  providers = {
    random = random
    local  = local
    gitlab = gitlab
    github = github
  }
  source              = "../../modules/tware-breakground-provision-remote-gl"
  github_mirror_token = var.github_mirror_token
}
