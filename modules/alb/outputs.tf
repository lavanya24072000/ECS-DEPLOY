output "dns_name" { value = aws_lb.main.dns_name }
output "security_groups"{value=aws_security_group.alb_sg.id} 
