terraform {
  required_version = ">= 1.3"
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.47"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.22"
    }
  }
}
