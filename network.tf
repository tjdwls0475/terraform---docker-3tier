# VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
        Name = "${local.name}-vpc"
    }
}

# IGW
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${local.name}-igw"
    }
}

# NGW
resource "aws_eip" "ngw_eip" {
    count = length(var.azones)

    vpc = true

    tags = {
        Name = "${local.name}-ngw-eip-${var.azones[count.index]}"
    }
}

resource "aws_nat_gateway" "ngw" {
    count = length(var.azones)

    subnet_id = module.public_subnet.ids[count.index]
    allocation_id = aws_eip.ngw_eip[count.index].id

    tags = {
        Name = "${local.name}-ngw-${var.azones[count.index]}"
    }
}

# Public Route Table
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.name}-pub-rt"
  }
}

resource "aws_route" "pub_r" {
    route_table_id = aws_route_table.pub_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "pub_rt_a" {
    count = length(var.public_subnet_cidrs)

    subnet_id = module.public_subnet.ids[count.index]
    route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pub_rt_a_mgmt" {
    subnet_id = module.mgmt_subnet.ids[0]
    route_table_id = aws_route_table.pub_rt.id
}

# Private Route Table
resource "aws_route_table" "pri_rt" {
    count = length(var.azones)

    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${local.name}-pri-rt-${var.azones[count.index]}"
    }
}

resource "aws_route" "pri_r" {
    count = length(var.azones)

    route_table_id = aws_route_table.pri_rt[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw[count.index].id
}

resource "aws_route_table_association" "pri_rt_a_web" {
    count = length(var.azones)

    subnet_id = module.web_subnet.ids[count.index]
    route_table_id = aws_route_table.pri_rt[count.index].id
}

resource "aws_route_table_association" "pri_rt_a_was" {
    count = length(var.azones)

    subnet_id = module.was_subnet.ids[count.index]
    route_table_id = aws_route_table.pri_rt[count.index].id
}

resource "aws_route_table_association" "pri_rt_a_db" {
    count = length(var.azones)

    subnet_id = module.db_subnet.ids[count.index]
    route_table_id = aws_route_table.pri_rt[count.index].id
}