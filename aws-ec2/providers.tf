// Configure the AWS Provider and Region
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
}
