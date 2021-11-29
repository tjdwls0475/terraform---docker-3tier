# Subnets
module "mgmt_subnet" {
    source = "./subnet"

    vpc_id = aws_vpc.vpc.id
    cidrs = var.mgmt_subnet_cidrs
    region = var.region
    azones = var.azones
    name = "${local.name}-mgmt-subnet"
}

module "public_subnet" {
    source = "./subnet"

    vpc_id = aws_vpc.vpc.id
    cidrs = var.public_subnet_cidrs
    region = var.region
    azones = var.azones
    name = "${local.name}-public-subnet"
}

module "web_subnet" {
    source = "./subnet"

    vpc_id = aws_vpc.vpc.id
    cidrs = var.web_subnet_cidrs
    region = var.region
    azones = var.azones
    name = "${local.name}-web-subnet"
}

module "was_subnet" {
    source = "./subnet"

    vpc_id = aws_vpc.vpc.id
    cidrs = var.was_subnet_cidrs
    region = var.region
    azones = var.azones
    name = "${local.name}-was-subnet"
}

module "db_subnet" {
    source = "./subnet"

    vpc_id = aws_vpc.vpc.id
    cidrs = var.db_subnet_cidrs
    region = var.region
    azones = var.azones
    name = "${local.name}-db-subnet"
}

# EC2
module "mgmt-bastion" {
    source = "./ec2"

    subnet_id = module.mgmt_subnet.ids[0]
    ami = var.ami
    instance_type = "t2.micro"
    sg_id = aws_security_group.mgmt_sg.id
    availability_zone = "${var.region}${var.azones[0]}"
    public_ip = true
    name = "${local.name}-mgmt-bastion"
}

module "web" {
    source = "./ec2"

    subnet_id = module.web_subnet.ids[0]
    ami = var.ami
    instance_type = "t2.medium"
    sg_id = aws_security_group.web_sg.id
    availability_zone = "${var.region}${var.azones[0]}"
    public_ip = false
    name = "${local.name}-web"
}

module "was" {
    source = "./ec2"

    subnet_id = module.was_subnet.ids[0]
    ami = var.ami
    instance_type = "t2.medium"
    sg_id = aws_security_group.was_sg.id
    availability_zone = "${var.region}${var.azones[0]}"
    public_ip = false
    name = "${local.name}-was"
}