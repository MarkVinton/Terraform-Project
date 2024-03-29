cidr_block = "10.0.0.0/16"
public_subnets_cidr = ["10.0.16.0/24", "10.0.32.0/24", "10.0.48.0/24"]
private_subnets_cidr =  ["10.0.17.0/24", "10.0.33.0/24", "10.0.49.0/24"]
availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
hash_key_name_lighting = "id"
hash_key_type_lighting = "N"
db_table_name_lighting = "Lighting"
hash_key_name_heating = "id"
hash_key_type_heating = "N"
db_table_name_heating = "Heating"
desired_capacity = 1
min_size = 1
max_size = 2
lights_ami = "ami-0d0a2a750f418d96b"
heating_ami = "ami-0e7bec81f92034d91"
status_ami = "ami-057c61ee0a8cafeb0"
auth_ami = "ami-085502d28061bd806"
key_name = "key-ED25519"
service_names = ["lights","heating","status","auth"]
instance_type = "t2.micro"