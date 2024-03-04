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
module "dynamo_lighting" {
  source = "./modules/dynamo"
db_table_name = var.db_table_name_lighting
hash_key_name = var.hash_key_name_lighting
hash_key_type = var.hash_key_type_lighting
}
module "dynamo_heating" {
  source = "./modules/dynamo"
  db_table_name = var.db_table_name_heating
hash_key_name = var.hash_key_name_heating
hash_key_type = var.hash_key_type_heating
}
module "Servers" {
  source = "./modules/servers"
  public_subnets = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  security_group_ids = module.security.security_group_ids
}
output "security_group_ids" {
  value = module.security.security_group_ids
}
output "public_subnets" {
  value = module.vpc.public_subnets
}