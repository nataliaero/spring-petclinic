#!/usr/bin/sh
echo Creating zip file
yum update -y
yum install -y zip

zip -r -j src.zip spring-petclinic/src/*

ls -la .
