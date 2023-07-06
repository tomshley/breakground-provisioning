variable "github_root_organization" {
  type = string
}
variable "github_dayzero_repositories" {
  type = list(tuple([ string, string ]))
}

variable "organization_settings_billing_email" {
  type = string
}
variable "organization_settings_company" {
  type = string
}
variable "organization_settings_blog" {
  type = string
}
variable "organization_settings_email" {
  type = string
}
variable "organization_settings_twitter_username" {
  type = string
}
variable "organization_settings_location" {
  type = string
}
variable "organization_settings_name" {
  type = string
}
variable "organization_settings_description" {
  type = string
}