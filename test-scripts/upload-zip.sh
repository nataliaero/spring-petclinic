#!/usr/bin/sh
echo Unzip file
yum update -y
yum install -y zip

unzip image/src.zip

echo "===== see what image has: "
ls -la image
echo "===== see what repo has: "
ls -la repo


