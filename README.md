# Three-Tier Highly Available Web Application on AWS

## Architecture
- **Web Tier**: Apache on EC2 (Auto Scaling + Public ALB)
- **App Tier**: Node.js backend on EC2 (Auto Scaling + Internal ALB)
- **DB Tier**: Amazon RDS Multi-AZ (MySQL/PostgreSQL)

## Setup
1. Create VPC with 2 public + 2 private subnets.
2. Configure Internet Gateway, NAT Gateway, and Route Tables.
3. Create Security Groups:
   - Web SG → allow HTTP/HTTPS from internet.
   - App SG → allow traffic only from Web SG.
   - DB SG → allow traffic only from App SG.
4. Create Launch Templates for Web + App tiers using provided user-data scripts.
5. Create Auto Scaling Groups (min 2, max 4) in multiple AZs.
6. Create ALBs:
   - Public ALB → Web Tier.
   - Internal ALB → App Tier.
7. Create RDS Multi-AZ DB in private subnets.

## Testing
- Access Public ALB DNS → Web Tier page.
- Web Tier forwards traffic → App Tier (Node.js).
- App Tier connects to RDS DB.
