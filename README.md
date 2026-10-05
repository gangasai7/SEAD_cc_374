# 🚀 Terraform + Ansible AWS Automation

A hands-on DevOps project that uses **Terraform to provision AWS infrastructure** and **Ansible to configure and manage EC2 servers**.

---

## 📌 Project Overview

This project creates **3 Ubuntu EC2 instances** in the AWS Default VPC:

- 🖥️ 1 Ansible Control Node
- 🌐 1 Managed Server with Nginx
- 🗄️ 1 Managed Server with MySQL

Terraform creates the infrastructure, while Ansible configures the managed servers.

---

## 🏗️ Architecture

```text
                         AWS
                          │
                    Default VPC
                          │
             ┌────────────┴────────────┐
             │                         │
      Ansible Control            Managed Servers
          Node                         │
        Ubuntu              ┌──────────┴──────────┐
             │              │                     │
             │          Server 1             Server 2
             │           Nginx                  MySQL
             │              │                     │
             └──────────────┴─────────────────────┘
                    Ansible SSH

🛠️ Technology Stack
AWS EC2 • Terraform • Ansible • Ubuntu • Nginx • MySQL • SSH • Git & GitHub
📁 Project Structure
terraform-ansible/
│
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── data.tf
│   ├── key_pairs.tf
│   ├── security_groups.tf
│   ├── ec2.tf
│   ├── outputs.tf
│   ├── user_data.sh
│   └── terraform.tfvars
│
└── Ansible/
    ├── inventory.yml
    ├── ansible.cfg
    └── playbook.yml

⚡ Workflow
Terraform
    │
    ▼
AWS Infrastructure
    │
    ▼
3 Ubuntu EC2 Instances
    │
    ▼
Ansible Control Node
    │
    ▼
SSH
    │
    ├──────────────┐
    ▼              ▼
 Server 1       Server 2
   Nginx          MySQL

🔐 Security
- SSH access to the Control Node is restricted to my IP.
- Managed servers allow SSH from the Control Node.
- HTTP port 80 is allowed for Nginx.
- Private SSH keys are not committed to GitHub.
📚 DevOps Concepts
- Infrastructure as Code
- AWS EC2
- Terraform
- Ansible
- Configuration Management
- SSH
- Linux Administration
- Security Groups
- Server Automation
- Git & GitHub
🧹 Cleanup
terraform destroy

👨‍💻 Author
Ganga Sai Reddy
