# Research Portfolio Automation Tool

A containerized full-stack Research Portfolio Automation Tool that retrieves research publications using **ORCID** and **OpenAlex APIs**. The project demonstrates an end-to-end DevOps workflow using **Docker, GitHub Actions, AWS ECR, Kubernetes (K3s), ConfigMaps, PersistentVolumeClaims, and SSH-based automated deployment**.

---

## Project Overview

The application allows users to search for research publications using:

* **ORCID ID**
* **Author Name**

The backend communicates with the ORCID and OpenAlex APIs and returns publication data to the frontend.

The application is containerized using Docker and deployed on a **K3s Kubernetes cluster**. A GitHub Actions CI/CD pipeline automatically tests, builds, pushes Docker images to Amazon ECR, and deploys the latest version of the application to Kubernetes.

---

## Architecture

```text
Developer
    |
    | Git Push
    v
GitHub Repository
    |
    v
GitHub Actions CI Pipeline
    |
    |-- Run Frontend Tests
    |-- Build Docker Images
    |-- Push Images
    v
Amazon ECR
    |
    v
GitHub Actions CD Pipeline
    |
    | SSH
    v
AWS EC2 Instance
    |
    v
K3s Kubernetes Cluster
    |
    |-- Frontend Deployment (2 Replicas)
    |-- Backend Deployment (2 Replicas)
    |-- ConfigMap
    |-- PersistentVolumeClaim
    |-- Services
    |-- Traefik Ingress
    v
Research Portfolio Application
```

---

# Technology Stack

## Frontend

* React
* Vite
* Nginx

## Backend

* Python
* Flask
* Flask-CORS
* Gunicorn
* Requests

## DevOps and Infrastructure

* Docker
* GitHub Actions
* Amazon ECR
* AWS EC2
* Kubernetes
* K3s
* Traefik Ingress
* Kubernetes ConfigMaps
* PersistentVolumeClaims (PVC)
* AWS IAM
* Git and GitHub
* SSH-based deployment

---

# Application Features

* Search research publications using an ORCID ID.
* Search research publications using an author name.
* Integration with the ORCID API.
* Integration with the OpenAlex API.
* Removal of duplicate publication titles.
* Containerized frontend and backend.
* Automated CI/CD pipeline.
* Kubernetes deployment using K3s.
* Persistent storage configuration using a PVC.
* Environment configuration using ConfigMaps.

---

# Project Structure

```text
.
├── .github
│   └── workflows
│       ├── ci.yml
│       └── cd.yml
│
├── kubernetes
│   ├── backend
│   │   ├── configmap.yaml
│   │   ├── deployment.yaml
│   │   ├── pvc.yaml
│   │   └── service.yaml
│   │
│   ├── frontend
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   │
│   ├── ingress.yaml
│   └── namespace.yaml
│
├── research-backend
│   ├── Dockerfile
│   └── app.py
│
└── research-frontend
    ├── Dockerfile
    ├── package.json
    └── src/
```

---

# CI/CD Workflow

## Continuous Integration

The CI pipeline is triggered when code is pushed to the `main` branch.

The pipeline performs the following steps:

1. Checks out the source code.
2. Sets up Node.js.
3. Installs frontend dependencies.
4. Runs frontend unit tests.
5. Configures AWS credentials using GitHub Secrets.
6. Logs in to Amazon Elastic Container Registry (ECR).
7. Builds the backend Docker image.
8. Tags and pushes the backend image to Amazon ECR.
9. Builds the frontend Docker image.
10. Tags and pushes the frontend image to Amazon ECR.

### CI Flow

```text
Code Push
   |
   v
GitHub Actions
   |
   v
Run Frontend Tests
   |
   v
Build Backend Docker Image
   |
   v
Push Backend Image to Amazon ECR
   |
   v
Build Frontend Docker Image
   |
   v
Push Frontend Image to Amazon ECR
```

---

# Continuous Deployment

The CD pipeline is triggered after the CI workflow completes successfully.

The deployment workflow:

1. Connects to the EC2 server using SSH.
2. Pulls the latest code from GitHub.
3. Logs in to Amazon ECR.
4. Creates the Kubernetes namespace.
5. Refreshes the Kubernetes ECR image pull secret.
6. Applies the backend Kubernetes manifests.
7. Applies the frontend Kubernetes manifests.
8. Applies the Traefik Ingress configuration.
9. Restarts the frontend and backend deployments.
10. Waits for Kubernetes rollout completion.

This provides an automated deployment workflow from GitHub to the K3s cluster.

---

# Docker

Both the frontend and backend are containerized separately.

## Backend

The backend uses:

* Python 3.11
* Flask
* Gunicorn

The application listens on port `5000`.

Example build command:

```bash
docker build -t research-backend ./research-backend
```

Example run command:

```bash
docker run -p 5000:5000 research-backend
```

---

## Frontend

The frontend uses a multi-stage Docker build.

### Build Stage

The application is built using Node.js.

### Production Stage

The generated React application is served using Nginx.

Example build command:

```bash
docker build -t research-frontend ./research-frontend
```

Example run command:

```bash
docker run -p 8080:80 research-frontend
```

---

# Kubernetes Deployment

The application is deployed to a dedicated Kubernetes namespace.

```text
research-app
```

The Kubernetes configuration includes:

* Namespace
* Frontend Deployment
* Backend Deployment
* Frontend Service
* Backend Service
* ConfigMap
* PersistentVolumeClaim
* Ingress

---

## Backend Deployment

The backend runs with:

```text
Replicas: 2
Container Port: 5000
Image Pull Policy: Always
```

The backend uses:

* A ConfigMap for application configuration.
* A PersistentVolumeClaim for persistent report storage.
* An ECR image pull secret for pulling private images.

---

## Frontend Deployment

The frontend runs with:

```text
Replicas: 2
Container Port: 80
```

The frontend container serves the built React application through Nginx.

---

# Kubernetes ConfigMap

A ConfigMap is used to store non-sensitive application configuration.

Example configuration:

```text
APP_ENV=production
REPORT_PATH=/app/reports
LOG_LEVEL=INFO
```

The ConfigMap allows application configuration to be managed separately from the Docker image.

This means configuration can be updated without rebuilding the application image.

---

# PersistentVolumeClaim

A PersistentVolumeClaim is configured for report storage.

```text
Storage Request: 2Gi
Access Mode: ReadWriteOnce
Mount Path: /app/reports
```

The purpose of the PVC is to provide persistent storage for application-generated data.

Kubernetes pods are ephemeral, so data stored only inside a container can be lost when the pod is recreated. The PVC ensures that persistent data is stored outside the temporary container filesystem.

---

# Kubernetes Services

## Backend Service

The backend is exposed internally using a `ClusterIP` service.

```text
Service Port: 5000
Target Port: 5000
```

The backend service is used by the Kubernetes cluster and Ingress.

---

## Frontend Service

The frontend is exposed using a `NodePort` service.

```text
Service Port: 80
Target Port: 80
NodePort: 30080
```

---

# Traefik Ingress

K3s includes Traefik as an Ingress controller.

The Ingress routes requests as follows:

```text
/       → Frontend Service
/api    → Backend Service
```

Architecture:

```text
User
  |
  v
Traefik Ingress
  |
  ├── /      → Frontend Service → Frontend Pods
  |
  └── /api   → Backend Service  → Backend Pods
```

---

# AWS and Security

AWS credentials and sensitive information are not hardcoded in the source code.

GitHub Actions uses GitHub Secrets for sensitive values such as:

```text
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
EC2_HOST
EC2_USERNAME
EC2_SSH_KEY
```

The project follows security best practices such as:

* Avoiding hardcoded credentials.
* Using GitHub Secrets for sensitive information.
* Using IAM permissions based on the principle of least privilege.
* Using a private Kubernetes image pull secret for Amazon ECR images.
* Keeping application configuration separate from container images.

---

# Local Development

## Backend

Navigate to the backend directory:

```bash
cd research-backend
```

Install dependencies:

```bash
pip install flask flask-cors requests gunicorn
```

Run the application:

```bash
python app.py
```

The backend will run on:

```text
http://localhost:5000
```

---

## Frontend

Navigate to the frontend directory:

```bash
cd research-frontend
```

Install dependencies:

```bash
npm install
```

Start the development server:

```bash
npm run dev
```

Run tests:

```bash
npm test
```

Build the production application:

```bash
npm run build
```

---

# Kubernetes Deployment Commands

Create the namespace:

```bash
kubectl apply -f kubernetes/namespace.yaml
```

Deploy backend resources:

```bash
kubectl apply -f kubernetes/backend/
```

Deploy frontend resources:

```bash
kubectl apply -f kubernetes/frontend/
```

Deploy Ingress:

```bash
kubectl apply -f kubernetes/ingress.yaml
```

Check pods:

```bash
kubectl get pods -n research-app
```

Check services:

```bash
kubectl get services -n research-app
```

Check deployments:

```bash
kubectl get deployments -n research-app
```

Check logs:

```bash
kubectl logs <pod-name> -n research-app
```

---

# DevOps Concepts Demonstrated

This project demonstrates hands-on experience with:

* CI/CD automation.
* Docker containerization.
* Multi-stage Docker builds.
* GitHub Actions.
* Automated testing.
* Amazon ECR.
* Kubernetes Deployments.
* Kubernetes Services.
* Kubernetes ConfigMaps.
* Persistent storage using PVCs.
* Kubernetes namespaces.
* Ingress routing.
* K3s.
* Traefik.
* SSH-based automated deployment.
* AWS credential management.
* GitHub Secrets.
* Infrastructure and application deployment automation.

---

# Future Improvements

Possible improvements to the project include:

* Add Terraform for complete AWS infrastructure provisioning.
* Use AWS IAM Roles with short-lived credentials instead of long-term access keys.
* Add HTTPS with TLS certificates.
* Add monitoring using Prometheus and Grafana.
* Add centralized logging.
* Add Kubernetes resource requests and limits.
* Add liveness and readiness probes.
* Implement Horizontal Pod Autoscaling.
* Add vulnerability scanning to the CI pipeline.
* Use versioned Docker image tags instead of only `latest`.

---

# Author

**Ganga Sai**

GitHub: https://github.com/gangasai7

Project Repository: https://github.com/gangasai7/SEAD_cc_374

---

## Key Learning Outcome

This project helped me understand how different DevOps technologies work together in a real deployment workflow—from source code and automated testing to Docker image creation, Amazon ECR, Kubernetes deployment, persistent storage, configuration management, and automated continuous deployment.
