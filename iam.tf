resource "aws_iam_role_policy" "ec2s3fullacces_policy" {
  name = "ec2s3fullacces_policy"
  role = aws_iam_role.S3_Role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
      },
    ]
  })
}

resource "aws_iam_role" "S3_Role" {
  name = "S3_Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "S3_profile" {
  name = "S3_Role_profile"
  role = aws_iam_role.S3_Role.name
}