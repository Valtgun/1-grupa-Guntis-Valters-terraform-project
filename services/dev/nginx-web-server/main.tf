module "aws" {
  source = "../../../modules/aws"
}
module "vpc" {
  source = "../../../modules/vpc"
}
module "ec2" {
  subnet_id_pub1 = "${module.vpc.subnet_id_public1}"
  instance_type = "${var.instance_type}"
  source = "../../../modules/ec2"
}
