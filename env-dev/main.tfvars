env = "dev"

#components = {
#  frontend = {}
#  mongodb = {}
#  catalogue = {}
#  redis = {}
#  user = {}
#  cart = {}
#  mysql = {}
#  shipping = {}
#  payment = {}
#  rabbitmq = {}
#
#}

#env = "dev"
#
#components = {
#  frontend  = {}
#  mongodb   = {}
#  catalogue = {}
#}

tags = {
  company_name  = "XYZ Tech"
  business      = "ecommerce"
  business_unit = "retail"
  cost_center   = "322"
  project_name  = "roboshop"
}

#vpc = {
#  main = {
#    cidr_block = "10.0.0.0/16"
#    subnets = {
#      web    = { cidr_block = ["10.0.0.0/24", "10.0.1.0/24"] }
#      app    = { cidr_block = ["10.0.2.0/24", "10.0.3.0/24"] }
#      db     = { cidr_block = ["10.0.4.0/24", "10.0.5.0/24"] }
#      public = { cidr_block = ["10.0.6.0/24", "10.0.7.0/24"] }
#    }
#  }
#}

#default_vpc_id = "vpc-01279ffdeb1280247"

vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
  }
}