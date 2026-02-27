variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "instance-type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "key-pair" {
  description = "Name of the existing key pair to use for EC2 instance"
  type        = string
  default     = "tf"
}

variable "availability-zone" {
  description = "Availability zone to deploy EC2 instance"
  type        = string
  default     = "ap-south-1a"
}

variable "instance-name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "tf-ec2"
}