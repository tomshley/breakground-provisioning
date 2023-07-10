variable "git_projects_with_parent" {
  type        = list(tuple([string, string, string, string]))
  description = "<required:repo-name>, <required:repo-path>, <optional:parrent-id>, <optional:mirror-address> - ([\"hexagonal-sdk-kotlin\", \"tomshley/brands/global/tware/tech/products/hexagonal\", \"69749680\", \"https://mirroaddress.com/mirrror\"])"
}