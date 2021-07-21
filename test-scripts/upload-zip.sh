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

  echo "============ ls -la zip-output"
  ls -la zip-output

echo "============ ls -l zip-output/src.zip"
  ls -l zip-output/src.zip

  echo "============ aws s3 ls"
  aws s3 ls

  echo "============ upload file to s3"
  aws s3 cp zip-output/src.zip s3://${BUCKET}

  echo "============ aws s3api list-objects --bucket ${BUCKET}"

  aws s3api list-objects --bucket ${BUCKET}

  echo "============ aws s3 ls s3://${BUCKET}"
  aws s3 ls s3://${BUCKET}
}

upload_zip




