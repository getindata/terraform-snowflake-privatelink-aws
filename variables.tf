variable "vpc_id" {
  description = "VPC ID where the AWS PrivateLink VPC Endpoint will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of AWS Subnet IDs where Snowflake AWS PrivateLink Endpoint interfaces will be created"
  type        = list(string)
}

variable "allow_vpc_cidr" {
  description = "Whether allow access to the Snowflake PrivateLink endpoint from the whole VPC"
  type        = bool
  default     = true
}

variable "allowed_cidrs" {
  description = "List of subnet CIDRs that will be allowed to access Snowflake endpoint via PrivateLink"
  type        = list(string)
  default     = []
}

variable "descriptor_name" {
  description = "Name of the descriptor used to form a resource name"
  type        = string
  default     = "snowflake-privatelink"
}

variable "additional_dns_records" {
  description = "List of additional Route53 records to be added to local `privatelink.snowflakecomputing.com` hosted zone that points to Snowflake VPC endpoint."
  type        = list(string)
  default     = []
  validation {
    condition     = alltrue([for r in var.additional_dns_records : endswith(r, ".privatelink.snowflakecomputing.com")])
    error_message = "Each DNS record should be a subdomain of '.privatelink.snowflakecomputing.com'."
  }
}

variable "organisation_name" {
  description = "Name of the organisation, where the Snowflake account is created, used to create regionless privatelink fqdns"
  type        = string
  default     = null
}

variable "account_name" {
  description = "Name of the Snowflake account, used to create regionless privatelink fqdns"
  type        = string
  default     = null
}
