/*
* # Simple example of Snowflake PrivateLink AWS
* 
* This is a simple example of Snowflake PrivateLink AWS module usage
*
* This example:
*
* * Creates AWS VPC
* * Creates AWS Subnet
* * Creates `snowflake_privatelink_aws` module, which:
*   * Creates AWS VPC Endpoint
*   * Creates Security group and assigns it to the endpoint
*   * AWS Route53 private zone and creates needed records inside
*/

resource "aws_vpc" "this" {
  #checkov:skip=CKV2_AWS_11:Only a simple example, so additional security configuration should be added for production usage
  #checkov:skip=CKV2_AWS_12:Only a simple example, so additional security configuration should be added for production usage

  cidr_block = "192.168.0.0/16"
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "192.168.0.0/24"
}

module "snowflake_privatelink_aws" {
  source = "../../"

  #checkov:skip=CKV2_AWS_38:This is private hosted zone, so this check seems like a false-positive
  #checkov:skip=CKV2_AWS_39:Query logging configuration should be handled outside of the basic module

  name       = "snowflake"
  attributes = ["privatelink"]

  vpc_id     = resource.aws_vpc.this.id
  subnet_ids = [resource.aws_subnet.this.id]

  tags = {
    "example" = "tag"
  }
}
