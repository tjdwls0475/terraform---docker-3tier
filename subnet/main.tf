resource "aws_subnet" "subnet" {
    count = length(var.cidrs)

    vpc_id = var.vpc_id
    cidr_block = var.cidrs[count.index]
    availability_zone = "${var.region}${var.azones[count.index]}"

    tags = {
        Name = "${var.name}-${var.azones[count.index]}"
    }
}