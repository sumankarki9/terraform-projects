resource "aws_instance" "ec2-nginx" {
    ami                         = "ami-0866a3c8686eaeeba"
    instance_type               = "t2.micro"
    subnet_id                   = aws_subnet.public-subnet.id
    vpc_security_group_ids      = [aws_security_group.webserver-sg.id]
    associate_public_ip_address = true

    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                sudo systemctl start nginx
                sudo mkdir -p /var/www/html
                echo "Successfully Installed Nginx Using Terraform" | sudo tee /var/www/html/index.html
                sudo systemctl restart nginx 
            EOF
    tags = {
        Name = "ec2-Nginx"
    }
}
