######### gateway ######
resource "aws_internet_gateway" "gw" {
  vpc_id = var.my_vpc_id

  tags = {
    Name = "igw"
  }
}

###### elastic ip #########

resource "aws_eip" "nat-gateway-ip" {
  vpc              = true
 # public_ipv4_pool = "ipv4pool-ec2-012345"
}

####### Nat gateway ########
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat-gateway-ip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "gw NAT"
  }
}

######## public route table ########
resource "aws_route_table" "public" {
  vpc_id = var.my_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

######## private route table ########
resource "aws_route_table" "private" {
  vpc_id = var.my_vpc_id
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "private-rt"
  }
}

########## public subnet assosiation #######

resource "aws_route_table_association" "public" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public.id
}

########## private subnet assosiation #######

resource "aws_route_table_association" "private" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private.id
}