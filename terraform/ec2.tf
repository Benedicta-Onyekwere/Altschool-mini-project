# Creating 3 EC2 Instances

resource "aws_instance" "server" {
  count                = 3
  ami                  = var.ami_id
  instance_type        = var.instance_type
  vpc_security_group_ids = [aws_security_group.terra_security_group.id]
  subnet_id              = aws_subnet.terra-public-subnet-1.id
  key_name             = "Keypair"
  #iam_instance_profile = "${aws_iam_role.terra_ec2_.name}"

  tags = {
    "Name"        = "${element(var.instance_name, count.index)}"
    "Environment" = "Test"
    "CreatedBy"   = "Terraform"
  }
    
}

# Exporting the IP Addresses from the EC2 Instances to a file name 'host-inventory'

resource "local_file" "Ip_address" {
  filename = "/home/vagrant/terraform"
  content  = <<EOT
${aws_instance.server[0].public_ip}
${aws_instance.server[1].public_ip}
${aws_instance.server[2].public_ip}
  EOT
}



