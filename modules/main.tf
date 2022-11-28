provider "aws" {
  region = "us-east-1"
}

module "ec2module" {
  source = "./ec2"
  ec2name = "myec2"
}

# This is just an example how to use the module's outputs
output "module_output" {
  value = module.ec2module.instance_id
}