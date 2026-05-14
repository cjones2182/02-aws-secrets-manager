output "main_alb_target_group" {
  description = "target group arn"
  value = aws_lb_target_group.main_alb_target_group.arn
}
output "load_balancer_arn" {
  description = "alb load balancer arn"
  value = aws_lb.main-alb.arn
}