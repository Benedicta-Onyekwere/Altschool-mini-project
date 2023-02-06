output "instance_public_ip" {
  description = "Public IP address of the Server A EC2 instance"
  value = [
    aws_instance.server[0].public_ip,
    aws_instance.server[1].public_ip,
    aws_instance.server[2].public_ip
  ]
}

output "alb_dns_name" {
description = "Alb DNS Name" 
value       = aws_lb.alb.dns_name
}

output "secret_key" {
  value = aws_iam_access_key.AccK.secret
  sensitive = true
}

output "access_key" {
  value = aws_iam_access_key.AccK.id
}
