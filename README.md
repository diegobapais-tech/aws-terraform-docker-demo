# AWS Terraform Docker Demo

## Project Definition
This project is an exercise designed to learn and practice **Docker**, **AWS**, **Terraform**, and **Git/GitHub** through a hands-on deployment scenario.  
The goal is to containerize a simple Flask web app, deploy it on AWS using ECS (Elastic Container Service), provision all resources with Terraform.

---

## Exercise Breakdown

### 0. Git repository
- Create a git repository named aws-terraform-docker-demo
- Create two separate branches named development and production
  - Protect development and production from detele

### 1. Web App
- Create a simple Flask app (`app/app.py`) that returns:
  - "Hello World"
  - The current UTC timestamp
- Add `requirements.txt` with Flask as a dependency.
- Test the app locally (`flask app.py`).


### 2. Docker
- Write a `Dockerfile` to containerize the Flask app.
- Build and run the image locally:
  ```bash
  docker build -t hello-world-app ./app
  docker run -p 5000:5000 hello-world-app
- Push the image to a container registry (Docker Hub).

### 3. Terraform (Infrastructure as Code)
- Set up Terraform configuration in terraform/ to provision:
    - `VPC, subnets, and security groups`
    - `Create ec2 instance with user_data set up file`
- Run terraform apply to create the infrastructure.
- Verify that the app is accessible via the public load balancer URL.
