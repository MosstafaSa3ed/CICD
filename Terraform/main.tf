module "my_vpc" {
  source = "./modules/vpc"
  
  name = "${var.name}"
  cidr_block = var.cidr_block
}


module "my_routes"{
  source = "./modules/routes"
  
  my_vpc_id = module.my_vpc.my_vpc_id
  
  public_subnet_id = module.my_subnet.public_subnet_id
  private_subnet_id = module.my_subnet.private_subnet_id
}


module "my_subnet" {

  source = "./modules/subnet"
  
  name = var.name
  
  my_vpc_id = module.my_vpc.my_vpc_id
  
  cidr_block = var.cidr_block
  
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  
  igw = module.my_routes.igw
}



module "my_sg" {
  source = "./modules/security_group"
  
  my_vpc_id = module.my_vpc.my_vpc_id
}

module "my_instance" {
  source = "./modules/instance"
  
  public_key = var.public_key
  
  public_subnet_id = module.my_subnet.public_subnet_id
  private_subnet_id = module.my_subnet.private_subnet_id
  
  sg_allow_tls_id = module.my_sg.sg_allow_tls_id
  sg_allow_bastian_id = module.my_sg.sg_allow_bastian_id
  sg_allow_private_id = module.my_sg.sg_allow_private_id
}

module "my_s3" {
  source = "./modules/s3"
  
  bastian_instance_ip = module.my_instance.bastian_instance_ip
}