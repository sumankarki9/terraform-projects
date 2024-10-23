# Terraform VPC, Subnets, and EC2 Instances using Count 

`VPC:` Creates a virtual private cloud with CIDR block 10.0.0.0/16.

`Subnets:` Generates 4 subnets using the count feature with dynamic CIDR blocks.

`EC2 Instances:` Creates 4 instances distributed across the subnets using the element() function.
