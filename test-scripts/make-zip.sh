#!/usr/bin/sh
echo Creating zip file
yum update -y
yum install -y zip

zip -r zip-output/src.zip spring-petclinic/src/*

ls -la zip-output
