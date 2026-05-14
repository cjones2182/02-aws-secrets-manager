variable "vpc_cidr" {
  description = "cidr of vpc main"
  type = string
}
variable "public_subnets" {
  description = "public subnets for vpc"
  type = list(string)
}
variable "availability_zones" {
  description = "availability zones for vpc"
  type = list(string)
}
variable "private_subnets" {
  description = "private subnets for vpc"
  type = list(string)
}
variable "database_subnets" {
  description = "rds subnets"
  type = list(string)
}
variable "igw" {
  description = "igw for vpc"
  type = bool
  default = true
}
variable "environment" {
  description = "environment name"
  type = string
}
