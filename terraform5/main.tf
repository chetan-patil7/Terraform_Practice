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

provider "vault" {
	address = "http:<>"
	skip_child_token = true

	auth_login {
	  path = "auth/approle/login"

	  parameters = {
		role_id   = "<>"
		secret_id = "<>"
	  }
	}
}

data "vault_kv_secret_v2" "example" {
  mount = "kv"
  name = "test-secret"

}

resource "aws_instance" "example" {
	ami = "ami-084568db4383264d4"
	instance_type = "t2.micro"
	tags = {
	  secret = data.vault_kv_secret_v2.example.data["username"]
	}

}
