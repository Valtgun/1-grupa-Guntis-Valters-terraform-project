module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = var.name
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}
