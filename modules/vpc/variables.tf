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