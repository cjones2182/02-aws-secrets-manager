output "vpc_id" {
  description = "vpc id"
  value = aws_vpc.main.id
}
output "public_subnets" {
  description = "public subnets"
  value = aws_subnet.public_subnets[*].id
}
output "availability_zones" {
  description = "az's for vpc"
  value = var.availability_zones
}
output "private_subnets" {
  description = "private subnets"
  value = aws_subnet.private_subnets[*].id
}
output "database_subnets" {
 description = "database subnets"
 value = aws_subnet.database_subnets[*].id  
}
