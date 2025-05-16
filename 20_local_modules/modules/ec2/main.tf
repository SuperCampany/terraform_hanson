resource "aws_instance" "web" {
  ami           = "ami-0265dc69e8de144d3"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet.id
  tags = {
    Name = "test-ec2"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-test-vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    "Name" = "test-test-subnet"
  }
}

resource "aws_security_group" "valut" {
  name        = "webserver-security-guroup"
  description = "Ingress for HTTP and HTTPS traffic"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {

    for_each = var.security_guroup_ingress_ports

    iterator = port

    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}


