# MGMT SG
resource "aws_security_group" "mgmt_sg" {
    name = "${local.name}-mgmt-sg"
    vpc_id = aws_vpc.vpc.id
    description = "Allow ssh"

    tags = {
        Name = "${local.name}-mgmt-sg"
    }
}

resource "aws_security_group_rule" "mgmt_allow_ssh_ingress" {
    security_group_id = aws_security_group.mgmt_sg.id
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow ssh"
}

resource "aws_security_group_rule" "mgmt_allow_egress" {
    security_group_id = aws_security_group.mgmt_sg.id
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow egress"
}

# WEB SG
resource "aws_security_group" "web_sg" {
    name = "${local.name}-web-sg"
    vpc_id = aws_vpc.vpc.id
    description = "Allow http"

    tags = {
        Name = "${local.name}-web-sg"
    }
}

resource "aws_security_group_rule" "web_allow_http" {
    security_group_id = aws_security_group.web_sg.id
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow http"
}

resource "aws_security_group_rule" "web_allow_ssh" {
    security_group_id = aws_security_group.web_sg.id
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "10.0.0.0/16" ]
    description = "allow ssh"
}

resource "aws_security_group_rule" "web_allow_egress" {
    security_group_id = aws_security_group.web_sg.id
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow"
}

# WAS SG
resource "aws_security_group" "was_sg" {
    name = "${local.name}-was-sg"
    vpc_id = aws_vpc.vpc.id
    description = "allow 8080"

    tags = {
        Name = "${local.name}-was-sg"
    }
}

resource "aws_security_group_rule" "was_allow_8080" {
    security_group_id = aws_security_group.was_sg.id
    type = "ingress"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [ "10.0.0.0/16" ]
    description = "allow 8080"
}

resource "aws_security_group_rule" "was_allow_ssh" {
    security_group_id = aws_security_group.was_sg.id
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "10.0.0.0/16" ]
    description = "allow ssh"
}

resource "aws_security_group_rule" "was_allow_egress" {
    security_group_id = aws_security_group.was_sg.id
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow"
}

# ALB SG
resource "aws_security_group" "alb_sg" {
    name = "${local.name}-alb-sg"
    vpc_id = aws_vpc.vpc.id
    description = "allow http"

    tags = {
        Name = "${local.name}-alb-sg"
    }
}

resource "aws_security_group_rule" "alb_allow_http" {
    security_group_id = aws_security_group.alb_sg.id
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow http"
}

resource "aws_security_group_rule" "alb_allow_egress" {
    security_group_id = aws_security_group.alb_sg.id
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow"
}

# DB SG
resource "aws_security_group" "db_sg" {
    name = "${local.name}-db-sg"
    vpc_id = aws_vpc.vpc.id
    description = "allow 3306"

    tags = {
        Name = "${local.name}-db-sg"
    }
}

resource "aws_security_group_rule" "db_allow_3306" {
    security_group_id = aws_security_group.db_sg.id
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [ "10.0.0.0/16" ]
    description = "allow 8080"
}

resource "aws_security_group_rule" "db_allow_egress" {
    security_group_id = aws_security_group.db_sg.id
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "all"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "allow egress"
}