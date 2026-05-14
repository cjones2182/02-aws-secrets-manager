variable "alb_security_group" {
  description = "alb security group"
  type = list(string)
}
variable "vpc_id" {
  description = "id of vpc"
  type = string
}
variable "public_subnets" {
  description = "public_subnets"
  type = list(string)
}
variable "environment" {
  description = "environment name"
  type = string
}