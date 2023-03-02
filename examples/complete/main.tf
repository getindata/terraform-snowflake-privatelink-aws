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
  #checkov:skip=CKV2_AWS_11:Not in the scope of this example

  cidr_block = "192.168.0.0/16"
}

resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "192.168.0.0/24"
}

module "snowflake_privatelink_aws" {
  source = "../../"

  #checkov:skip=CKV2_AWS_38:This is private hosted zone, so this check seems like a false-positive
  #checkov:skip=CKV2_AWS_39:Query logging configuration should be handled outside of the basic module - example below

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

  organisation_name = "snoworg"
  account_name      = "snowflake_tst"
  additional_dns_records = [
    "additional.dns.privatelink.snowflakecomputing.com"
  ]
}

# Example CloudWatch log group for Route53 zone
resource "aws_cloudwatch_log_group" "this" {
  #checkov:skip=CKV_AWS_158:Not in the scope of this example

  name              = "/aws/route53/${module.snowflake_privatelink_aws.dns_private_zone.name}"
  retention_in_days = 30
}

# Example CloudWatch log resource policy to allow Route53 to write logs
# to any log group under /aws/route53/*
data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:log-group:/aws/route53/*"]

    principals {
      identifiers = ["route53.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "this" {
  policy_document = data.aws_iam_policy_document.this.json
  policy_name     = "route53-query-logging-policy"
}

# Example Route53 zone with query logging
resource "aws_route53_query_log" "this" {
  depends_on = [aws_cloudwatch_log_resource_policy.this]

  cloudwatch_log_group_arn = aws_cloudwatch_log_group.this.arn
  zone_id                  = module.snowflake_privatelink_aws.dns_private_zone.zone_id
}
