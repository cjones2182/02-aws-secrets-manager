resource "aws_db_instance" "main-rds" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.rds_username
  password             = var.rds_password
  skip_final_snapshot  = true
  db_subnet_group_name = "rds_subnet"
  multi_az = true
  vpc_security_group_ids = [ var.web_security_group ]
  storage_encrypted = true
}
resource "aws_db_subnet_group" "rds_subnet" {
 subnet_ids =  var.database_subnets

}
