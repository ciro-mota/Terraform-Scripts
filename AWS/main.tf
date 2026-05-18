terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.44.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "ec2_instances" {
  source = "./modules/ec2"

  instance_count         = var.instance_count
  instance_type          = var.instance_type
  ami                    = var.ami
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name

  associate_public_ip_address   = var.associate_public_ip_address
  monitoring                    = var.monitoring
  root_volume_size              = var.root_volume_size
  root_volume_type              = var.root_volume_type
  enable_termination_protection = var.enable_termination_protection

  tags = var.resource_tags
}
