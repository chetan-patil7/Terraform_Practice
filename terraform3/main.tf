terraform {
  required_providers {
	aws = {
	  source  = "hashicorp/aws"
	  version = "5.91.0"
	}
  }
}

variable "ami" {
  type = string

}

variable "instance_type" {
  type = map(string)

  default = {
	dev = "t2.micro"
  	stage = "t2.small"
  	prod = "t2.large"

  }

}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace,"t2.micro")
}
