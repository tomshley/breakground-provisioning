variable "git_projects_with_parent" {
  type        = list(tuple([string, string, string, string]))
  description = "<required:repo-name>, <required:repo-path>, <required (can be blank):parrent-id>- ([\"hexagonal-sdk-kotlin\", \"tomshley/brands/global/tware/tech/products/hexagonal\", \"69749680\"])"
}
variable "git_project_mirrors" {
  type        = list(tuple([string, string]))
  description = "<required:repo-name>, <required:repo-url>"
  default     = []
}
variable "git_flow_structure" {
  type = object(
    {
      production  = list(string)
      integration = list(string)
      feature     = list(string)
      release     = list(string)
      hotfix      = list(string)
      support     = list(string)
    }
  )
  default = {
    production     = ["main"]
    integration    = ["develop"]
    feature        = ["feature/"]
    release        = ["release/"]
    hotfix         = ["hotfix/"]
    support        = ["support/"]
    version_prefix = ["v"]
  }
}
