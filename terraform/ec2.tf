resource "aws_instance" "devops_server" {

  ami                         = var.ami_id

  instance_type               = var.instance_type

  key_name                    = var.key_name

  vpc_security_group_ids       = [
    aws_security_group.devops_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  associate_public_ip_address = true

  user_data = file("${path.module}/userdata.sh")

  root_block_device {

    volume_size = 30

    volume_type = "gp3"

    delete_on_termination = true

  }

  tags = {

    Name = "${var.project_name}-server"

    Environment = "Development"

    Project = var.project_name

  }

}