provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "database" {
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
}

output "private_ip" {
  value = aws_instance.database.private_ip
}


resource "aws_instance" "webserver" {
  ami             = "ami-0b0dcb5067f052a63"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
  user_data = <<EOF
        #!/bin/bash
        sudo yum update -y
        sudo yum install httpd -y
        sudo systemctl start httpd
        sudo systemctl enable httpd
        echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
        EOF
}

# create an eip
resource "aws_eip" "eip" {
    instance = aws_instance.webserver.id
}

output "public_ip" {
  value = aws_eip.eip.public_ip
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # http ingress
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
