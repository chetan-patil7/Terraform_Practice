terraform {
  required_providers {
	aws = {
	  source = "hashicorp/aws"
	  version = "5.91.0"
    }
  }
}

resource "aws_instance" "tf_ins" {

  ami = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  tags = {
	Name = "terraform-instance"
  }
}

resource "aws_s3_bucket" "tf_bucket" {
  bucket = "chetan-bucket-1234567890"
  tags = {
	Name = "terraform-bucket"
  }

}

resource "aws_dynamodb_table" "terraform_lock" {

  name = "terraform_locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
	name = "LockID"
	type = "S"
  }

  tags = {
	Name = "terraform-lock"
  }

}
