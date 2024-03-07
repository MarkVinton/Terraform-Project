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
module "Load_balancer" {
  source = "./modules/load-balancers"
  Heating_instance_id = module.Servers.Heating_id
  Lighting_instance_id = module.Servers.Lighting_id
  Auth_instance_id = module.Servers.Auth_id
  Status_instance_id = module.Servers.Status_id
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets = module.vpc.public_subnets
  security_group_ids = module.security.security_group_ids
}
module "autoscaling" {
  source = "./modules/autoscaling"
  security_group_ids = module.security.security_group_ids
  lights_target = module.Load_balancer.lights_target_group
  desired_capacity = var.desired_capacity
  max_size = var.max_size
  min_size = var.min_size
  subnet_ids = module.vpc.public_subnets
  heating_target = module.Load_balancer.heating_target
  status_target = module.Load_balancer.status_target
  auth_target = module.Load_balancer.auth_target
}