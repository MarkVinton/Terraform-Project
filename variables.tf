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
variable "desired_capacity" {
  description = "Desired capacity of ec2 instances for the autoscaler"
}
variable "max_size" {
  description = "Max amount of instances for asg"
}
variable "min_size" {
  description = "Minimium amount of instances for asg"
}
variable "lights_ami" {
  description = "AMI for lights template"
}
variable "heating_ami" {
  description = "AMI for heating template"
}
variable "status_ami" {
  description = "AMI for status template"
}
variable "auth_ami" {
  description = "AMI for auth template"
}
variable "key_name" {
  description = "Name of key to be used"
}
variable "service_names" {
  description = "List of names for the microservices"
}
variable "instance_type" {
  description = "Type of instance for launch template"
}