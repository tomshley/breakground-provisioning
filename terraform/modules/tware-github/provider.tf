terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}