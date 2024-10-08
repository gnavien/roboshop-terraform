module "vpc" {
  source = "git::https://github.com/gnavien/tf-module-vpc.git"

  for_each         = var.vpc
  cidr_block       = each.value["cidr_block"]
  subnets          = each.value["subnets"]
  env              = var.env
  tags             = var.tags
  default_vpc_id   = var.default_vpc_id
  default_rt_table = var.default_rt_table
}

module "app_server" {
  source    = "git::https://github.com/gnavien/tf-module-app.git"
  env       = var.env
  tags      = var.tags
  component = "test"
  subnet_id = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null ), "app", null), "subnet_ids", null)[0]
  vpc_id    = lookup(lookup(module.vpc, "main", null), "vpc_id", null)

}

module "rabbitmq" {
  source = "git::https://github.com/gnavien/tf-module-rabbitmq.git"
  # Below are the input variables

  for_each      = var.rabbitmq
  component     = each.value["component"]
  instance_type = each.value["instance_type"]

  # Below info we are getting from other modules and variables references
  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null ), "app", null), "cidr_block", null)
  # this will search and fetch data from main.tfvars like this vpc-->main-->subnets-->app-->cidr_block
  vpc_id         = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  subnet_id      = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null ), "db", null), "subnet_ids", null)[0]

  # Below are the plain variables which does not belong to iterations

  env            = var.env
  tags           = var.tags
  allow_ssh_cidr = var.allow_ssh_cidr
  zone_id        = var.zone_id
  kms_key_arn    = var.kms_key_arn

}


module "rds" {
  source = "git::https://github.com/gnavien/tf-module-rds.git"

  for_each       = var.rds
  component      = each.value["component"]
  engine         = each.value["engine"]
  engine_version = each.value["engine_version"]
  db_name        = each.value["db_name"]
  subnet_ids     = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "db", null), "subnet_ids", null)
  instance_count = each.value["instance_count"]
  instance_class = each.value["instance_class"]
  vpc_id         = lookup(lookup(module.vpc, "main", null), "vpc_id", null)

  tags           = var.tags
  env            = var.env
  kms_key_arn    = var.kms_key_arn  # kms key ARN (amazon resource name)
  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), "app", null), "cidr_block", null)

}

module "documentdb" {
  source = "git::https://github.com/gnavien/tf-module-documentdb.git"

  for_each       = var.documentdb
  component      = each.value["component"]
  subnet_ids     = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "db", null), "subnet_ids", null)



  tags           = var.tags
  env            = var.env
  kms_key_arn    = var.kms_key_arn  # kms key ARN (amazon resource name)
  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), "app", null), "cidr_block", null)

}

#
#module "elasticache" {
#  source = "git::https://github.com/gnavien/tf-module-elasticache.git"
#
#  for_each       = var.elasticache
#
#
#  tags           = var.tags
#  env            = var.env
#  kms_key_arn    = var.kms_key_arn  # kms key ARN (amazon resource name)
#  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), "app", null), "cidr_block", null)
#
#}
