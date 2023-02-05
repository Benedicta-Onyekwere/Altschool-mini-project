variable "region" {
  description = "Sets the aws region" 
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  type    = list(any)
  default = ["Server-0", "Server-1", "Server-2"]
}

variable "domain_name" {
  description = "Domain name"
  type        = string
  default     = "bennieo.io"
}

variable "user_access_key" {
  description = "Defines the user"
  type        = string
}

variable "user_secret" {
  description = "Defines the user"
  type        = string
}

# VPC Requirement

variable "custom_vpc" {
  description = "VPC for testing environment"
  type        = string
  default     = "10.0.0.0/16"
}


# EC2 Requirement

variable "instance_tenancy" {
  description = "it defines the tenancy of VPC. Whether it's default or dedicated"
  type        = string
  default     = "default"
}

variable "ami_id" {
  description = "ami id"
  type        = string
  default     = "ami-00874d747dde814fa"
}

variable "instance_type" {
  description = "Instance type to create an instance"
  type        = string
  default     = "t2.micro"
}

variable "ssh_private_key" {
  description = "pem file of Keypair used to login to EC2 instances"
  type        = string
  default     = "./Keypair.pem"
}

variable "inbound_ports" {
  type    = list(any)
  default = [80, 443]
}

variable "public_subnet_cidr_blocks" {
  type    = list(any)
  default = ["10.0.0.0/24", "10.0.2.0/24"]
}
