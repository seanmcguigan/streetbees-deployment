data "terraform_remote_state" "eksvpc-development" {
  backend = "s3"
  config = {
    bucket = "streetbees-terraformstate-development"
    region = "us-east-1"
    key    = "eksvpc-development/terraform.tfstate"
  }
}

module "eks" {
  source                                = "git::git@github.com:terraform-aws-modules/terraform-aws-eks.git?ref=v14.0.0"
  cluster_name                          = "k8s-development"
  subnets                               = data.terraform_remote_state.eksvpc-development.outputs.all_subnets
  manage_aws_auth                       = false
  config_output_path                    = "/home/seanmc/.kube/config"
  cluster_version                       = "1.18"
  cluster_create_timeout                = "15m"
  cluster_delete_timeout                = "15m"
  cluster_endpoint_private_access       = true
  cluster_endpoint_public_access        = true
  write_kubeconfig                      = true
  cluster_enabled_log_types             = ["audit"]
  cluster_endpoint_public_access_cidrs  = ["217.155.28.253/32"]
  cluster_endpoint_private_access_cidrs = ["0.0.0.0/0"]
  vpc_id                                = data.terraform_remote_state.eksvpc-development.outputs.vpc_id
  tags = {
    Environment = "development"
    Name        = "k8s development cluster"
  }

  node_groups = {
    default = {
      name             = "base-node-group"
      instance_type    = "t2.medium"
      key_name         = ""
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 2
      subnets          = data.terraform_remote_state.eksvpc-development.outputs.private_subnets
      k8s_labels = {
        "streetbees.com/environment" = "development"
      }
      additional_tags = {
        Name = "k8s development base node"
      }
    }
  }
}
