resource "aws_vpc" "main-vpc" {
    cidr_block = var.vpc_config.cidr_block
    tags = {
        Name = var.vpc_config.name
    }
}

resource "aws_subnet" "main-subnet" {
    vpc_id = aws_vpc.main-vpc.id

    for_each = var.subnet_config

    cidr_block = each.value.cidr_block
    availability_zone = each.value.az  

    tags = {
        Name = each.key
    }
}

locals {
    public_subnet = {
        for key, config in var.subnet_config : key => config if config.public
    }
    private_subnet = {
        for key, config in var.subnet_config : key => config if !config.public
    }
}
#internet gateway
resource "aws_internet_gateway" "main-igw" {
    vpc_id = aws_vpc.main-vpc.id
    count = length(local.public_subnet) > 0 ? 1 : 0
}

#routing table
resource "aws_route_table" "main-rt" {
    count = length(local.public_subnet) > 0 ? 1 : 0
    vpc_id = aws_vpc.main-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-igw[0].id
    }
}

resource "aws_route_table_association" "rt-association" {
    for_each = local.public_subnet
    subnet_id = aws_subnet.main-subnet[each.key].id
    route_table_id = aws_route_table.main-rt[0].id
}