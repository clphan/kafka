terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.14.9"
}


provider "aws" {
  profile = var.aws.profile
  region  = var.aws.region
}

# module "external_vpc" {
#   source       = "./infra/vpc"
#   region       = var.aws.region
#   subnet_cidr  = "172.31.0.0/28"
#   vpc_cidr     = "172.31.0.0/24"
#   name         = "external_vpc"
#   environment  = "test"
#   project_code = "kafka-stream"
# }


module "internal_vpc" {
  source       = "./infra/vpc"
  region       = var.aws.region
  subnet_cidr  = "172.32.0.0/28"
  vpc_cidr     = "172.32.0.0/24"
  name         = "internal_vpc"
  environment  = "test"
  project_code = "kafka-stream"
}