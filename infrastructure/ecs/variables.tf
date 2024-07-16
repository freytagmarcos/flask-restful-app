#--- ecs/variables.tf ---

variable "app_name" {
  type = string
}

variable "app_port" {
  type = number
}

variable "container_image" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group" {
  type = list(string)
}

variable "env_vars" {
  type = list(object({
    name  = string
    value = string
  }))
}

variable "aws_region" {
  type = string
}