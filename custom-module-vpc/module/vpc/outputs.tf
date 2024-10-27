#vpc
output "vpc-id" {
    value = aws_vpc.main-vpc.id  
}

locals {
    public_subnet_output = {
        for key, config in local.public_subnet: key => {
            subnet_id = aws_subnet.main-subnet[key].id
            az        = aws_subnet.main-subnet[key].availability_zone
        }
    }

    private_subnet_output = {
        for key, config in local.private_subnet: key => {
            subnet_id = aws_subnet.main-subnet[key].id
            az        = aws_subnet.main-subnet[key].availability_zone
        }
    }    
}
#subnets Details
output "public_subnets" {
    value = local.public_subnet_output
}

output "private_subnets" {
    value = local.private_subnet_output
}