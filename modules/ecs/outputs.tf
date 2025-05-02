output "target_groups" {
  value = {
    nginx  = aws_lb_target_group.nginx.arn
    tomcat = aws_lb_target_group.tomcat.arn
    apache = aws_lb_target_group.apache.arn
  }
}
output "cluster_name" { value = aws_ecs_cluster.main.name }
output "ecs_cluster_id" {
  value = aws_ecs_cluster.this.id
}
 
output "nginx_service_name" {
  value = aws_ecs_service.nginx.name
}
 
output "tomcat_service_name" {
  value = aws_ecs_service.tomcat.name
}
 
output "apache_service_name" {
  value = aws_ecs_service.apache.name
}
