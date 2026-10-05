output "control_public_ip" {
  description = "Public IP of Ansible control node"
  value       = aws_instance.ansible_control.public_ip
}

output "control_private_ip" {
  description = "Private IP of Ansible control node"
  value       = aws_instance.ansible_control.private_ip
}

output "managed_public_ips" {
  description = "Public IPs of managed nodes"
  value       = aws_instance.managed[*].public_ip
}

output "managed_private_ips" {
  description = "Private IPs of managed nodes"
  value       = aws_instance.managed[*].private_ip
}

output "control_security_group" {
  value = aws_security_group.ansible_control_sg.id
}

output "managed_security_group" {
  value = aws_security_group.ansible_managed_sg.id
}