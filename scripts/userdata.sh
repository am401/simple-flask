#!/bin/bash

yum update -y
# No longer available
# amazon-linux-extras install epel -y
yum install nginx -y
yum install git -y
yum install gcc -y
yum install build-essential -y
yum install python3-pip python3-devel python3-setuptools -y

git config --global user.name "am401"

# Setup ssh config for github

#echo "Host github.com\n\tHostName github.com\n\tPreferredAuthentications publickey\n\tIdentityFile ~/.ssh/file" >> ~/.ssh/config

aws configure set region us-east-1

mkdir -p /var/www

# update me
git clone https://github.com/am401/simple-flask.git /var/www

cd /var/www

git config core.fileMode false

# update me
aws s3 cp s3://tci-s3-demo-032125/simple-flask/.env .env

chmod +x scripts/post_userdata.sh

./scripts/post_userdata.sh
