#module "test" {
#  source = "git::https://github.com/gnavien/tf-module-app.git"
#  env = var.env
#}

module "instances" {
  source = "git::https://github.com/gnavien/tf-module-app.git"
  for_each = var.components
  component = each.key
  env = var.env
}