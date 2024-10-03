#module "vpc" {
#  source = "git::https://github.com/gnavien/tf-module-vpc.git"
#
#  for_each   = var.vpc
#  cidr_block = each.value["cidr_block"]
#  subnets    = each.value["subnets"]
#  env            = var.env
#  tags           = var.tags
#
#}


module "vpc" {
  source = "git::https://github.com/gnavien/tf-module-vpc.git"
  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]

}