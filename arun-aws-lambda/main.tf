terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  # Configuration options
  region                  = var.region
  profile                 = var.aws_profile
  # shared_credentials_file = var.shared_credentials_file
  default_tags {
    tags = var.tags
  }
}