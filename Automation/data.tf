# AWS
provider "aws" {
  region = var.region
  profile = "xxxxx"
}

#data "aws_availability_zones" "available" {}