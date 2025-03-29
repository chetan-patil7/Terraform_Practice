output "s3_bucket_id" {
   value = aws_s3_bucket.demo_bucket.id

}

output "aws_dynamodb_table" {
	value = aws_dynamodb_table.terraform_state_lock.name

}
