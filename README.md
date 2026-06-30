# Three-Tier Highly Available Web Application on AWS

## 📖 Project Overview
This project demonstrates how to build a **3‑tier highly available web application** on AWS using only the AWS Console.  
It includes:
- **Web Tier**: Apache web server running on EC2 instances behind a public Application Load Balancer (ALB).
- **App Tier**: Node.js backend running on EC2 instances behind an internal ALB.
- **Database Tier**: Amazon RDS (MySQL/PostgreSQL) deployed in Multi‑AZ mode for high availability.

The architecture is designed to be **scalable, fault‑tolerant, and production‑ready**.

---

## 🏗️ Architecture Diagram
**Flow:**  
User → Public ALB → Web Tier (Apache ASG) → Internal ALB → App Tier (Node.js ASG) → RDS Multi‑AZ DB

---

## 🚀 Step‑by‑Step Implementation

### 1. Networking (VPC Setup)
- Created a custom VPC (`10.0.0.0/16`).
- Added **2 public subnets** (for Web Tier) and **2 private subnets** (for App + DB Tier) across different AZs.
- Attached an **Internet Gateway** to the VPC.
- Configured **Route Tables**:
  - Public subnets → route to Internet Gateway.
  - Private subnets → route to NAT Gateway for outbound internet access.

---

### 2. Security Groups
- **Web SG** → Allowed inbound HTTP/HTTPS (80/443) from anywhere.
- **App SG** → Allowed inbound traffic only from Web SG.
- **DB SG** → Allowed inbound traffic only from App SG on port 3306 (MySQL).

---

### 3. Web Tier (Presentation Layer)
- Created a **Launch Template** with Apache installation script:
  ```bash
  #!/bin/bash
  apt update -y
  apt install -y apache2
  systemctl start apache2
  echo "Hello from Web Tier" > /var/www/html/index.html
