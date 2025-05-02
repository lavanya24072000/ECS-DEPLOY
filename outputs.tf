output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnets" { value = module.vpc.public_subnets }
output "ecs_cluster" { value = module.ecs.cluster_name }
output "alb_dns" { value = module.alb.dns_name }
