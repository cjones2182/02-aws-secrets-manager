
variable "vpc_id" {
  description = "vpc id"
  type = string
}
variable "alb_security_group" {
  description = "alb security group"
  type = string
}
variable "web_security_group" {
  description = "web security group"
  type = string
}
variable "database_security_group" {
  description = "database security group"
  type = string
}
variable "environment" {
  description = "environment name"
  type = string
}