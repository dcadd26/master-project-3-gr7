#!/bin/bash
set -xe

dnf update -y
dnf install -y httpd git

systemctl enable httpd
systemctl start httpd

rm -rf /tmp/webapp
git clone https://github.com/dcadd26/master-project-3-group7-html.git /tmp/webapp

rm -rf /var/www/html/*

cp /tmp/webapp/index.html /var/www/html/index.html
cp /tmp/webapp/style.css /var/www/html/style.css

chown apache:apache /var/www/html/index.html /var/www/html/style.css
chmod 644 /var/www/html/index.html /var/www/html/style.css

systemctl restart httpd