# common config
locals {
  account_id = data.aws_caller_identity.current.account_id
}

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.7"
    }
    awsutils = {
      source  = "cloudposse/awsutils"
      version = ">= 0.11.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "awsutils" {
  region = var.region
}

data "aws_caller_identity" "current" {}

variable "region" {
  type        = string
  default     = ""
  description = "If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee"
}