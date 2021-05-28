########## public insatnce in public subnet #########

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxHqK41dW6OgvG5p3OZabxNWTAZOt/yv4LIV03fUpyf2EJdSS03cIqs2ri6Ul9wkyNz6Ue663hZVDyMIl3+VJX8mvtLqa2IPAuVCS64C2Tx84b+6r4kzKE6bY4y9pgvKaGHCu2JcHodtFw7Pxs4O8f3xigojG3skOdGvhIpFuPVaQPOS8gfuDYcnkyQs7URsMOVWVkDgfVwQWKBe44EP+ouGGA5brCaDY8AgrZeI75UN02GHAOeMde3jAbUtoYRdf9JHfxiDfxA+SGLpew9hTJUl5D5BgxL5R76jsOhWIqPsJV/q6glOIKGBi05yERHnQ0HE3E0PFnk4CGxnkZbXfV"
}

resource "aws_instance" "bastion" {
  # eu-west-1
  ami           = "ami-063d4ab14480ac177"
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.sg_allow_tls_id]
  private_ip = "10.0.1.12"
  subnet_id  = var.public_subnet_id
  
  key_name = "ssh-key"
  associate_public_ip_address = true
  
  tags = {
      name = "bastion"
  }
}



############# private instance in public subnet       #########################

resource "aws_instance" "public1" {
  # eu-west-1
  ami           = "ami-063d4ab14480ac177"
  instance_type = "t2.micro"

  private_ip = "10.0.1.10"
  subnet_id  = var.public_subnet_id
  
  vpc_security_group_ids = [var.sg_allow_bastian_id]
  key_name = "ssh-key"
  
  tags = {
      name = "public1"
  }
}

resource "aws_instance" "public2" {
  # eu-west-1
  ami           = "ami-063d4ab14480ac177"
  instance_type = "t2.micro"

  private_ip = "10.0.1.11"
  subnet_id  = var.public_subnet_id
  
  vpc_security_group_ids = [var.sg_allow_bastian_id]
  key_name = "ssh-key"
  
  tags = {
      name = "public2"
  }
}

################   in private subnet ###########

resource "aws_instance" "private1" {
  # eu-west-1
  ami           = "ami-063d4ab14480ac177"
  instance_type = "t2.micro"

  private_ip = "10.0.2.10"
  subnet_id  = var.private_subnet_id
  
  vpc_security_group_ids = [var.sg_allow_private_id]
  key_name = "ssh-key"
  
  tags = {
      name = "private1"
  }
}

resource "aws_instance" "private2" {
  # eu-west-1
  ami           = "ami-063d4ab14480ac177"
  instance_type = "t2.micro"

  private_ip = "10.0.2.11"
  subnet_id  = var.private_subnet_id
  
  vpc_security_group_ids = [var.sg_allow_private_id]
  key_name = "ssh-key"
  
  tags = {
      name = "private2"
  }
}

# resource "aws_eip" "bar" {
#   vpc = true

#   instance                  = aws_instance.public1.id
#   associate_with_private_ip = "10.0.1.10"
#   depends_on                = [aws_internet_gateway.gw]
# }