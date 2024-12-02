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

default_vpc_id        = "vpc-01279ffdeb1280247"
default_rt_table      = "rtb-07573378a435bd508"
allow_ssh_cidr        = ["172.31.41.69/32"] # This is a private IP address
#allow_prometheus_cidr = ["172.31.41.70/32"]
zone_id               = "Z00818251RNVL2ER8SNTY" # This zone ID is from route 53
kms_key_id = "7e148e08-def8-41a5-9b80-2941c17365b2" # Once key management service is available (KMS)
kms_key_arn = "arn:aws:kms:us-east-1:438465144813:key/7e148e08-def8-41a5-9b80-2941c17365b2" # Once KMS is created we can get this information


#default_vpc_id        = "vpc-0f46a9110cb8adf54"
#default_rt_table      = "rtb-0af4e95df651397b0"
#allow_ssh_cidr        = ["172.31.38.122/32"] # This is a private IP address
#zone_id               = "Z07658633JTNQOAIFWUFH" # This zone ID is from route 53
#kms_key_id = "cb39c8a1-86a4-4d5c-8daf-f85da8e27ee4" # Once key management service is available (KMS)
#kms_key_arn = "arn:aws:kms:us-east-1:851725482328:key/cb39c8a1-86a4-4d5c-8daf-f85da8e27ee4" # Once KMS is created we can get this information


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
    instance_count = 1
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
  cart = {
    component        = "cart"
    app_port         = 8080
    instance_type    = "t3.micro"
    desired_capacity = 1
    max_size         = 1
    min_size         = 1
    subnet_ref       = "app"
    lb_ref           = "private"
    lb_rule_priority = 100

  }
  catalogue = {
    component          = "catalogue"
    app_port           = 8080
    instance_type      = "t3.small"
    desired_capacity   = 1
    max_size           = 1
    min_size           = 1
    subnet_ref         = "app"
    lb_ref             = "private"
    lb_rule_priority   = 101
    extra_param_access = ["arn:aws:ssm:us-east-1:968585591903:parameter/roboshop.dev.docdb.*"]
    # extra_param_access is given specific to each component for access to docdb
  }
  user = {
    component          = "user"
    app_port           = 8080
    instance_type      = "t3.small"
    desired_capacity   = 1
    max_size           = 1
    min_size           = 1
    subnet_ref         = "app"
    lb_ref             = "private"
    lb_rule_priority   = 102
    extra_param_access = ["arn:aws:ssm:us-east-1:968585591903:parameter/roboshop.dev.docdb.*"]

  }
  shipping = {
    component          = "shipping"
    app_port           = 8080
    instance_type      = "t3.small"
    desired_capacity   = 1
    max_size           = 1
    min_size           = 1
    subnet_ref         = "app"
    lb_ref             = "private"
    lb_rule_priority   = 103
    extra_param_access = ["arn:aws:ssm:us-east-1:968585591903:parameter/roboshop.dev.mysql.*"]

  }
  payment = {
    component        = "payment"
    app_port         = 8080
    instance_type    = "t3.small"
    desired_capacity = 1
    max_size         = 1
    min_size         = 1
    subnet_ref       = "app"
    lb_ref           = "private"
    lb_rule_priority = 104
  }
  frontend = {
    component        = "frontend"
    app_port         = 80
    instance_type    = "t3.small"
    desired_capacity = 1
    max_size         = 1
    min_size         = 1
    subnet_ref       = "web"
    lb_ref           = "public"
    lb_rule_priority = 100
  }
}

