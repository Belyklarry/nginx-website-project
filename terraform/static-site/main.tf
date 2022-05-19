terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

provider "aws" {
  region=var.region
}
resource "aws_instance" "site" {
    ami = "ami-0df5b771d6e8bfdf9"
    instance_type="t3.micro"
    key_name="aws"
    vpc_security_group_ids = ["sg-0982fcbcd25a96548"]
        tags = {
            Name = var.name
            group = var.group
        }
}
