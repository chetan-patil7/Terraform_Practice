terraform {
  backend "s3" {
	bucket = "demo-terraform-state"
	key = "terraform-remote-state-2021"
	region = "us-east-1"
	dynamodb_table = "terraform-remote-state-2021"

  }
}
