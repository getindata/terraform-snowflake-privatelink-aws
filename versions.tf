terraform {
  required_version = ">= 1.3"
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = ">= 0.47"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.32"
    }
    context = {
      source  = "cloudposse/context"
      version = ">=0.4.0"
    }
  }
}
