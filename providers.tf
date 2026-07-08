terraform {
  required_version = ">= 1.5.0"

  cloud {
    organization = "mdelrio-duoc"

    workspaces {
      name = "EFT-AUY1104-Mdelrio"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
