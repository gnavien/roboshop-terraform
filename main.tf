#module "test" {
#  source = "git::https://github.com/gnavien/tf-module-app.git"
#  env = var.env
#}
#
#module "instances" {
#  for_each = var.components
#  source = "git::https://github.com/gnavien/tf-module-app.git"
#  component = each.key
#  env = var.env
#}

#module "vpc" {
#  source     = "git::https://github.com/gnavien/tf-module-vpc.git"
#  for_each   = var.vpc
#  cidr_block = each.value["cidr_block"]
#  subnets    = each.value["subnets"] # this value we will get from main.tfvars
#
#  env = var.env
#  tags = var.tags
#  default_vpc_id = var.default_vpc_id
#
#
#}
#
#
#module "app_server" {
#  source = "git::https://github.com/gnavien/tf-module-app.git"
#  component = "test"
#  env = var.env
#  tags = var.tags
#  subnet_id = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "app", null), "subnet_ids", null)[0]
#  vpc_id = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
#}



module "vpc" {
  source     = "git::https://github.com/gnavien/tf-module-vpc.git"
  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]
  env = var.env
  tags = var.tags
}
