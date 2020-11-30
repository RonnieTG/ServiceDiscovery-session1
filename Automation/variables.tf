# Region 
variable "region" {
  description = "AWS region for VMs"
  default = "us-east-1"
}


# AWS Key pair
variable "key_name" {
  description = "name of ssh key to attach to hosts"
  default = "xxxxx"
}


# AMI
variable "ami" {
  description = "Chosen AMI ubuntu 18"
  default = {
    "us-east-1" = "ami-00ddb0e5626798373"
  }
}


# Amounts of needed instances by type
variable "server_ec2_number" {
description = "Number of ec2 servers needed"
  default = 3
  type = string  
}

variable "agent_ec2_number" {
  description = "Number of ec2 agents needed"
  default = 1
  type = string
  }


# Environment description for all components
variable "environment_tag" {
    default = "ServiceDiscovery"
}


# VPC
variable "vpc_cidr" {
  default = "10.10.0.0/16"
}


# Subnet
variable "public_subnet" {
    #type = list(string)
    default = "10.10.0.0/24"
}