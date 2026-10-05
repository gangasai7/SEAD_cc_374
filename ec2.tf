resource "aws_instance" "ansible_control" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name = var.control_key_name

  subnet_id = data.aws_subnets.default.ids[0]

  vpc_security_group_ids = [
    aws_security_group.ansible_control_sg.id
  ]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "ansible-control"
    Role = "Ansible-Control"
  }
}
resource "aws_instance" "managed" {
  count = 2

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name = var.managed_key_name

  subnet_id = data.aws_subnets.default.ids[0]

  vpc_security_group_ids = [
    aws_security_group.ansible_managed_sg.id
  ]

  tags = {
    Name = "managed-server-${count.index + 1}"
    Role = "Ansible-Managed"
  }
}