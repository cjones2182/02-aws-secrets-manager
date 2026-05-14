output "main_autoscaling_group" {
  description = "autoscaling group"
  value = aws_autoscaling_group.main_autoscaling_group.arn
}