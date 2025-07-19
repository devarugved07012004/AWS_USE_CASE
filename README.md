# 🚀 Static Website Hosting on AWS with CI/CD (Terraform + AWS DevOps Tools)

This project demonstrates how to host a **static website using AWS S3**, with an automated **CI/CD pipeline** for deployments. Infrastructure components like the **S3 bucket**, **IAM roles**, were provisioned using **Terraform**, while AWS-native DevOps tools like **CodePipeline**, **CodeBuild**, and **CodeDeploy** handled the continuous integration and deployment process.

## 📌 Features

- Static website hosted on **Amazon S3**
- Fully automated **CI/CD pipeline** for seamless deployments
- **Terraform** used to provision AWS infrastructure (EC2, S3, IAM)
- Pipeline built using **CodePipeline**, **CodeBuild**, and **CodeDeploy**
- Integration with **GitHub** to trigger deployments on code push
- Proper IAM role management for secure service communication

## 🛠️ Tools & Services Used

- **AWS EC2** – Instance to run Terraform and manage infrastructure
- **AWS S3** – Hosting static website files
- **Terraform** – Infrastructure as Code for EC2, S3, and IAM
- **AWS IAM** – Role-based access control for pipeline services
- **AWS CodePipeline** – Orchestrates the CI/CD process
- **AWS CodeBuild** – Handles build or validation of static files
- **AWS CodeDeploy** – Deploys static files to S3
- **GitHub** – Source code repository

## ⚙️ CI/CD Workflow Overview

1. **Infrastructure Setup:**  
   Terraform provisions an EC2 instance (used for running Terraform), an S3 bucket for website hosting, and IAM roles needed for the pipeline to access other AWS services securely.

2. **CodePipeline Configuration:**  
   Configured via the AWS Console to use either **GitHub** as the source. On code push, the pipeline triggers and passes the code to **CodeBuild** for  validation.

3. **Build & Deploy:**  
   After the build stage, **CodeDeploy** uploads the static website files to the S3 bucket, updating the live website automatically.

4. **Hosting:**  
   The S3 bucket is configured to serve the uploaded files as a static website, accessible via a public URL.

## 🚀 How to Deploy

- **Step 1:** Launch an EC2 instance and SSH into it.
- **Step 2:** Install **Terraform** and **AWS CLI** on the EC2 instance.
- **Step 3:** Clone the project repo and navigate to the Terraform configuration directory.
- **Step 4:** Run `terraform init` followed by `terraform apply` to provision the S3 bucket, IAM roles, and other resources.
- **Step 5:** Go to the AWS Management Console and create a new **CodePipeline**.
  - Source: GitHub 
  - Build: CodeBuild 
  - Deploy: CodeDeploy to S3
- **Step 6:** Push code to your repository — CodePipeline will trigger the build and deploy the static site to the S3 bucket.



