resource "aws_vpc" "management" {
  cidr_block = "10.10.0.0/22"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "test Management VPC"
    terraform_module = "management-vpc"
  }
}
