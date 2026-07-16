##################################################
# EC2 Public IP
##################################################

output "ec2_public_ip" {

  description = "Public IP of EC2 Instance"

  value = aws_instance.devops_server.public_ip

}

##################################################
# EC2 Public DNS
##################################################

output "ec2_public_dns" {

  description = "Public DNS of EC2 Instance"

  value = aws_instance.devops_server.public_dns

}

##################################################
# Frontend ECR Repository URL
##################################################

output "frontend_ecr_repository_url" {

  description = "Frontend ECR Repository URL"

  value = aws_ecr_repository.frontend.repository_url

}

##################################################
# Backend ECR Repository URL
##################################################

output "backend_ecr_repository_url" {

  description = "Backend ECR Repository URL"

  value = aws_ecr_repository.backend.repository_url

}

##################################################
# SSH Command
##################################################

output "ssh_command" {

  description = "SSH Command"

  value = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.devops_server.public_ip}"

}