provider "aws" {
    region = "us-east-1"
}

variable "vpcname" {
    type = string
    default = "myvpc"
}

variable "inputname" {
    type = string
    description = "Set the name of the vpc"
}


resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = var.inputname
    }
}

output "vpcid" {
    value = aws_vpc.myvpc.id
}

variable "mytuple" {
    type = tuple([string, number, string])
    default = ["hello", 1, "world"]
}

variable "myobject" {
    type = object({
        name = string
        port = number
    })

    default = {
        name = "hello"
        port = 80
    }
}


variable "sshport" {
    type = number
    default = 22
}

variable "enabled" {
    default = true
}

variable "mylist" {
    type = list(string)
    default = ["Value1", "Value2"]
}

variable "mymap" {
    type = map(string)
    default = {
        "key1" = "value1"
        "key2" = "value2"
    }
}