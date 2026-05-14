# =========================================================================================
# launch template
# =========================================================================================

resource "aws_launch_template" "main" {
    name = "main-lauch-template"
  instance_type = var.instance_type
  vpc_security_group_ids = var.web_security_group
  image_id = var.image_id
}
# =========================================================================================
# asg 
# =========================================================================================
resource "aws_autoscaling_group" "main_autoscaling_group" {
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  vpc_zone_identifier = var.private_subnets
  target_group_arns = var.main_alb_target_group
  
   tag {
    key                 = "environment"
    value               = var.environment
    propagate_at_launch = true
   }

  launch_template {
    id = aws_launch_template.main.id
    version = "$Latest"
  }
}