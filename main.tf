terraform {
  backend "http" {}

  required_providers {
    artifactory = {
      source = "jfrog/artifactory"
      version = "7.10.0"
    }
    random = {
        source = "hashicorp/random"
        version = "3.5.1"
    }
    local = {
        source = "hashicorp/local"
        version = "2.4.0"
    }
  }
}
provider "artifactory" {
  
  url           = "https://${var.artifactory_base_url}/artifactory"
  access_token  = "${var.artifactory_access_token}"
}

module "tware-hexagonal-artifactory" {
  source = "./modules/tware-hexagonal-artifactory"
}