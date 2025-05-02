
variable "env" { type = string }
variable "aws_region" { type = string }
variable "vpc_cidr" { type = string }
variable "azs" { type = list(string) }
variable "cluster_name" { type = string }
variable "alb_name" { type = string }
variable "nginx_image" {
  default = "nginx:latest"
}
 
variable "tomcat_image" {
  default = "tomcat:latest"
}
 
variable "apache_image" {
  default = "httpd:latest"
}
 
