# VPC by Terraform
resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = var.vpc_name
    }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.vpc_name}-igw"
    }
}

# Create public subnets
resource "aws_subnet" "public_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr_1
    availability_zone = "${var.region}a"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.vpc_name}-public-subnet-1"
    }
}
resource "aws_subnet" "public_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr_2
    availability_zone = "${var.region}b"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.vpc_name}-public-subnet-2"
    }
}

# Create Private subnets
resource "aws_subnet" "private_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr_1
    availability_zone = "${var.region}a"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.vpc_name}-private-subnet-1"
    }
}
resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr_2
    availability_zone = "${var.region}b"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.vpc_name}-private-subnet-2"
    }
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
    domain = "vpc"
}

# Create NAT Gateway in public subnet
resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public-1.id

    depends_on = [aws_internet_gateway.igw]

    tags = {
        Name = ${var.vpc_name}-nat-gw
    }
}

# Create Route Table for public subnets
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = var.public_rt_cidr_block
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.vpc_name}-public-rt"
    }
}

resource "aws_route_table_association" "public_1_association" {
    subnet_id = aws_subnet.public_1.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2_association" {
    subnet_id = aws_subnet.public_2.id
    route_table_id = aws_route_table.public_rt.id
}

# Create Route Table for private subnets
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_blcok = var.private_rt_cidr_block
        nat_gateway_id = aws_nat_gateway.nat_gw.id
    }

    tags = {
        Name = "${var.vpc_name}-private-rt"
    }
}

resource "aws_route_table_association" "private_1_association" {
    subnet_id = aws_subnet.private_1.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_2_association" {
    subnet_id = aws_subnet.private_2.id
    route_table_id = aws_route_table.private_rt.id
}
