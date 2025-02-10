resource "aws_instance" "dev-Instance" {
  ami                    = var.amiId[var.region]
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.dev-key.key_name
  vpc_security_group_ids = [aws_security_group.dev-sec_grp.id]
  availability_zone      = var.zone1
  tags = {
    Name    = "dev-Instance"
    project = "dev"
  }
}

resource "aws_ec2_instance_state" "dev-Instance" {
  instance_id = aws_instance.dev-Instance.id
  state       = "running"

}