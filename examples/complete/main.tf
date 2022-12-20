/*
* # Complete example of Snowflake PrivateLink AWS
* 
* This is a complete example of Snowflake PrivateLink AWS module usage
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
  cidr_block = "192.168.0.0/16"
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "192.168.0.0/24"
}

module "snowflake_privatelink_aws" {
  source  = "../../"
  context = module.this.context

  enabled         = module.this.enabled
  descriptor_name = "privatelink"
  descriptor_formats = {
    privatelink = {
      labels = ["name", "attributes"]
      format = "%v-%v"
    }
  }

  name       = "snowflake"
  attributes = ["privatelink"]

  vpc_id         = resource.aws_vpc.this.id
  subnet_ids     = [resource.aws_subnet.this.id]
  allowed_cidrs  = ["10.10.0.0/16"]
  allow_vpc_cidr = true
}
