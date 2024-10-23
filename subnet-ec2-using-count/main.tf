## creating 2 submet using count.

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.72.1"
        }
    }
}

provider "aws" {
    region = "us-east-1" 
}

locals {
    project = "project-01"
}

# creating vpc
resource "aws_vpc" "main-vpc" {
    cidr_block = "10.0.0.0/16"
    tags       = {
        Name     = "${local.project}-vpc"
    }
}

# creating 4 subnet using count 
resource "aws_subnet" "sub-main" {
    vpc_id      = aws_vpc.main-vpc.id
    cidr_block  = "10.0.${count.index}.0/24"
    tags = {
        Name    = "${local.project}-subnet-${count.index}"
    }
    
    count       = 4
}

# creating 4 ec2 in 2 subnet using count
resource "aws_instance" "main" {
    ami           = "ami-0866a3c8686eaeeba"
    instance_type = "t2.micro"
    count         = 4
    subnet_id = element(aws_subnet.sub-main[*].id, count.index)

    tags = {
        Name = "${local.project}-instance-${count.index}"
    }


}
output "aws_subnet_id" {
    value = aws_subnet.sub-main
}
