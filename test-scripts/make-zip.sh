#!/usr/bin/sh
echo Creating zip file
yum update -y
yum install -y zip

zip -r image/src.zip repo/src/*

ls -la image
