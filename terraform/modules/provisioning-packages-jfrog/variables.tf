variable "docker_repositories_local" {
  type = list(string)
  default = []
}
variable "docker_repositories_virtual" {
  type = list(tuple([string, string]))
  description = "<required:owner_path>, <required:key-override>"
  default = []
}
variable "docker_repositories_virtual_include" {
  type = list(tuple([string, string]))
  description = "docker repositories to include <required:owner_path>, <required:include_key>"
  default = []
}
variable "sbt_repositories_local" {
  type = list(string)
  default = []
}
variable "sbt_repositories_virtual" {
  type = list(tuple([string, string]))
  description = "<required:owner_path>, <required:key-override>"
  default = []
}
variable "sbt_repositories_virtual_include" {
  type = list(tuple([string, string]))
  description = "sbt repositories to include <required:owner_path>, <required:include_key>"
  default = []
}
