data "snowflake_system_get_privatelink_config" "this" {
  count = module.this.enabled ? 1 : 0
}

data "aws_vpc" "this" {
  count = local.vpc_cidr_enabled

  id = var.vpc_id
}

resource "aws_security_group" "this" {
  count = module.this.enabled ? 1 : 0

  vpc_id      = var.vpc_id
  description = "Security group for Snowflake AWS PrivateLink VPC Endpoint"

  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = local.allowed_cidrs
    protocol    = "tcp"
    description = "Allow HTTP ingress traffic"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    cidr_blocks = local.allowed_cidrs
    protocol    = "tcp"
    description = "Allow HTTPS ingress traffic"
  }

  tags = module.this.tags
}

resource "aws_vpc_endpoint" "this" {
  count = module.this.enabled ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = one(data.snowflake_system_get_privatelink_config.this[*].aws_vpce_id)
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [one(aws_security_group.this[*].id)]
  subnet_ids          = var.subnet_ids
  private_dns_enabled = false

  tags = merge(module.this.tags,
    {
      Name = local.name_from_descriptor
    }
  )
}

resource "aws_route53_zone" "this" {
  count = module.this.enabled ? 1 : 0

  name    = "privatelink.snowflakecomputing.com"
  comment = "Snowflake AWS PrivateLink records"

  vpc {
    vpc_id = var.vpc_id
  }

  tags = module.this.tags
}

resource "aws_route53_record" "snowflake_private_link_url" {
  count = module.this.enabled ? 1 : 0

  zone_id = one(aws_route53_zone.this[*].zone_id)
  name    = one(data.snowflake_system_get_privatelink_config.this[*].account_url)
  type    = "CNAME"
  ttl     = "300"
  records = [one(aws_vpc_endpoint.this).dns_entry[0]["dns_name"]]
}

resource "aws_route53_record" "snowflake_private_link_ocsp_url" {
  count = module.this.enabled ? 1 : 0

  zone_id = one(aws_route53_zone.this[*].zone_id)
  name    = one(data.snowflake_system_get_privatelink_config.this[*].ocsp_url)
  type    = "CNAME"
  ttl     = "300"
  records = [one(aws_vpc_endpoint.this).dns_entry[0]["dns_name"]]
}
