
//module "vpc" {
// source             = "terraform-aws-modules/vpc/aws"
// name               = "prod-vpc"
// cidr               = "10.0.0.0/16"
// azs                = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
// private_subnets    = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
// public_subnets     = ["10.0.4.0/24"]
// enable_nat_gateway = true
// single_nat_gateway = true


resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  //enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  enable_classiclink   = "false"
  instance_tenancy     = "default"
  //default_route_table_id = aws_route_table.project2-private.id


  tags = {
    Name = "Project2 VPC"
  }

}
