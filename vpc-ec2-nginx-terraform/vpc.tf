#vpc
resource "aws_vpc" "webserver-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "webserver_vpc"
    }
  
}
# private subnet
resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.webserver-vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "private-subnet-01"
    }
}

#public subnet
resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.webserver-vpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-01"
    }
}

#internet gateway
resource "aws_internet_gateway" "igw-webserver-vpc" {
    vpc_id = aws_vpc.webserver-vpc.id
    tags = {
      Name = "igw-webserver"
    }
}

#routing table
resource "aws_route_table" "route-table" {
    vpc_id = aws_vpc.webserver-vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-webserver-vpc.id
    }
    tags = {
      Name = "route-table-webserver"
    }
}

resource "aws_route_table_association" "public-sub" {
    route_table_id = aws_route_table.route-table.id
    subnet_id = aws_subnet.public-subnet.id
  
}

