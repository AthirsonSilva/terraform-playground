terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region                   = "sa-east-1" # Update with your desired AWS region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}
