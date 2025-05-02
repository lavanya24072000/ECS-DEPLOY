provider "aws" {
  region = var.aws_region
}



module "vpc" {
  source = "./modules/vpc"
  env    = var.env
  vpc_cidr = var.vpc_cidr
  azs      = var.azs
}

module "ecs" {
  source         = "./modules/ecs"
  env            = var.env
  vpc_id         = module.vpc.vpc_id
  subnets_ids        = module.vpc.public_subnets
  cluster_name   = var.cluster_name
  security_group_id = module.alb.security_groups
  nginx_image        = var.nginx_image
  tomcat_image       = var.tomcat_image
  apache_image       = var.apache_image
}


module "alb" {
  source            = "./modules/alb"
  env               = var.env
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  alb_name          = var.alb_name
  target_groups     = module.ecs.target_groups
}
 
