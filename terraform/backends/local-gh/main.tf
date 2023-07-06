terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "gitlab" {
  token = sensitive(var.github_token)
}

module "tware-bootstrap-local-gh" {
  source = "../../modules/tware-bootstrap-local-gh"
}