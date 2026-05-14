
output "alb_security_group" {
  description = "security group for alb"
  value = aws_security_group.alb_security_group.id
}

output "web_security_group" {
  description = "security group for web tier"
  value = aws_security_group.web_security_group.id
}
