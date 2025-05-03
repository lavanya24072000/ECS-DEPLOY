resource "aws_ecs_cluster" "this" {
  name = "${var.env}-ecs-cluster"
}
 
resource "aws_lb_target_group" "nginx" {
  name     = "${var.env}-nginx-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"
  health_check {
    path = "/"
  }
}
 
resource "aws_lb_target_group" "tomcat" {
  name     = "${var.env}-tomcat-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"
  health_check {
    path = "/"
  }
}
 
resource "aws_lb_target_group" "apache" {
  name     = "${var.env}-apache-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"
  health_check {
    path = "/"
  }
}
 
resource "aws_ecs_task_definition" "nginx" {
  family                   = "${var.env}-nginx-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
 
  container_definitions = jsonencode([{
    name      = "nginx"
    image     = var.nginx_image
    portMappings = [{
      containerPort =  80
      hostPort      = 80
    }]
  }])
}
 
resource "aws_ecs_task_definition" "tomcat" {
  family                   = "${var.env}-tomcat-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
 
  container_definitions = jsonencode([{
    name      = "tomcat"
    image     = var.tomcat_image
    portMappings = [{
      containerPort = 8090
      hostPort      = 8090
    }]
  }])
}
 
resource "aws_ecs_task_definition" "apache" {
  family                   = "${var.env}-apache-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
 
  container_definitions = jsonencode([{
    name      = "apache"
    image     = var.apache_image
    portMappings = [{
      containerPort = 5678
      hostPort      = 5678
    }]
  }])
}
 
resource "aws_ecs_service" "nginx" {
  name            = "${var.env}-nginx-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 1
  launch_type     = "FARGATE"
 
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }
 
  load_balancer {
    target_group_arn = aws_lb_target_group.nginx.arn
    container_name   = "nginx"
    container_port   = 8080
  }
 
  depends_on = [aws_lb_target_group.nginx]
}
 
resource "aws_ecs_service" "tomcat" {
  name            = "${var.env}-tomcat-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.tomcat.arn
  desired_count   = 1
  launch_type     = "FARGATE"
 
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }
 
  load_balancer {
    target_group_arn = aws_lb_target_group.tomcat.arn
    container_name   = "tomcat"
    container_port   = 8090
  }
 
  depends_on = [aws_lb_target_group.tomcat]
}
 
resource "aws_ecs_service" "apache" {
  name            = "${var.env}-apache-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.apache.arn
  desired_count   = 1
  launch_type     = "FARGATE"
 
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }
 
  load_balancer {
    target_group_arn = aws_lb_target_group.apache.arn
    container_name   = "apache"
    container_port   = 80
  }
 
  depends_on = [aws_lb_target_group.apache]
}
 
