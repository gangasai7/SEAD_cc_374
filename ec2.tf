resource "aws_instance" "epicbook" {

  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  key_name = var.key_name

  user_data = <<-EOF
#!/bin/bash
apt update -y
apt upgrade -y
apt install nodejs npm git nginx mysql-client -y
EOF

  tags = {
    Name = "EpicBook-Server"
  }
}
resource "aws_eip" "ec2_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "ec2_eip_assoc" {
  instance_id   = aws_instance.epicbook.id
  allocation_id = aws_eip.ec2_eip.id
}