# Terraform Infrastructure as Code (IaC) Template

This repository contains a simple template to create Infrastructure as Code (IaC) using **Terraform** to launch an **AWS EC2** instance, configure a network, and deploy a containerized HTML/CSS website using **Docker**.

## 🚀 Overview

This project automates the creation of:

- **AWS EC2 Instance** to host your website.
- **Docker** container running an HTML/CSS site.
- A **VPC** and **Security Groups** to set up a network.
  
Before you begin, make sure to replace placeholders with your specific information, like AWS keys and file paths.

## 💡 Steps to Run the Template

### 1. Configure Terraform

Before running the template, make sure you have **Terraform** installed and configured on your local machine.

- Replace the necessary keys and paths in the Terraform configuration files.
- **AWS Credentials** should be properly set up, either via environment variables or the AWS CLI.

### 2. Initialize Terraform

Run the following command to initialize Terraform and download necessary providers:

bash
terraform init

3. Format Terraform Code
To ensure the code is well-organized and adheres to best practices, run:

bash
terraform fmt -recursive

4. Deploy Infrastructure to AWS
After the code is formatted, apply the Terraform configuration to launch the EC2 instance and configure the network:

bash
terraform apply

Terraform will ask for confirmation. Type yes to proceed.

5. Docker Setup
Before deploying your site to AWS, build the Docker image and run the Docker container:

Create a Dockerfile with your HTML and CSS files.

Build the Docker image:

bash
docker build -t my-website .

Run the Docker container locally to test:

bash
docker run -p 80:80 my-website

Once you confirm that the site works locally, Terraform will handle the rest.

6. Destroy the Infrastructure
To avoid ongoing AWS charges, remember to destroy your application and all resources when you're done:

bash
terraform destroy

Terraform will prompt for confirmation. Type yes to proceed.

# Using the Repository as a Module for EC2 Creation

If you want to use this repository as a module to create an EC2 instance, you can reference it using either HTTPS or SSH:

## Using HTTPS:

hcl
module "EC2" {
  source = "https://github.com/EngGuilherme/docker-tf-ec2-module.git"
}

## Using SSH:
hcl
module "EC2" {
  source = "git@github.com:EngGuilherme/docker-tf-ec2-module.git"
}

Setting Up Your Application

Next, create a folder for your application in your repository and add a Dockerfile inside this folder.

Create a folder for your app (e.g., my-app/).
Add a Dockerfile to that folder, specifying how the container should be built.
Building and Running the Docker Container

Build the Docker container:

bash
docker build -t my-app .

This command will build the Docker image using the Dockerfile in your current directory.

Running Terraform
Once the Docker container is built, you can proceed with Terraform:

Initialize Terraform in your project directory:

bash
terraform init

Plan the infrastructure to see which variables are required by the module:

bash
terraform plan

This will show you which variables need to be provided for the module to create the EC2 instance and other resources.
## Enjoy!

⚡ Key Notes

Make sure your AWS key pair is specified correctly in the Terraform configuration to allow SSH access to the EC2 instance.
You can customize the Dockerfile to fit your website's content.
Replace all placeholder paths and keys with your actual information.

🌟 Useful Terraform Commands

terraform init - Initialize the Terraform working directory.
terraform fmt -recursive - Format your Terraform code for consistency.
terraform apply - Apply the configuration and create resources on AWS.
terraform destroy - Destroy the infrastructure to avoid charges.

🚧 Warnings

Be sure to destroy your resources when you no longer need them to prevent unnecessary costs.
Ensure that you replace the placeholder keys, file paths, and other configuration details with your own information before running the commands.

📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/index.html)
- [Docker Documentation](https://docs.docker.com/)

🟣 Terraform | 🔵 Docker | 🟡 AWS
