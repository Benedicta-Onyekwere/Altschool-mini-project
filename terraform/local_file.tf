# To store the IP addresses of the instances

resource "local_file" "Ip_address" {
  filename = "/home/ec2-user/Altschool-mini-project/ansible/inventory"
  content  = <<EOT
${aws_instance.server1.public_ip}
${aws_instance.server2.public_ip}
${aws_instance.server3.public_ip}
  EOT
}
