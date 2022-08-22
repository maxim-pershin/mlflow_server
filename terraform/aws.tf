terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.15.0"
    }
  }
}


provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region = var.aws_region
}


//##########################################################################
// VPC
//##########################################################################
# Crate a AWS VPC which contains the following
#   - VPC
#   - Public subnet(s)
#   - Private subnet(s)
#   - Internet Gateway
#   - Routing table

resource "aws_vpc" "testapp" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true # Internal domain name
  enable_dns_hostnames = true # Internal host name

  tags = {
    Name = "testapp-vpc"
  }
}

resource "aws_subnet" "testapp_public_subnet" {
  # Number of public subnet is defined in vars
  count = var.number_of_public_subnets

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index + 2}.0/24"
  vpc_id                  = aws_vpc.myvpc1.id
  map_public_ip_on_launch = true # This makes the subnet public

  tags = {
    Name = "testapp-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "testapp_private_subnet" {
  # Number of private subnet is defined in vars
  count = var.number_of_private_subnets

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.testapp.id

  tags = {
    Name = "testapp-private-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "testapp_internet_gateway" {
  vpc_id = aws_vpc.testapp.id

  tags = {
    Name = "testapp-internet-gateway"
  }
}

resource "aws_route_table" "testapp_route_table" {
  vpc_id = aws_vpc.testapp.id

  route {
    # Associated subet can reach public internet
    cidr_block = "0.0.0.0/0"

    # Which internet gateway to use
    gateway_id = aws_internet_gateway.testapp_internet_gateway.id
  }

  tags = {
    Name = "testapp-public-custom-rtb"
  }
}

resource "aws_route_table_association" "testapp-custom-rtb-public-subnet" {
  count          = 2
  route_table_id = aws_route_table.testapp_route_table.id
  subnet_id      = aws_subnet.testapp_public_subnet.*.id[count.index]
}

