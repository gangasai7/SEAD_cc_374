resource "aws_db_subnet_group" "main" {
  name = "epicbook-db-subnet-group"

  subnet_ids = [
    aws_subnet.private1.id,
    aws_subnet.private2.id
  ]
}
resource "aws_db_instance" "mysql" {

  identifier         = "epicbook-db"
  allocated_storage  = 20

  engine             = "mysql"
  engine_version     = "8.0"

  instance_class     = "db.t3.micro"

  db_name            = "epicbook"

  username           = var.db_username
  password           = var.db_password

  publicly_accessible = false

  skip_final_snapshot = true

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  db_subnet_group_name = aws_db_subnet_group.main.name
}