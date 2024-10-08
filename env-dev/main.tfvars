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

#Below is the one we need to check and gather information based on your logging and in this some might keep changing if we dont use a static setup

default_vpc_id        = "vpc-061763d37266eaca6"
default_rt_table      = "rtb-0e8c654f78dccaa62"
allow_ssh_cidr        = ["172.31.40.167/32"] # This is a private IP address
zone_id               = "Z1034774YEMERCD71C9Q" # This zone ID is from route 53
kms_key_id = "8c334a91-45b5-4dde-b43d-6426eb7434b9" # Once key management service is available (KMS)
kms_key_arn = "arn:aws:kms:us-east-1:339713020180:key/8c334a91-45b5-4dde-b43d-6426eb7434b9" # Once KMS is created we can get this information


rabbitmq = {
  main = {
    instance_type = "t3.small"
    component     = "rabbitmq"
  }
}

rds = {
  main = {
    component      = "rds"
    engine         = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.11.3"
    db_name        = "dummy"
    instance_count = 1
    instance_class = "db.t3.small"
  }
}

documentdb = {
  main = {
    component      = "docdb"
    engine         = "docdb"
    engine_version = "4.0.0"
    db_instance_count = 1
    instance_class = "db.t3.medium"
  }
}

elasticache = {
  main = {
    component               = "elasticache"
    engine                  = "redis" # check using configure and create cluster in elastic cache
    engine_version          = "6.x" # check using configure and create cluster in elasticache
    num_node_groups         = 1
    replicas_per_node_group = 1
    node_type               = "cache.t3.micro"
    parameter_group_name    = "default.redis6.x.cluster.on"
  }
}

alb = {
  public = {
    name               = "public"
    internal           =  false
    load_balancer_type = "application"
    subnet_ref = "public" #

  }
  private = {
    name               = "private"
    internal           = true
    load_balancer_type = "application"
    subnet_ref = "app"  #

  }
}

apps = {
  main = {
    name      = "main"
    component = "app"
  }
}

