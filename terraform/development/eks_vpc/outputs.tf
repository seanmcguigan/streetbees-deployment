output public_subnets {
  value = module.eks-vpc.public_subnets
}

output private_subnets {
  value = module.eks-vpc.private_subnets
}

output all_subnets {
  value = concat(module.eks-vpc.private_subnets, module.eks-vpc.public_subnets)
}

output nat_public_ips {
  value = module.eks-vpc.nat_public_ips
}

output vpc_id {
  value = module.eks-vpc.vpc_id
}

output vpc_cidr_block {
  value = module.eks-vpc.vpc_cidr_block
}
