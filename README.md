# Equity Leadership Program (ELP) Application

## Overview
The Equity Leadership Program (ELP) application is a microservices-based platform deployed on AWS using Amazon ECS with CI/CD automation via GitHub Actions. It consists of:

- **Frontend:** Angular
- **Backend:** Spring Boot
- **Database:** MySQL (Amazon RDS)
- **Infrastructure:** AWS ECS (Fargate), ALB, ECR, RDS, Security Groups, and IAM roles
- **CI/CD Pipeline:** GitHub Actions for automated deployment

---

## Architecture
The application is containerized and deployed using AWS ECS with a load balancer to route traffic to the frontend and backend services.

### Components:
- **Amazon ECR**: Stores Docker images for frontend and backend.
- **Amazon ECS (Fargate)**: Runs the frontend and backend containers.
- **Application Load Balancer (ALB)**: Routes traffic between the frontend and backend services.
- **Amazon RDS (MySQL)**: Stores application data.
- **Security Groups**: Controls access to ECS services and database.

---

## Setup & Deployment

### Prerequisites
1. **AWS CLI** configured with proper IAM permissions.
2. **Terraform** installed for infrastructure provisioning.
3. **Docker** installed for building images.
4. **GitHub Actions secrets** configured with AWS credentials.

### Deployment Workflow
1. **Provision Infrastructure** using Terraform:
   ```sh
   terraform init
   terraform apply -auto-approve
   ```
2. **Push Code to GitHub** (Triggers CI/CD):
   ```sh
   git add .
   git commit -m "Deploying ELP App"
   git push origin main
   ```
3. **GitHub Actions Workflow:**
   - Builds and pushes Docker images to Amazon ECR.
   - Deploys services to Amazon ECS.
   - Initializes MySQL database on Amazon RDS.

---

## GitHub Actions CI/CD Pipeline
### Workflow Summary
- **Checkout Code**: Clones the repository.
- **Set Up AWS CLI**: Authenticates AWS services.
- **Build & Push Images**: Docker builds frontend & backend images and pushes them to ECR.
- **Deploy to ECS**: Updates services and forces new deployment.
- **Verify Services**: Ensures ECS services are running properly.

### Workflow File (`.github/workflows/deploy.yml`)
See the full YAML file in the `.github/workflows/` directory.

---

## AWS Resources
### Terraform Infrastructure
The `main.tf` file provisions:
- ECS Cluster
- ECR Repositories
- ALB & Target Groups
- ECS Services & Task Definitions
- IAM Roles & Security Groups

### Security Group Configuration
- **Frontend Service SG**: Allows HTTP traffic.
- **Backend Service SG**: Allows traffic only from the frontend.
- **Database SG**: Restricts access to backend service only.

---

## Usage
### Access the Application
Once deployed, access the frontend via the ALB URL:
```sh
http://<ALB-DNS-NAME>
```
Backend API is available at:
```sh
http://<ALB-DNS-NAME>/api/
```

---

## Future Improvements
- Implement auto-scaling for ECS tasks.
- Add logging and monitoring with AWS CloudWatch.
- Enhance security with AWS Secrets Manager for credentials management.

---

## Contributors
- **Mercy Jepkosgei** - DevOps Engineer
- **Eric Wanjala** - Frontend Developer
- **Mercy Jepkemboi** - Backend Engineer


