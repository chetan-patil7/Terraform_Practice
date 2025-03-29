output "ec2_public_ip" {
  value = aws_instance.example.public_ip

}

output "EC2_id" {
  value = aws_instance.example.id

}
