# RDS
resource "aws_db_instance" "rds" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  engine                 = "mysql"
  engine_version         = "8.0.20"
  instance_class         = "db.t2.micro"
  multi_az               = false
  name                   = "${local.name}rds"
  username               = "admin"
  password               = "cogus1234%"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}

# DB subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "harry-db-subnet-group"
  subnet_ids = module.db_subnet.ids
  
  tags = {
    Name = "${local.name}-db-subnet-group"
  }
}