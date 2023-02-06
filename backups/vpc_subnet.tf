#Creating Virtual Private Cloud:

resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.custom_vpc
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true
  tags = {
    Name = "custom_vpc"
}
}


# Create Internet Gateway
resource "aws_internet_gateway" "terra-igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "terra-igw"
  }
}


# Create Public Subnet 1
resource "aws_subnet" "terra-public-subnet-1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[0]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  tags = {
    Name = "terra-public-subnet-1"
  }
}

# Create Public Subnet 2
resource "aws_subnet" "terra-public-subnet-2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[1]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  tags = {
    Name = "terra-public-subnet-2"
  }
}

# Create Route Table and Add to Public Route
resource "aws_route_table" "terra-public" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra-igw.id
  }

  tags = {
    Name = "terra-public"
  }
}

# Associate Public Subnet 1 to Public Route Table
resource "aws_route_table_association" "terra-public-subnet-1" {
  subnet_id      = aws_subnet.terra-public-subnet-1.id
  route_table_id = aws_route_table.terra-public.id
}

# Associate Public Subnet 2 to Public Route Table
resource "aws_route_table_association" "terra-public-subnet-2" {
  subnet_id      = aws_subnet.terra-public-subnet-2.id
  route_table_id = aws_route_table.terra-public.id
}

# Associate Public Subnet ID to Network ACL
resource "aws_network_acl" "terra-network_acl" {
  vpc_id     = aws_vpc.custom_vpc.id
  subnet_ids = [aws_subnet.terra-public-subnet-1.id, aws_subnet.terra-public-subnet-2.id]

  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}





# Creating VPC FlowLogs:

resource "aws_flow_log" "vpc_flow_log" {
  #iam_role_arn         =  aws_iam_role.terra_ec2_role.arn
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.cloudwatch_log_group.arn
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.custom_vpc.id
}



# Creating CloudWatch Log Group:

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = "VPC-FlowLogs-Group"
  retention_in_days = 30
}
