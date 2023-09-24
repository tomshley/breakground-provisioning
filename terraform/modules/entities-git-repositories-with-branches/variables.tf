variable "existing_projects_branches" {
  type = list(object({
    project_name = string
    branch_name  = string
  }))
  description = "existing_projects_branches = [{project_name = \"\" branch_name = \"\"}]"
  default = []
}
variable "managed_projects" {
  type = list(object({
    project_name = string
    project_id   = string
  }))
  description = "managed_projects = [{project_name = \"\" project_id = \"\" }]"
  default = []
}
variable "git_flow_projects_with_branch_defaults_grouped" {
  type = any
  description = "value from tware-hydrator-git-repositories-with-parents.git_flow_projects_with_branch_defaults_grouped"
}
variable "git_flow_target_default_branch_types" {
  type = list(string)
  default = ["production", "integration"]
}

