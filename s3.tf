module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "automation-project"
  acl    = "private"
  versioning = {
    enabled = true
  }
}