variable "region" {
    description = "AWS region to deploy resources"
    default = "ap-south-1"
}

variable "cidr_block" {
    description = "CIDR block for the VPC"
    default = "10.0.0.0/16"
}

variable "vpc_name" {
    description = "Name of the VPC"
    default = "my-vpc"
}

variable "public_subnet_cidr_1" {
    description = "CIDR block for the first public subnet"
    default = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
    description = "CIDR block for the second public subnet"
    default = "10.0.2.0/24"
}

variable "private_subnet_cidr_1" {
    description = "CIDR block for the first private subnet"
    default = "10.0.3.0/24"
}

variable "private_subnet_cidr_2" {
    description = "CIDR block for the second private subnet"
    default = "10.0.4.0/24"
}

variable "public_rt_cidr_block" {
    description = "CIDR block for the public route table"
    default = "0.0.0.0/0"
}

variable "private_rt_cidr_block" {
    description = "CIDR block for the private route table"
    default = "0.0.0.0/0"
}