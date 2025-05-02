resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
  tags = { Environment = var.env }
}

# Security Group for ECS services
resource "aws_security_group" "ecs_sg" {
  name   = "${var.env}-ecs-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "${var.env}-ecs-sg" }
}

# Target Groups
resource "aws_lb_target_group" "nginx" {
  name     = "${var.env}-nginx-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "tomcat" {
  name     = "${var.env}-tomcat-tg"
  port     = 8090
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "apache" {
  name     = "${var.env}-apache-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
