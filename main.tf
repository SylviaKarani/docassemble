provider "aws" {
  region = "eu-central-1"
}

variable "instance_name" {
  description = "Name for the instance"
  default     = "docassemble-instance"
}

resource "aws_lightsail_key_pair" "my-key-pair" {
  name       = "light-sail-key-v1"
  public_key = file("lightsail_key.pub")
}

resource "aws_lightsail_instance" "docassemble_setup" {
  name              = var.instance_name
  availability_zone = "eu-central-1a"
  blueprint_id      = "ubuntu_22_04"
  bundle_id         = "nano_2_0"
  key_pair_name     = aws_lightsail_key_pair.my-key-pair.name

  tags = {
    Name = var.instance_name
  }
}

output "instance_ip" {
  value = aws_lightsail_instance.docassemble_setup.public_ip_address
}
