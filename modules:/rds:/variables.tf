variable "allocated_storage" {
  description = "disk space for rds"
  type = number
}
variable "db_name" {
  description = "name of db"
  type = string
}
variable "engine" {
  description = "engine of db"
  type = string
}
variable "engine_version" {
  description = "engine version"
  type = number
}
variable "instance_class" {
  description = "instance class of DB"
  type = string
}

variable "database_subnets" {
  description = "db subnets"
  type = list(string)
}
variable "web_security_group" {
  description = "web security group"
  type = string
}
variable "rds_password" {
  description = "rds password"
  type = string
}
variable "rds_username" {
  description = "rds username"
  type = string
}