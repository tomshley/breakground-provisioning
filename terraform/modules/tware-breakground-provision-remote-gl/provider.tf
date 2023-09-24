terraform {
  required_providers {
    #    artifactory = {
    #      source  = "jfrog/artifactory"
    #      version = "~> 7.10.0"
    #    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 15.11.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}
