provider "aws" {
    region = "eu-central-1"
}

resource "aws_lightsail_instance" "terraform-2"{
    name                = "terraform-2"
    availability_zone   = "eu-central-1a"
    blueprint_id        = "ubuntu_22_04"
    bundle_id           = "nano_2_0"
    key_pair_name       = "new-key-pair"
}

output "instance_ip" {
    value = aws_lightsail_instance.terraform-2.public_ip_address
}