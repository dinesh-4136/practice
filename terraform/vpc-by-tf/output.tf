output "vpc_id" {
    value = aws_vpc.main.id
    description = "ID of the created VPC"   
}

output "public_subnet_ids" {
    value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
    description = "IDs of the created public subnets"
}

output "private_subnet_ids" {
    value = [aws_subnet.private-1.id, aws_subnet.private_2.id]
    description = "IDs of the created private subnets"
}