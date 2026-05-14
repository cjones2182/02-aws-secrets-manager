# ====================================================================================
# alb 
# ====================================================================================
resource "aws_lb" "main-alb" {
  name               = "main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_group
  subnets            = var.public_subnets
  enable_deletion_protection = false
  
 tags = {
    name = "${var.environment}-alb"
  }

}
# =======================================================================================
# alb target group  
# =======================================================================================
resource "aws_lb_target_group" "main_alb_target_group" {
  name        = "main-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  tags = {
    name = "${var.environment}-alb target group"
  }


  health_check {
    enabled = true
    protocol = "HTTP"
    port = 80
    path = "/"
    healthy_threshold = "5"
    unhealthy_threshold = "2"
    timeout = "5"
    matcher = "200"

  }
}
# =======================================================================================
# alb listener  
# =======================================================================================
resource "aws_lb_listener" "main_alb_listener" {
  load_balancer_arn = aws_lb.main-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_alb_target_group.arn
  }
   tags = {
    name = "${var.environment}-alb listener"
  }

}
