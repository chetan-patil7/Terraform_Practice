terraform {
  backend "s3" {
	bucket = "chetan-bucket-1234567890"
	key = "chetan/terraform.tfstate"
	region = "us-east-1"
	dynamodb_table = "terraform_locks"
	encrypt = true
  }
}
