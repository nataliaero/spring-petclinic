#!/usr/bin/sh
echo Unzip file
yum update -y
yum install -y zip

unzip zip-output/src.zip

ls -la .
echo "===== see what zip-out has: "
ls -la zip-output
echo "===== see what spring-petclinic has: "
ls -la spring-petclinic

echo "===== see what spring-petclinic/test-scripts has: "
ls -la spring-petclinic/test-scripts

