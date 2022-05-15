terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "GV-terraform-up-and-running-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "GV-terraform-up-and-running-locks"
    encrypt        = true
  }
}

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
