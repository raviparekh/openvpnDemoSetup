resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.management.id}"
  cidr_block              = "10.10.0.0/25"
  availability_zone = "eu-west-1a"
  depends_on = ["aws_internet_gateway.gw"]

  tags {
    Name = "test Management public subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.management.id}"
  cidr_block              = "10.10.0.128/25"
  availability_zone = "eu-west-1a"

  tags {
    Name = "test Management private subnet"
  }
}
