# ========================================================================================
#  alb security group 
# ========================================================================================
resource "aws_security_group" "alb_security_group" {
  name        = "alb-security-group"
  description = "Allow port 80 traffic"
  vpc_id      = var.vpc_id

   tags = {
    name = "${var.environment}-alb security group"
    environment = var.environment
  }
}

#ingress
resource "aws_vpc_security_group_ingress_rule" "alb_security_group_ingress" {
  security_group_id = aws_security_group.alb_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
# egress rule
resource "aws_vpc_security_group_egress_rule" "alb_security_group_egress" {
  security_group_id = aws_security_group.alb_security_group.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"    # ports not needed due to all traffic permitted to egress
}
# ==============================================================================
# web security group 
# ==============================================================================
resource "aws_security_group" "web_security_group" {
  name        = "web-security-group"
  description = "Allow port 80 traffic from alb"
  vpc_id      = var.vpc_id
  tags = {
    name = "${var.environment}-web security group"
    environment = var.environment
  }
}
#ingress rule
resource "aws_vpc_security_group_ingress_rule" "web_security_group_ingress" {
  security_group_id = aws_security_group.web_security_group.id
  referenced_security_group_id = aws_security_group.alb_security_group.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
# egress rule
resource "aws_vpc_security_group_egress_rule" "web_security_group_egress" {
  security_group_id = aws_security_group.web_security_group.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"    # ports not needed due to all traffic permitted to egress
}
# ==============================================================================
# database security group 
# ==============================================================================
resource "aws_security_group" "database_security_group" {
  name        = "database-security-group"
  description = "Allow port 3306 from web tier for mySQL"
  vpc_id      = var.vpc_id

  tags = {
    name = "${var.environment}-database security group"
    environment = var.environment
  }
}
#ingress rule
resource "aws_vpc_security_group_ingress_rule" "database_security_group_ingress" {
  security_group_id = aws_security_group.database_security_group.id
  referenced_security_group_id = aws_security_group.web_security_group.id
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}
# egress rule
resource "aws_vpc_security_group_egress_rule" "database_security_group_egress" {
  security_group_id = aws_security_group.database_security_group.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"    # ports not needed due to all traffic permitted to egress
}