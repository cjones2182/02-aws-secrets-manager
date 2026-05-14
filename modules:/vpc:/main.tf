# ============================================================================
# vpc cidr
# ===========================================================================
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr


  tags = {
    name = "${var.environment}-vpc"
    environment = var.environment
  }
}
# ===========================================================================
# public subnets 
# ===========================================================================
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)
 vpc_id = aws_vpc.main.id
 cidr_block = var.public_subnets[count.index]
 availability_zone = var.availability_zones[count.index]

 tags = {
    name = "${var.environment}-public subnets-${count.index}"
    environment = var.environment
  }
}
# ===========================================================================
# private subnets 
# ===========================================================================
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    name = "${var.environment}-private subnets-${count.index}"
    environment = var.environment
  }
}
# ===========================================================================
# database subnets 
# ===========================================================================
resource "aws_subnet" "database_subnets" {
  count = length(var.database_subnets)
  vpc_id = aws_vpc.main.id
  cidr_block = var.database_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    name = "${var.environment}-database subnets-${count.index}"
    environment = var.environment
  }
}
# ===========================================================================
# igw
# ===========================================================================
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    name = "${var.environment}-igw"
    environment = var.environment
  }
}
# ===========================================================================
# eip
# ===========================================================================
resource "aws_eip" "nat_eips" {
  count = length(var.public_subnets)
  domain = "vpc"

    tags = {
    name = "${var.environment}-eip-${count.index}"
    environment = var.environment
  }
}
# ===========================================================================
# nat gateway
# ===========================================================================
resource "aws_nat_gateway" "nat" {
  count = length(var.public_subnets)
  allocation_id = aws_eip.nat_eips[count.index].id
  subnet_id = aws_subnet.public_subnets[count.index].id

    tags = {
    name = "${var.environment}-nat-${count.index}"
    environment = var.environment
  }
}
# ===========================================================================
#  route table 
# ===========================================================================
resource "aws_route_table" "public_route_table" {
 vpc_id = aws_vpc.main.id

count = length(var.public_subnets)
 route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
 }
   tags = {
    name = "${var.environment}-public route table-${count.index}"
    environment = var.environment
  }
}

resource "aws_route_table" "private_route_table" {
 vpc_id =  aws_vpc.main.id 

 count = length(aws_nat_gateway.nat)

 route {
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat[count.index].id
 }
 tags = {
    name = "${var.environment}-private route table-${count.index}"
    environment = var.environment
  }
}

# ===========================================================================
#  route table association
# ===========================================================================
# public route table association
resource "aws_route_table_association" "public_route_table_association" {
  count = length(var.public_subnets)

  subnet_id = aws_subnet.public_subnets[count.index].id
 route_table_id =  aws_route_table.public_route_table[count.index].id

}
# private route table association 
resource "aws_route_table_association" "private_route_table_association" {
 count = length(var.private_subnets) 

subnet_id = aws_subnet.private_subnets[count.index].id
route_table_id = aws_route_table.private_route_table[count.index].id
} 
# database route table association 

resource "aws_route_table_association" "database_route_table_association" {
  count = length(var.database_subnets)

  subnet_id = aws_subnet.database_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}