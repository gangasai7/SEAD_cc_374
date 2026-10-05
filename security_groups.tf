resource "aws_security_group" "ansible_control_sg" {
  name        = "ansible-control-sg"
  description = "Security group for Ansible control node"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = [var.my_ip]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ansible-control-sg"
  }
}
resource "aws_security_group" "ansible_managed_sg" {
  name        = "ansible-managed-sg"
  description = "Security group for Ansible managed nodes"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description     = "SSH from Ansible control node"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"

    security_groups = [
      aws_security_group.ansible_control_sg.id
    ]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ansible-managed-sg"
  }
}