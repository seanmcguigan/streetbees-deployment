module "eks-vpc" {
  source                         = "git::git@github.com:terraform-aws-modules/terraform-aws-vpc.git?ref=v2.77.0"
  name                           = "k8s-development"
  cidr                           = "10.0.0.0/22"
  azs                            = ["us-east-1b", "us-east-1a"]
  public_subnets                 = ["10.0.2.0/26"]
  private_subnets                = ["10.0.0.0/26", "10.0.1.0/26"]
  enable_classiclink             = false
  enable_classiclink_dns_support = false
  enable_dns_hostnames           = true
  enable_dns_support             = true
  map_public_ip_on_launch        = false
  enable_nat_gateway             = true
  single_nat_gateway             = true
  tags = {
    "kubernetes.io/cluster/k8s-operations" = "shared"
  }
}
