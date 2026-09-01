terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }
  }
  backend "s3" {
    bucket = "cloudk-remote-state"
    key    = "expense-dev-aws-eks"
    region = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}
# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "21.25.0"
# }