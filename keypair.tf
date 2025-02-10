resource "aws_key_pair" "dev-key" {
  key_name   = "dev-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO3z5FvrcX70JGxsYLy60olK5kkU2rYDRrgMga3vB+t6 User@Chetan"
}