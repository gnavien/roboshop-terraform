module "test" {
  source = "git::https://github.com/gnavien/tf-module-app.git"
  env = var.env
}