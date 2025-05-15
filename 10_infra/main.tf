#################################
##    NetWorking Service
#################################

resource "aws_vpc" "test-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "test-sekiguchi-vpc"
  }
}

resource "aws_subnet" "test-public-subnet" {
  vpc_id            = aws_vpc.test-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.aws_availability_zone
  tags = {
    Name = "test-public-subnet"
  }
}

resource "aws_subnet" "test-private-subnet" {
  vpc_id            = aws_vpc.test-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.aws_availability_zone
  tags = {
    Name = "test-private-subnet"
  }
}

resource "aws_internet_gateway" "test-igw" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "test-igw"
  }
}

resource "aws_route_table" "test-public-route-table" {
  vpc_id = aws_vpc.test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-igw.id
  }
  tags = {
    Name = "test-public-route-table"
  }
}

resource "aws_route_table" "test-private-route-table" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "test-private-route-table"
  }
}

resource "aws_route_table_association" "test-public-route-table-association" {
  subnet_id      = aws_subnet.test-public-subnet.id
  route_table_id = aws_route_table.test-public-route-table.id
}

resource "aws_route_table_association" "test-private-route-table-association" {
  subnet_id      = aws_subnet.test-private-subnet.id
  route_table_id = aws_route_table.test-private-route-table.id
}



#########################################
#    EC2 Service and related resource
#########################################

resource "aws_network_interface" "test-network-interface" {
  subnet_id = aws_subnet.test-public-subnet.id
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "test-ec2" {
  ami           = "ami-0265dc69e8de144d3"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.test-network-interface.id
    device_index         = 0
  }

}



##########################################
#       ALB and related resource
##########################################

