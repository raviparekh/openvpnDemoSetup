resource "aws_instance" "bastion" {
  ami = "ami-ed82e39e"
  instance_type = "m3.large"
  key_name = "openvpnDemo"
  security_groups = ["${aws_security_group.management-bastion-security-group.id}"]
  subnet_id = "${aws_subnet.public_subnet.id}"
  source_dest_check = false
  associate_public_ip_address = true

  tags {
    Name = "test Management bastion instance"
    ssh_user = "ubuntu"
    for_ansible = "test_bastion"
  }
}
