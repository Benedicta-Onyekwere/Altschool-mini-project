  #resource "aws_iam_role_policy" "ec2_policy" {
  #name = "ec2_policy"
  #role = aws_iam_role.terra_ec2_role.id
  
  #policy = "${file("ec2-policy.json")}"
    
 #resource "aws_iam_role" "terra_ec2__role" {
  #name = "terra_ec2_role"

  #assume_role_policy = "${file("ec2-assume-policy.json")}"

#resource "aws_iam_role_policy" "ec2_policy" {
  #name = "ec2_policy"
 # role = aws_iam_role.test_role.id

#resource "aws_iam_role_policy_attachment" "ec2_attach"{
 # role       = aws_iam_role.terra_ec2_role.name
  #policy_arn = aws_iam_policy.terra_ec2_policy.arn
  
#}

#resource "aws_iam_instance_profile" "ec2_profile" {
 # name  = "terra_ec2_profile"
 # role  = aws_iam_role.terra_ec2_role.name
 
#}



