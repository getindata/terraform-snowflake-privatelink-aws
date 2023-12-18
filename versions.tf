terraform {
  required_version = ">= 1.3"
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.80.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
