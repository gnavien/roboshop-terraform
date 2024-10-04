env = "dev"

tags = {
  company_name  = "XYZ Tech"
  business      = "ecommerce"
  business_unit = "retail"
  cost_center   = "322"
  project_name  = "roboshop"
}

vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets = {
      web    = { cidr_block = ["10.0.0.0/24", "10.0.1.0/24"] }
      app    = { cidr_block = ["10.0.2.0/24", "10.0.3.0/24"] }
      db     = { cidr_block = ["10.0.4.0/24", "10.0.5.0/24"] }
      public = { cidr_block = ["10.0.6.0/24", "10.0.7.0/24"] }
    }
  }
}

rabbitmq = {
  main ={
    instance_type = "t3.small"
    component = "rabbitmq"
  }

}

#vpc = {
#  main = {
#    cidr_block = "10.0.0.0/16"
#  }
#}

default_vpc_id     = "vpc-038ac78786571a365"
default_rt_table   = "rtb-06eaf21a58a2b11b8"
