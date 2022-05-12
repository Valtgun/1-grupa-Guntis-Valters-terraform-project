resource "aws_instance" "app_server" {
  ami           = data.aws_ami.Ubuntu.id
  instance_type = var.instance_type
}

data "aws_ami" "Ubuntu" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [
      "Ubuntu 20.04 LTS"
    ]
  }
}
