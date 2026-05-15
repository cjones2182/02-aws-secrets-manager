
# ============================================================================== 
# vpc variables 
# ==============================================================================
variable "vpc_cidr" {
  description = "cidr of vpc main"
  type        = string
}
variable "public_subnets" {
  description = "public subnets for vpc"
  type        = list(string)
}
variable "availability_zones" {
  description = "availability zones for vpc"
  type        = list(string)
}
variable "private_subnets" {
  description = "private subnets for vpc"
  type        = list(string)
}
variable "database_subnets" {
  description = "rds subnets"
  type        = list(string)
}
variable "igw" {
  description = "igw for vpc"
  type        = bool
  default     = true
}
variable "environment" {
  description = "environment name"
  type        = string
}
# ====================================================================================
# security groups 
# ====================================================================================
variable "alb_security_group" {
  description = "alb security group"
  type        = string
}
variable "web_security_group" {
  description = "web security group"
  type        = string
}
variable "database_security_group" {
  description = "database security group"
  type        = string
}
# ====================================================================================
# launch template
# ====================================================================================
variable "instance_type" {
  description = "instance type for launch template"
  type        = string
}
variable "image_id" {
  description = "ami id for instance"
  type        = string
}
variable "min_size" {
  description = "min size of asg"
  type        = number
}
variable "max_size" {
  description = "max size of asg"
  type        = number
}
variable "desired_capacity" {
  description = "desired capacity of asg"
  type        = number
}
# ====================================================================================
# rds 
# ====================================================================================
variable "allocated_storage" {
  description = "disk space for rds"
  type        = number
}
variable "db_name" {
  description = "name of db"
  type        = string
}
variable "engine" {
  description = "engine of db"
  type        = string
}
variable "engine_version" {
  description = "engine version"
  type        = number
}
variable "instance_class" {
  description = "instance class of DB"
  type        = string
}

# ====================================================================================
# cloudwatch
# ====================================================================================

# ====================================================================================
# secrets manager
# ====================================================================================

variable "rds_username" {
  description = "rds username"
  type        = string
}
