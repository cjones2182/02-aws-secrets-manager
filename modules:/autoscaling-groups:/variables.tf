variable "web_security_group" {
  description = "security group for web tier"
type = list(string)
}
variable "instance_type" {
  description = "instance type for launch template"
  type = string
}
variable "image_id" {
  description = "ami id for instance"
  type = string
}
variable "min_size" {
  description = "min size of asg"
  type = number
}
variable "max_size" {
  description = "max size of asg"
  type = number
}
variable "desired_capacity" {
  description = "desired capacity of asg"
  type = number
}
variable "availability_zones" {
  description = "az's for vpc"
  type = list(string)
}
variable "public_subnets" {
  description = "public subnets for vpc"
  type = list(string)
}
variable "private_subnets" {
  description = "private subnets for vpc"
  type = list(string)
}
variable "main_alb_target_group" {
  description = "target group arn"
  type = list(string)
}
variable "environment" {
  description = "environment name"
  type = string
}
variable "ec2_instance_profile" {
  description = "instance profile for launch template"
  type = string
}