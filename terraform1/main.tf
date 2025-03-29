
module "ec2_instance" {
	source = "./modules/ec2_instance"
	ami_value = "ami-0c55b159cbfafe1f0"
	instance_type = "t2.micro"
}

module "S3_bucket" {
	source = "./modules/S3_backend"

}
