data "aws_ami" "AMI_Id" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

output "Instance_ID" {
  description = "The ID of the AMI Instance is :"
  value       = data.aws_ami.AMI_Id.id
}