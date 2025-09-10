resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/24"

    tags = {
        Name = "flask-project-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = "public-subnet-flask"
    }
}

