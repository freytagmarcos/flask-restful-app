variable "aws_region" {
  default = "us-east-1"
}

variable "aws_account" {
  default = "114368227931"
}

variable "sg_access_ip" {
  type = string
  default = "0.0.0.0/0"
}

variable "org_id" {
  type = string
  default = "66927eceaf94500ac8115c7a"
}

variable "app_name" {
  type = string
  default = "rest-api-flask"
}

variable "app_port" {
  type = number
  default = 5000
}

variable "app_version" {
  type = string
  default = "1.0.2"
}
