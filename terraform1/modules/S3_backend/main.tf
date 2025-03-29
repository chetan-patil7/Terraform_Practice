terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "demo-terraform-state"
  tags = {
	Name = "demo-terraform-state"
  }

}

resource "aws_dynamodb_table" "terraform_state_lock" {
	name = "terraform-remote-state-2021"
	billing_mode = "PAY_PER_REQUEST"
	hash_key = "LockID"

	attribute {
		name = "LockID"
		type = "S"
	}
}
