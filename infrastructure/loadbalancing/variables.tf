#--- loadbalancing/variables.tf ---

variable "alb_name" {
  
}

variable "security_groups" {
  
}

variable "public_subnets" {
  
}

variable "tg_port" {
  
}

variable "tg_protocol" {
  
}

variable "alb_healthy_threshold" {
  
}

variable "alb_unhealthy_threshold" {
  
}

variable "alb_interval" {
  
}

variable "alb_timeout" {
  
}

variable "vpc_id" {
  
}

variable "listener_port" {
  type = number
}

variable "listener_protocol" {
  type = string
}