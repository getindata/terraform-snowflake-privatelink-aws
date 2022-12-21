locals {
  vpc_cidr_enabled = module.this.enabled && var.allow_vpc_cidr ? 1 : 0

  name_from_descriptor = module.this.enabled ? trim(replace(
    lookup(module.this.descriptors, var.descriptor_name, module.this.id), "/${module.this.delimiter}${module.this.delimiter}+/", module.this.delimiter
  ), module.this.delimiter) : null

  allowed_cidrs = concat(
    var.allow_vpc_cidr ? [one(data.aws_vpc.this).cidr_block] : [],
    var.allowed_cidrs
  )
}
