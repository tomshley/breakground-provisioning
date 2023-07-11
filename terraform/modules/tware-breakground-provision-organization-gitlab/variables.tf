variable "git_projects_with_parent" {
  type = list(tuple([string, string, string]))
}
variable "git_project_mirrors" {
  type        = list(tuple([string, string]))
  description = "<required:repo-name>, <required:repo-url>"
  default     = []
}

variable "github_mirror_token" {
  type = string
  default = ""
}
