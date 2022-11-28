provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "t2.micro"
}

resource "aws_eip" "elastic" {
    instance = aws_instance.ec2.id
}

output "EIP" {
    value = aws_eip.elastic.public_ip
}