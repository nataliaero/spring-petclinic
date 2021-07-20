#!/usr/bin/sh
echo Unzip file
yum update -y
yum install -y zip

unzip spring-petclinic/src.zip

echo "===== see what zip-out has: "
ls -la zip-output
echo "===== see what spring-petclinic has: "
ls -la spring-petclinic


