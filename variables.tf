variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "control_key_name" {
  description = "AWS key pair for Ansible control node"
  type        = string
}

variable "managed_key_name" {
  description = "AWS key pair for Ansible managed nodes"
  type        = string
}

variable "my_ip" {
  description = "Your public IP address in CIDR notation"
  type        = string
}