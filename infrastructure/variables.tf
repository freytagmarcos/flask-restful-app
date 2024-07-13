variable "aws_region" {
  default = "us-east-1"
}

variable "sg_access_ip" {
  type = string
  default = "0.0.0.0/0"
}