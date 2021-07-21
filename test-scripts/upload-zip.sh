#!/usr/bin/sh
yum update -y && yum install -y jq

assume_deployment_role() {
  echo "Region: " $REGION
  echo AWS_ACCESS_KEY $AWS_ACCESS_KEY
  echo AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY
  echo AWS_ACCOUNT_ID $AWS_ACCOUNT_ID

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

  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY
  export AWS_SESSION_TOKEN
}

assume_deployment_role




