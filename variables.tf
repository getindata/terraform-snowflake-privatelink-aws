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
