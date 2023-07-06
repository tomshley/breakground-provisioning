resource "artifactory_general_security" "security" {
  enable_anonymous_access = false
}

locals {
  naming_prefix="tware-hexagonal"
  fronted_repositories = [
    artifactory_remote_sbt_repository.global-sbt-remote.key,
    artifactory_remote_terraform_repository.global-terraform-remote.key,
    artifactory_local_terraform_provider_repository.hexagonal-tf-local.key,
    artifactory_local_sbt_repository.hexagonal-sbt-local.key
  ]
  repositories = flatten([local.fronted_repositories,
    artifactory_virtual_generic_repository.hexagonal.key
  ])
}

resource "artifactory_group" "hexagonal-readers-group" {
  name             = "${local.naming_prefix}-readers-group"
  admin_privileges = false
  users_names      = [artifactory_user.hexagonal-reader.id]
}

resource "artifactory_group" "hexagonal-deployers-group" {
  name             = "${local.naming_prefix}-deployers-group"
  admin_privileges = false
  users_names      = [artifactory_user.hexagonal-reader.id, artifactory_user.hexagonal-deployer.id]
}


resource "artifactory_permission_target" "hexagonal-reader-perms" {
  name = "${local.naming_prefix}-reader-perms"

  repo {
    # example: 
    # includes_pattern = ["foo/**"]
    # excludes_pattern = ["bar/**"]
    repositories = local.fronted_repositories

    actions {
      groups {
        name        = "${local.naming_prefix}-readers"
        permissions = ["read"]
      }
    }
  }
}

resource "artifactory_permission_target" "hexagonal-deployer-perms" {
  name = "${local.naming_prefix}-deployer-perms"

  repo {
    # example: 
    # includes_pattern = ["foo/**"]
    # excludes_pattern = ["bar/**"]
    repositories = local.fronted_repositories

    actions {
      groups {
        name        = "${local.naming_prefix}-deployers"
        permissions = ["read", "write"]
      }
    }
  }
}

resource "artifactory_remote_sbt_repository" "global-sbt-remote" {
  key                             = "global-sbt-remote-foo"
  url                             = "https://repo1.maven.org/maven2/"
  fetch_jars_eagerly              = true
  fetch_sources_eagerly           = false
  suppress_pom_consistency_checks = true
  reject_invalid_jars             = true
}

resource "artifactory_remote_terraform_repository" "global-terraform-remote" {
  key                     = "global-terraform-remote"
  url                     = "https://github.com/"
  terraform_registry_url  = "https://registry.terraform.io"
  terraform_providers_url = "https://releases.hashicorp.com"
}


resource "artifactory_local_sbt_repository" "hexagonal-sbt-local" {
  key = "hexagonal-sbt-local"
}

resource "artifactory_local_terraform_provider_repository" "hexagonal-tf-local" {
  key = "hexagonal-tf-local"
}

resource "artifactory_virtual_generic_repository" "hexagonal" {
  key               = "hexagonal"
  repo_layout_ref   = "simple-default"
  repositories      = local.fronted_repositories
  default_deployment_repo = artifactory_local_sbt_repository.hexagonal-sbt-local.key
  description       = "Repository for Tware Hexagonal Artifacts"
  notes             = "This repo also includes a facade for selected maven artifacts"
  
# example: 
#   includes_pattern  = "com/jfrog/**,cloud/jfrog/**"
#   excludes_pattern  = "com/google/**"
}

resource "random_password" "hexagonal-reader-password" {
  count = 1
  length = 16
  special = true
}

resource "artifactory_user" "hexagonal-reader" {
  name                          = "hexagonal-reader"
  email = "noreply+hexagonalreader@tware.tech"
  password = random_password.hexagonal-reader-password[0].result
  admin                         = false
  profile_updatable               = false
  disable_ui_access                = true
  internal_password_disabled     = true
}

resource "random_password" "hexagonal-deployer-password" {
  count = 1
  length = 16
  special = true
}

resource "artifactory_user" "hexagonal-deployer" {
  name                          = "hexagonal-deployer"
  email = "noreply+hexagonaldeployer@tware.tech"
  password = random_password.hexagonal-deployer-password[0].result
  admin                         = false
  profile_updatable               = false
  disable_ui_access                = true
  internal_password_disabled     = true
}


resource "local_file" "hexagonal-reader-key" {
  depends_on = [ artifactory_user.hexagonal-reader ]
  
    content  = templatefile("${path.module}/templates/artifactory-users.tftpl", {
      output = {
      jf_user_key = "${artifactory_user.hexagonal-reader.password}"
      }
  })
    filename = ".tware.hexagonal.artifactory.user.reader.key"
}

resource "local_file" "hexagonal-deployer-key" {
  depends_on = [ artifactory_user.hexagonal-deployer ]
content  = templatefile("${path.module}/templates/artifactory-users.tftpl", {
  output = {
      jf_user_key = "${artifactory_user.hexagonal-deployer.password}"
  }
  })
      filename = ".tware.hexagonal.artifactory.user.deployer.key"
}
