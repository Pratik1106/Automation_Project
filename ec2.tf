module "ec2_i" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "Automation_project"
  instance_count         = 1

  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.small"
  key_name               = "Docker"
  iam_instance_profile   = aws_iam_instance_profile.S3_profile.name
}