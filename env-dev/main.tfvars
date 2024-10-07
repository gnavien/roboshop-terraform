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
  main = {
    instance_type = "t3.small"
    component     = "rabbitmq"

  }

}

#Below is the one we need to check and gather information based on your logging and in this some might keep changing if we dont use a static setup

default_vpc_id        = "vpc-011e6644812470204"
default_rt_table      = "rtb-0f907e1f29b775e22"
allow_ssh_cidr        = ["172.31.43.67/32"]
