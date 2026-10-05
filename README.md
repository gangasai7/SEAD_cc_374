# 🚀 Terraform + Ansible AWS Infrastructure Automation

This project demonstrates **Infrastructure as Code (IaC)** and **configuration management** using **Terraform and Ansible on AWS**.

Terraform provisions three Ubuntu EC2 instances in the **AWS Default VPC**, while Ansible is used to configure the two managed servers.

---

## 🏗️ Architecture

```text
                         AWS Default VPC
                                |
              +-----------------+-----------------+
              |                                   |
              |                                   |
      Ansible Control Node                 Ansible Managed Nodes
           EC2-1                              EC2-2 / EC2-3
           Ubuntu                               Ubuntu
              |                                   |
       Ansible Installed                          |
              |                                   |
              +------------ SSH -----------------+
                              |
                    Server Configuration
                         /             \
                        /               \
                    EC2-2             EC2-3
                   Nginx              MySQL
