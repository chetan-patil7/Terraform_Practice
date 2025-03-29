terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "5.91.0"
		}
	}

}

variable "ami" {
	description = "value of the ami"

}

variable "instance_type" {
	description = "value of the instance type"
}


resource "aws_instance" "example" {
	ami = var.ami
	instance_type = var.instance_type

}
