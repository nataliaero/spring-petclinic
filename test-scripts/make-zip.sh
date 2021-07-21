#!/usr/bin/sh
echo "======== Creating zip file"
yum update -y
yum install -y zip

zip -r zip-output/src.zip spring-petclinic/src/*

echo "======== ls -la zip-output"
ls -la zip-output
