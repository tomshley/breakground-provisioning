#resource "github_organization_settings" "organization" {
#  billing_email = var.organization_settings_billing_email
#  company = var.organization_settings_company
#  blog = var.organization_settings_blog
#  email = var.organization_settings_email
#  twitter_username = var.organization_settings_twitter_username
#  location = var.organization_settings_location
#  name = var.organization_settings_name
#  description = var.organization_settings_description
#  has_organization_projects = true
#  has_repository_projects = true
#  default_repository_permission = "read"
#  members_can_create_repositories = true
#  members_can_create_public_repositories = true
#  members_can_create_private_repositories = true
#  members_can_create_internal_repositories = true
#  members_can_create_pages = true
#  members_can_create_public_pages = true
#  members_can_create_private_pages = true
#  members_can_fork_private_repositories = true
#  web_commit_signoff_required = true
#  advanced_security_enabled_for_new_repositories = false
#  dependabot_alerts_enabled_for_new_repositories=  false
#  dependabot_security_updates_enabled_for_new_repositories = false
#  dependency_graph_enabled_for_new_repositories = false
#  secret_scanning_enabled_for_new_repositories = false
#  secret_scanning_push_protection_enabled_for_new_repositories = false
#}

module "tware-git-project-with-parent" {
  source = "../tware-git-project-with-parent"
  git_projects_with_parent = var.git_projects_with_parent
}

resource "github_repository" "repositories" {
  for_each     = module.tware-git-project-with-parent.project_data
  name         = replace(each.key, "/", "-")
  visibility = "public"
  default_branch = "main"
}