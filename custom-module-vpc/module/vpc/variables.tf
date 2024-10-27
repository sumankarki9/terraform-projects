variable "vpc_config" {
    description = "To get the CIDR and Name of VPC from the user"
    type = object({
        cidr_block = string
        name       = string
    })
}   

variable "subnet_config" {
    description = "TO Get the CIDR and Azs for the subnets"
    type = map(object({
        cidr_block = string
        az         = string
        public = optional(bool, false)

    }))
}
