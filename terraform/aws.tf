terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.15.0"
    }
  }
}


provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  token = var.AWS_SESSION_TOKEN
  region = var.AWS_REGION
}

data "aws_availability_zones" "available" {}


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
  vpc_id                  = aws_vpc.testapp.id
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


//##########################################################################
// EC2
//##########################################################################
//resource "aws_security_group" "testapp" {
//  vpc_id = aws_vpc.testapp.id
//
//  ingress {
//    protocol  = "-1"
//    from_port = 0
//    to_port   = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  egress {
//    protocol    = "-1"
//    from_port   = 0
//    to_port     = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}
//
//resource "aws_network_interface" "testapp" {
//  subnet_id       = aws_subnet.testapp_public_subnet[0].id
//  private_ips     = ["10.0.0.50"]
//  security_groups = [aws_security_group.testapp.id]
//}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "mlflow"
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_instance" "mlflow" {
  ami           = "ami-0d70546e43a941d70" # us-west-2
  instance_type = "t2.large"
  associate_public_ip_address = "true"
  key_name = aws_key_pair.generated_key.key_name
  subnet_id = aws_subnet.testapp_public_subnet[0].id

//  network_interface {
//    network_interface_id = aws_network_interface.testapp.id
//    device_index         = 0
//  }
  tags = {
    Name = "mlflow"
  }
}

output "mlflow_associate_public_ip_address" {
  description = "mlflow_associate_public_ip_address"
  value       = aws_instance.mlflow.public_ip
}

resource "local_file" "mlflow_private_key" {
  filename = "${path.module}/keys/mlflow_private_key.pem"
  content = tls_private_key.private_key.private_key_pem
}