output "target_groups" {
  value = {
    nginx  = aws_lb_target_group.nginx.arn
    tomcat = aws_lb_target_group.tomcat.arn
    apache = aws_lb_target_group.apache.arn
  }
}
output "cluster_name" { value = aws_ecs_cluster.main.name }
