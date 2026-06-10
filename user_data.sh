#!/bin/bash

dnf update -y

dnf install -y httpd git

systemctl enable httpd
systemctl start httpd

cd /tmp

git clone https://github.com/dcadd26/master-project-3-gr7.git

cp WEBAPP-REPO/index.html /var/www/html/
cp WEBAPP-REPO/style.css /var/www/html/

systemctl restart httpd