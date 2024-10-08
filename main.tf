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


#module "rabbitmq" {
#  source = "git::https://github.com/gnavien/tf-module-rabbitmq.git"
#  # Below are the input variables
#
#  for_each      = var.rabbitmq
#  component     = each.value["component"]
#  instance_type = each.value["instance_type"]
#
#  # Below info we are getting from other modules and variables references
#  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null ), "app", null), "cidr_block", null)
#  # this will search and fetch data from main.tfvars like this vpc-->main-->subnets-->app-->cidr_block
#  vpc_id         = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
#  subnet_id      = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null ), "db", null), "subnet_ids", null)[0]
#
#  # Below are the plain variables which does not belong to iterations
#
#  env            = var.env
#  tags           = var.tags
#  allow_ssh_cidr = var.allow_ssh_cidr
#  zone_id        = var.zone_id
#  kms_key_arn    = var.kms_key_arn
#
#}
#
#
#module "rds" {
#  source = "git::https://github.com/gnavien/tf-module-rds.git"
#
#  for_each       = var.rds
#  component      = each.value["component"]
#  engine         = each.value["engine"]
#  engine_version = each.value["engine_version"]
#  db_name        = each.value["db_name"]
#  subnet_ids     = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "db", null), "subnet_ids", null)
#  instance_count = each.value["instance_count"]
#  instance_class = each.value["instance_class"]
#  vpc_id         = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
#
#  tags           = var.tags
#  env            = var.env
#  kms_key_arn    = var.kms_key_arn  # kms key ARN (amazon resource name)
#  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), "app", null), "cidr_block", null)
#
#}
#
## For Documentdb we are using instance based cluster, we are not creating using elastic cluster
#module "documentdb" {
#  source = "git::https://github.com/gnavien/tf-module-documentdb.git"
#
#  for_each       = var.documentdb
#  component      = each.value["component"]
#
#
#  subnet_ids     = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "db", null), "subnet_ids", null)
#  vpc_id         = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
#  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), "app", null), "cidr_block", null)
#
#
#  db_instance_count = each.value["db_instance_count"]
#  instance_class = each.value["instance_class"]
#  engine = each.value["engine"]
#  engine_version = each.value["engine_version"]
#
#  tags           = var.tags
#  env            = var.env
#  kms_key_arn    = var.kms_key_arn  # kms key ARN (amazon resource name)
#
#
#}
#
#
#module "elasticache" {
#  source = "git::https://github.com/gnavien/tf-module-elasticache.git"
#
#  for_each       = var.elasticache
#  component      = each.value["component"]
#  engine         = each.value["engine"]
#  engine_version = each.value["engine_version"]
#  node_type = each.value["node_type"]
#
#  replicas_per_node_group = each.value["replicas_per_node_group"]
#  num_node_groups = each.value["num_node_groups"]
#  parameter_group_name = each.value["parameter_group_name"]
#
#
#  vpc_id         = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
#  sg_subnet_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), "app", null), "cidr_block", null)
#  subnet_ids     = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "db", null), "subnet_ids", null)
#
#
#  tags           = var.tags
#  env            = var.env
#  kms_key_arn    = var.kms_key_arn  # kms key ARN (amazon resource name)
#
#}

module "alb" {
  source             = "git::https://github.com/gnavien/tf-module-alb.git"
  # Below are the input variables
  for_each           = var.alb
  name               = each.value["name"]
  internal           = each.value["internal"]
  load_balancer_type = each.value["load_balancer_type"]

  vpc_id             = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_subnet_cidr     = each.value["name"]  == "public" ? ["0.0.0.0/0"  ] : local.app_web_subnet_cidr       # Here we are giving 2 subnets app and web to access each other as the request will be coming from both the directiuons

  subnets        = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), each.value ["subnet_ref"], null), "subnet_ids", null)
  env  = var.env
  tags = var.tags

}

module "app_server" {
  source    = "git::https://github.com/gnavien/tf-module-app.git"

  component = "test"
  subnet_id = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null ), "app", null), "subnet_ids", null)[0]
  vpc_id    = lookup(lookup(module.vpc, "main", null), "vpc_id", null)

  env       = var.env
  tags      = var.tags



#  variable "component" {}
#  variable "subnet_id" {}
#  variable "vpc_id" {}
#  variable "tags" {
#    default = {}
#  }
#
#  variable "app_port" {}
#  variable "sg_subnet_cidr" {}
#  variable "instance_type" {}
#
#
#  variable "desired_capacity" {}
#  variable "max_size" {}
#  variable "min_size" {}
}




