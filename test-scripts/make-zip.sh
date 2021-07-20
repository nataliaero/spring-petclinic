#!/usr/bin/sh
echo Creating zip file
yum update -y
yum install -y zip

cd spring-getclinic/src
zip -r ../../zip-output/src.zip .

ls -la zip-output
