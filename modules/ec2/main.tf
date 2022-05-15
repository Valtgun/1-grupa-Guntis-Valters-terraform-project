resource "aws_instance" "app_server" {
  ami           = "ami-0c4f7023847b90238"
  # data.aws_ami.Ubuntu.id
  instance_type = var.instance_type
}

/*
data "aws_ami" "Ubuntu" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [
      "ubuntu-focal-20.04*"
    ]
  }
}
*/
