
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "automation-project"
  cidr = "10.0.0.0/16"
}