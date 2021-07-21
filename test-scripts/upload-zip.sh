#!/usr/bin/sh
yum update -y && yum install -y jq

assume_deployment_role() {
  echo "Region: " $REGION

  REGION=$REGION
  export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN

  CREDS_JSON=$(
    aws --region "$REGION" \
      --output json \
      sts get-session-token
  )

  AWS_ACCESS_KEY_ID=$(echo "$CREDS_JSON" | jq -r ".Credentials.AccessKeyId")
  AWS_SECRET_ACCESS_KEY=$(echo "$CREDS_JSON" | jq -r ".Credentials.SecretAccessKey")
  AWS_SESSION_TOKEN=$(echo "$CREDS_JSON" | jq -r ".Credentials.SessionToken")

  echo AWS_SESSION_TOKEN $AWS_SESSION_TOKEN

  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY
  export AWS_SESSION_TOKEN
}

upload_zip() {
  assume_deployment_role

  echo "============ upload file to s3"
  aws s3 cp s3://${BUCKET} zip-output/s3.zip

  aws s3api list-objects --bucket ${BUCKET}
}

upload_zip




