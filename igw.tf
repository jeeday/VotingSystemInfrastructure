
resource "aws_internet_gateway" "project2-igw" {
  vpc_id = aws_vpc.prod-vpc.id

  tags = {
    Name = "Project2-IGW"
  }
}
