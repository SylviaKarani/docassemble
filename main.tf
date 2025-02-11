provider "aws" {
  region = "eu-central-1"
}

# Use timestamp for unique naming
locals {
  timestamp = formatdate("YYYYMMDDhhmmss", timestamp())
  unique_instance_name = "docassemble-${local.timestamp}"
  unique_key_name     = "docassemble-key-${local.timestamp}"
}

variable "instance_name" {
  description = "Name for the instance"
  default     = "docassemble-instance"
}

variable "public_key"{
  description = "Path to the public key"
}

resource "aws_lightsail_key_pair" "docassemble_key" {
  name       = local.unique_key_name
  public_key = var.public_key

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lightsail_instance" "docassemble_instance" {
  name              = local.unique_instance_name
  availability_zone = "eu-central-1a"
  blueprint_id      = "ubuntu_22_04"
  bundle_id         = "nano_2_0"
  key_pair_name     = local.unique_key_name

  tags = {
    Name      = local.unique_instance_name
    ManagedBy = "terraform"
    CreatedAt = local.timestamp
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "instance_ip" {
  value = aws_lightsail_instance.docassemble_instance.public_ip_address
}

output "instance_name" {
  value = aws_lightsail_instance.docassemble_instance.name
}

# output "key_pair_name" {
#   value = aws_lightsail_key_pair.docassemble_key.name
# }