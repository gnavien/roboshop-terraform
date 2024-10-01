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

module "vpc" {
  source = "git::https://github.com/gnavien/tf-module-vpc.git"
  for_each = var.vpc
  cidr_block = each.value["cidr_block"]


}