variable "zone1" {
  default = "us-east-1a"
}

variable "region" {
  default = "us-east-1"
}

variable "amiId" {
  type = map(any)
  default = {
    us-east-1 = "ami-04b4f1a9cf54c11d0"
    us-east-2 = "ami-0cb91c7de36eed2cb"
    us-west-1 = "ami-0a887e401f7654935"
    us-west-2 = "ami-0d1cd67c26f5fca19"
  }

}