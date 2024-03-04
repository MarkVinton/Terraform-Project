variable "cidr_block" {
  description = "CIDR for VPC"
  
}
variable "availability_zones" {
  description = "A list of availability zones"

}
variable "public_subnets_cidr" {
  description = "A list of CIDR for public subnets"

}
variable "private_subnets_cidr" {
  description = "A list of CIDR for private subnets"
  
}
variable "db_table_name_lighting" {
  description = "Name of dynamo table"
}
variable "hash_key_name_lighting" {
  description = "Name of hash key"
}
variable "hash_key_type_lighting" {
  description = "Type of hash key"
}
variable "db_table_name_heating" {
  description = "Name of dynamo table"
}
variable "hash_key_name_heating" {
  description = "Name of hash key"
}
variable "hash_key_type_heating" {
  description = "Type of hash key"
}
