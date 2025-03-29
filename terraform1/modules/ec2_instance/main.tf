terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

resource "aws_instance" "example" {
  ami           = var.ami_value
  instance_type = var.instance_type
}
