terraform {
  required_providers {
	aws = {
	  source  = "hashicorp/aws"
	  version = "5.91.0"
	}
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "cidr_block" {
	default = "10.0.0.0/16"

}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")

}

resource "aws_vpc" "tf_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
	Name = "tf_vpc"
  }

}

resource "aws_subnet" "vpc_subnet" {
	vpc_id = aws_vpc.tf_vpc.id
	cidr_block = "10.0.0.0/24"
	map_public_ip_on_launch = true
	availability_zone = "us-east-1a"
	tags = {
		Name = "tf_subnet"
	}

}

resource "aws_internet_gateway" "vpc_igw" {
	vpc_id = aws_vpc.tf_vpc.id
	tags = {
		Name = "tf_igw"
	}

}

resource "aws_route_table" "vpc_rt" {
	vpc_id = aws_vpc.tf_vpc.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.vpc_igw.id
	}
}

resource "aws_route_table_association" "rta1" {
	subnet_id = aws_subnet.vpc_subnet.id
	route_table_id = aws_route_table.vpc_rt.id

}

resource "aws_security_group" "web_sg" {
	name = web
	vpc_id = aws_vpc.tf_vpc.id

	ingress {
		description = "Allow HTTP"
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		description = "Allow SSH"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		description = "Allow all traffic out"
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "web_sg"
	}

}

resource "aws_instance" "web_server" {
	ami = "ami-084568db4383264d4"
	instance_type = "t2.micro"
	key_name = aws_key_pair.my_key_pair.key_name
	security_groups = [aws_security_group.web_sg.name]
	subnet_id = aws_subnet.vpc_subnet.id

	connection {
	  type = "ssh"
	  user = "ubuntu"
	  private_key = file("~/.ssh/id_rsa")
	  host = self.public_ip
	}

	provisioner "file" {
	  source = "app.py"
	  destination = "/home/ubuntu/app.py"

	}

	provisioner "remote-exec" {
		inline = [
			"echo 'Hello from remote instance'",
			"sudo apt-get update",
			"sudo apt-get install python3-pip -y",
			"sudo pip3 install flask",
			"cd /home/ubuntu",
			"sudo python3 app.py &"
		 ]
	}
}
