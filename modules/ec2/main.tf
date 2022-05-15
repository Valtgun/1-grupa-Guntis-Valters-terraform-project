resource "aws_instance" "app_server" {
  ami           = "ami-0c4f7023847b90238"
  # data.aws_ami.Ubuntu.id
  instance_type = var.instance_type

  #subnet_id = vpc.aws_subnet.private1.id
  subnet_id = var.subnet_id_pub1

  tags = {
    Name = "GV Ubuntu 20.04 LTS"
  }
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
