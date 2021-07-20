#!/usr/bin/sh
echo Unzip file
yum update -y
yum install -y zip

unzip src.zip

ls -la .
