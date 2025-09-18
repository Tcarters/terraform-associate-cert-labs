#!/bin/bash

set -euo pipefail

readonly WEB_ROOT="/var/www"
readonly INDEX_PHP_URL="https://raw.githubusercontent.com/hashicorp/learn-terramino/master/index.php"

# Log all output
exec > /var/log/user-data.log 2>&1
echo "Starting LAMP setup at $(date)"

# Update and install packages
if command -v dnf &> /dev/null; then
  dnf update -y
  dnf install -y httpd mariadb-server
else
  yum update -y
  yum install -y httpd mariadb-server
fi
amazon-linux-extras install -y lamp-mariadb10.2-php7.2

# Start and enable Apache
systemctl enable httpd
if ! systemctl is-active --quiet httpd; then
  systemctl start httpd
fi

# Configure permissions
if ! id -nG "ec2-user" | grep -qw "apache"; then
  gpasswd -a ec2-user apache
fi
chown -R ec2-user:apache "$WEB_ROOT"
find "$WEB_ROOT" -type d -exec chmod 755 {} \;
find "$WEB_ROOT" -type f -exec chmod 644 {} \;

# Download index.php with validation
cd "$WEB_ROOT/html" || exit 1
if ! curl -fsSL "$INDEX_PHP_URL" -o index.php; then
  echo "ERROR: Failed to download index.php" >&2
  exit 1
fi
curl http://169.254.169.254/latest/meta-data/instance-id -o index.html

# Configure firewall
if command -v firewall-cmd &> /dev/null; then
  firewall-cmd --permanent --add-service=http
  firewall-cmd --permanent --add-service=https
  firewall-cmd --reload
fi

echo "LAMP setup completed successfully at $(date)"
