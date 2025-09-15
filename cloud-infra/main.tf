resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "flask-project-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block              = "10.0.0.0/24"
  vpc_id                  = aws_vpc.main_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-flask"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "flask-project-ig"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "flask-project-route-table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main_vpc.id

  ingress = []
  egress  = []

  tags = {
    Name = "disabled-default-sg"
  }
}


resource "aws_security_group" "open_flask" {
  name = "allow_flask"
  description = "Allow connections through port 5000 and SSH"
  vpc_id = aws_vpc.main_vpc.id

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "allow_flask_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.open_flask.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_flask" {
  security_group_id = aws_security_group.open_flask.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 5000
  ip_protocol = "tcp"
  to_port = 5000
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.open_flask.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "flask_ec2" {
  ami = local.ec2-ami
  instance_type = local.ec2-instance-type

  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.open_flask.id]

  key_name = local.ec2-key-name

  user_data = file(local.ec2-user-data-route)

  tags = {
    Name = "flask_ec2"
  }
}






