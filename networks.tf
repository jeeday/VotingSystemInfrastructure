resource "aws_subnet" "project2-public-subnet-2a" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = "eu-west-2a"
  tags = {
    Name = "Project2 Public Subnet"
  }
}

resource "aws_route_table" "project2-public" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project2-igw.id
  }



  tags = {
    Name = "Project2 Pulic Route"
  }
}

resource "aws_route_table_association" "project2-public-route-link" {

  subnet_id      = aws_subnet.project2-public-subnet-2a.id
  route_table_id = aws_route_table.project2-public.id

}

resource "aws_subnet" "webserver-subnet1-2a" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "false" //it makes this a public subnet
  availability_zone       = "eu-west-2a"
  tags = {
    Name = "Web Server Subnet #1 2A"
  }
}
resource "aws_subnet" "webserver-subnet2-2b" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false" //it makes this a public subnet
  availability_zone       = "eu-west-2b"
  tags = {
    Name = "Web Server Subnet #2 2B"
  }
}

resource "aws_subnet" "appserver-prod-subnet-2a" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false" //it makes this a public subnet
  availability_zone       = "eu-west-2a"
  tags = {
    Name = "App Server Prod Subnet 2A"
  }
}


resource "aws_subnet" "appserver-dr-subnet-2b" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false" //it makes this a public subnet
  availability_zone       = "eu-west-2b"
  tags = {
    Name = "App Server DR Subnet 2B"
  }
}



resource "aws_route_table_association" "project2-rivate-route-link-webserver-subnet1-2a" {

  subnet_id      = aws_subnet.webserver-subnet1-2a.id
  route_table_id = aws_default_route_table.project2-private.id

}


resource "aws_route_table_association" "project2-rivate-route-link-webserver-subnet2-2b" {

  subnet_id      = aws_subnet.webserver-subnet2-2b.id
  route_table_id = aws_default_route_table.project2-private.id

}

resource "aws_route_table_association" "project2-rivate-route-link-appserver-prod-subnet-2a" {

  subnet_id      = aws_subnet.appserver-prod-subnet-2a.id
  route_table_id = aws_default_route_table.project2-private.id

}

resource "aws_route_table_association" "project2-rivate-route-link-appserver-dr-subnet-2b" {

  subnet_id      = aws_subnet.appserver-dr-subnet-2b.id
  route_table_id = aws_default_route_table.project2-private.id

}
resource "aws_nat_gateway" "private-nat-gw" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.webserver-subnet1-2a.id
}

resource "aws_default_route_table" "project2-private" {
  default_route_table_id = aws_vpc.prod-vpc.default_route_table_id
  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.private-nat-gw.id
  }
  tags = {
    Name = "Project2 Private Route"
  }
}
