#!/usr/bin/sh
echo Unzip file
yum update -y
yum install -y zip

unzip zip-output/src.zip

ls -la .
ls -la zip-output

