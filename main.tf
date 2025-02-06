provider "aws" {
  region = "eu-central-1"
}

variable "instance_name" {
  description = "Name for the instance"
  default     = "docassemble-instance"
}

variable "lightsail_key" {
    description = "Lightsail key pair"
    default     = "lightsail_key"
}

resource "aws_lightsail_key_pair" "keypair" {
  name       = var.lightsail_key
  public_key = file("lightsail_key.pub")
}

resource "aws_lightsail_instance" "docassemble" {
  name              = var.instance_name
  availability_zone = "eu-central-1a"
  blueprint_id      = "ubuntu_22_04"
  bundle_id         = "nano_2_0"
  key_pair_name     = aws_lightsail_key_pair.keypair.name

  tags = {
    Name = var.instance_name
  }
}

output "instance_ip" {
  value = aws_lightsail_instance.docassemble.public_ip_address
}
