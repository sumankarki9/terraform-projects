output "instance_pubic_ip" {
    description = "The public ip of the EC2 instance"
    value = aws_instance.ec2-nginx.public_ip
}

output "instance_url" {
    description = "The url to access the Nginx server"
    value = "http://${aws_instance.ec2-nginx.public_ip}"
}