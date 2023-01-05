output "vpc_endpoint" {
  description = "Details created Snowflake AWS PrivateLink VPC Endpoint"
  value = {
    arn                = one(resource.aws_vpc_endpoint.this[*].arn)
    dns_entry          = one(resource.aws_vpc_endpoint.this[*].dns_entry)
    id                 = one(resource.aws_vpc_endpoint.this[*].id)
    security_group_ids = one(resource.aws_vpc_endpoint.this[*].security_group_ids)
    service_name       = one(resource.aws_vpc_endpoint.this[*].service_name)
    subnet_ids         = one(resource.aws_vpc_endpoint.this[*].subnet_ids)
    state              = one(resource.aws_vpc_endpoint.this[*].state)
    vpc_id             = one(resource.aws_vpc_endpoint.this[*].vpc_id)
    vpc_endpoint_type  = one(resource.aws_vpc_endpoint.this[*].vpc_endpoint_type)

  }
}

output "security_group" {
  description = "Details of security group assigned to Snowflake AWS PrivateLink VPC Endpoint"
  value = {
    arn     = one(resource.aws_security_group.this[*].arn)
    id      = one(resource.aws_security_group.this[*].id)
    egress  = one(resource.aws_security_group.this[*].egress)
    ingress = one(resource.aws_security_group.this[*].ingress)
  }
}

output "dns_private_zone" {
  description = "Details of Route53 private hosted zone created for Snowflake PrivateLink"
  value = {
    arn     = one(resource.aws_route53_zone.this[*].arn)
    zone_id = one(resource.aws_route53_zone.this[*].zone_id)
    name    = one(resource.aws_route53_zone.this[*].name)
  }
}

output "snowflake_privatelink_url" {
  description = "URL to access Snowflake using AWS PrivateLink"
  value = {
    fqdn = one(resource.aws_route53_record.snowflake_private_link_url[*].fqdn)
    url  = module.this.enabled ? "https://${one(resource.aws_route53_record.snowflake_private_link_url[*].fqdn)}" : null
  }
}

output "snowflake_privatelink_ocsp_url" {
  description = "URL to access Snowflake OCSP endpont using AWS PrivateLink"
  value = {
    fqdn = one(resource.aws_route53_record.snowflake_private_link_ocsp_url[*].fqdn)
  }
}
