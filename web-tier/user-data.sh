#!/bin/bash
apt update -y
apt install -y apache2
systemctl start apache2
echo "Hello from Web Tier" > /var/www/html/index.html
