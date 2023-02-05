terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.53.0"
    }
  }

}

provider "aws" {
  region     = var.region
  access_key = var.user_access_key
  secret_key = var.user_secret
}

resource "aws_iam_user" "admin" {
   name = "admin"
}

resource "aws_iam_access_key" "AccK" {
 user = aws_iam_user.admin.name
} 

resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "alb" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "terraform-test.${var.domain_name}"
  type    = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}








