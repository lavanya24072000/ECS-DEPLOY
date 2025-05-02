variable "env" { type = string }
variable "vpc_id" { type = string }
variable "subnets" { type = list(string) }
variable "cluster_name" { type = string }

 
variable "security_group_id" {
  description = "Security group ID"
  type        = string
}
 
variable "nginx_image" {
  description = "Nginx Docker image"
  type        = string
}
 
variable "tomcat_image" {
  description = "Tomcat Docker image"
  type        = string
}
 
variable "apache_image" {
  description = "Apache Docker image"
  type        = string
}
 

 
