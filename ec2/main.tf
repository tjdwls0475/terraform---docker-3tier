resource "aws_instance" "ec2" {
    subnet_id = var.subnet_id
    ami = var.ami
    instance_type = var.instance_type
    key_name = "Bastionkey"
    vpc_security_group_ids = [ var.sg_id ]
    availability_zone      = var.availability_zone
    associate_public_ip_address = var.public_ip

    tags = {
        Name = var.name
    }
}