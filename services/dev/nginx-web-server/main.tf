module "aws" {
  source = "../../../modules/aws"
}
module "ec2" {
  source = "../../../modules/ec2"
}
module "vpc" {
  source = "../../../modules/vpc"
}
