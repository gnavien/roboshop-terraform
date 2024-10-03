
module "vpc" {
  source = "git::https://github.com/gnavien/tf-module-vpc.git"

  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets    = each.value["subnets"]
  vpc_id = var.vpc_id

  env            = var.env
  tags           = var.tags


}
