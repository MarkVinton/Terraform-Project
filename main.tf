module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.cidr_block
  public_subnets_cidr = var.public_subnets_cidr
  availability_zones = var.availability_zones
  private_subnets_cidr = var.private_subnets_cidr
}
module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id  
}