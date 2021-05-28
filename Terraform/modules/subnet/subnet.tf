######### public subnet ########
resource "aws_subnet" "public" {
  vpc_id     = var.my_vpc_id
  cidr_block = "${var.public_subnet_cidr}"

  map_public_ip_on_launch = true

  depends_on = [var.igw]
  
  tags = {
    Name = "${var.name}-public"
  }
}

######### private subnet ########
resource "aws_subnet" "private" {
  vpc_id     = var.my_vpc_id
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "${var.name}-private"
  }
}