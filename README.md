# 🚀 Terraform + Ansible AWS Automation

This project automates AWS infrastructure using **Terraform** and configures EC2 servers using **Ansible**.

## 🏗️ Architecture

```text
                    AWS
                     |
              Default VPC
                     |
        +------------+------------+
        |                         |
   Ansible Control          Managed Servers
       Ubuntu              +---------------+
        |                  | Server 1      |
        |----------------->| Nginx         |
        |                  +---------------+
        |
        |----------------->+---------------+
                           | Server 2      |
                           | MySQL         |
                           +---------------+

🛠️ Technologies
- ☁️ AWS EC2
- 🏗️ Terraform
- ⚙️ Ansible
- 🐧 Ubuntu
- 🌐 Nginx
- 🗄️ MySQL
- 🔐 SSH
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

⚡ How It Works
1️⃣ Terraform
Terraform creates:
- 1 Ansible Control Node
- 2 Managed EC2 Servers
- Security Groups
- SSH Key Pairs
Ansible is automatically installed on the Control Node.
2️⃣ Ansible
Ansible connects to the managed servers using SSH.
- Server 1 → Nginx
- Server 2 → MySQL
🚀 Terraform Commands
terraform init
terraform plan
terraform apply

After deployment:
terraform output

⚙️ Ansible Commands
Test connectivity:
ansible all -m ping

Check playbook:
ansible-playbook playbook.yml --syntax-check

Run playbook:
ansible-playbook playbook.yml

🔍 Verify Installation
Check Nginx:
ansible server1 -m shell -a "nginx -v"

Check MySQL:
ansible server2 -m shell -a "mysql --version"

🔐 Security
- SSH access to Control Node is restricted to my IP.
- Managed servers allow SSH from the Control Node.
- HTTP port 80 is open for Nginx.
- Private SSH keys are not committed to GitHub.
🧹 Cleanup
To delete all AWS resources:
terraform destroy

📚 DevOps Concepts Demonstrated
- Infrastructure as Code
- AWS EC2
- Terraform
- Ansible Automation
- SSH
- Linux Administration
- Security Groups
- Configuration Management
👨‍💻 Author
Ganga Sai Reddy
