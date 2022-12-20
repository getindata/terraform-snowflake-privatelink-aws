<!-- BEGIN_TF_DOCS -->
# Simple example of Snowflake PrivateLink AWS

This is a simple example of Snowflake PrivateLink AWS module usage

This example:

* Creates AWS VPC
* Creates AWS Subnet
* Creates `snowflake_privatelink_aws` module, which:
  * Creates AWS VPC Endpoint
  * Creates Security group and assigns it to the endpoint
  * AWS Route53 private zone and creates needed records inside



## Inputs

No inputs.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_snowflake_privatelink_aws"></a> [snowflake\_privatelink\_aws](#module\_snowflake\_privatelink\_aws) | ../../ | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_privatelink_details"></a> [privatelink\_details](#output\_privatelink\_details) | Details of Snowflake AWS PrivateLink |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
<!-- END_TF_DOCS -->