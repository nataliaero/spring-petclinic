#!/usr/bin/sh
echo Unzip file
yum update -y
yum install -y zip

unzip -r -j src.zip

ls -la .
