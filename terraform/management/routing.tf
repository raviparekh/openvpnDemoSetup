resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.management.id}"

  tags {
    Name = "test Management internet gateway"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.nat_gateway_eip.id}"
  subnet_id = "${aws_subnet.public_subnet.id}"
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_eip" "nat_gateway_eip" {
  vpc      = true
}

resource "aws_route_table" "management-routing-table-with-internet-gw" {
  vpc_id = "${aws_vpc.management.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "test Management routing table with internet gateway"
  }
}

resource "aws_route_table" "management-routing-table-nat-gw" {
  vpc_id = "${aws_vpc.management.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}"
  }

  tags {
    Name = "test Private routing table with NAT"
  }
}

resource "aws_route_table_association" "management-routing-table-association" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.management-routing-table-with-internet-gw.id}"
}

resource "aws_route_table_association" "management-routing-table-association-with-nat" {
  subnet_id = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.management-routing-table-nat-gw.id}"
}