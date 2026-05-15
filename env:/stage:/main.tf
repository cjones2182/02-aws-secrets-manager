# =======================================================================================
# vpc 
# =======================================================================================

module "vpc" {
  source             = "../../modules:/vpc:"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  database_subnets   = var.database_subnets
  igw                = var.igw
  environment        = var.environment
}
module "security-groups" {
  source                  = "../../modules:/security-groups:"
  vpc_id                  = module.vpc.vpc_id
  alb_security_group      = var.alb_security_group
  web_security_group      = var.web_security_group
  database_security_group = var.database_security_group
  environment             = var.environment
}
module "alb" {
  source             = "../../modules:/alb"
  alb_security_group = [module.security-groups.alb_security_group]
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnets
  environment        = var.environment
}
module "autoscaling-group" {
  source                = "../../modules:/autoscaling-groups:"
  web_security_group    = [module.security-groups.web_security_group]
  instance_type         = var.instance_type
  image_id              = var.image_id
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  availability_zones    = var.availability_zones
  public_subnets        = var.public_subnets
  private_subnets       = module.vpc.private_subnets
  main_alb_target_group = [module.alb.main_alb_target_group]
  environment           = var.environment
  ec2_instance_profile  = module.secrets-manager.ec2_instance_profile

}
module "rds" {
  source             = "../../modules:/rds:"
  allocated_storage  = var.allocated_storage
  database_subnets   = module.vpc.database_subnets
  db_name            = var.db_name
  engine_version     = var.engine_version
  engine             = var.engine
  instance_class     = var.instance_class
  web_security_group = module.security-groups.web_security_group
  rds_username       = var.rds_username
  rds_password       = module.secrets-manager.rds_password
}
module "cloudwatch" {
  source                = "../../modules:/cloudwatch:"
  load_balancer_arn     = module.alb.load_balancer_arn
  aws_autoscaling_group = module.autoscaling-group.main_autoscaling_group
  rds_database          = module.rds.rds_database
}
module "secrets-manager" {
  source       = "../../modules:/secrets-manager:"
  environment  = var.environment
  rds_username = var.rds_username
}