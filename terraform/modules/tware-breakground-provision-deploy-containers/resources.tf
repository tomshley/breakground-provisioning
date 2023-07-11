resource "terraform_data" "dockers" {
  provisioner "local-exec" {
    command = "make push"
    working_dir = "../../../dockers"
  }
}
