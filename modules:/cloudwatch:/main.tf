# =========================================================================================
# sns for alarms
# =========================================================================================

resource "aws_sns_topic" "cloudwatch_sns_topic" {
  name = "cloudwatch-sns-topic"
}
# ========================================================================================
# alb alarm
# ========================================================================================

resource "aws_cloudwatch_metric_alarm" "alb_cloudwatch_metric" {
  alarm_name                = "alb-cloudwatch-metric"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "HTTPCode_ELB_500_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = 120
  statistic                 = "Sum"
  threshold                 = 3
  alarm_description         = "This metric monitors http 500 error codes"
  alarm_actions = [ aws_sns_topic.cloudwatch_sns_topic.arn]

  dimensions = {
    LoadBalancer = var.load_balancer_arn
  }
}
# ========================================================================================
# asg alarm
# ========================================================================================
resource "aws_cloudwatch_metric_alarm" "asg_cloudwatch_metric" {
  alarm_name                = "asg-cloudwatch-metric"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors cpu utilization"
  alarm_actions = [ aws_sns_topic.cloudwatch_sns_topic.arn]

  dimensions = {
    AutoScalingGroupName = var.aws_autoscaling_group
  }
}
# ========================================================================================
# rds alarm
# ========================================================================================
resource "aws_cloudwatch_metric_alarm" "rds_cloudwatch_metric" {
  alarm_name                = "rds-cloudwatch-metric"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors cpu utilization for rds"
  alarm_actions = [ aws_sns_topic.cloudwatch_sns_topic.arn]

  dimensions = {
    DbInstanceIdentifier = var.rds_database
  }
}