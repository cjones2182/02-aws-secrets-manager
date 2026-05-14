
variable "load_balancer_arn" {
  description = "load balancer arn"
  type = string
}
variable "aws_autoscaling_group" {
  description = "auto AutoScalingGroupName"
  type = string
}
variable "rds_database" {
  description = "rds DbInstanceIdentifier"
  type = string
}