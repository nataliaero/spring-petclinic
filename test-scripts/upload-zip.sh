#!/usr/bin/sh
yum update -y && yum install -y jq

assume_deployment_role() {
  REGION=$REGION
  export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN

  CREDS_JSON=$(
    aws --region "$REGION" \
      --output json \
      sts assume-role \
      --role-arn arn:aws:iam::"$AWS_ACCOUNT_ID":role/webgis-staging-admin-nat \
      --role-session-name webgis-staging-admin-nat
  )

  AWS_ACCESS_KEY_ID=$(echo "$CREDS_JSON" | jq -r ".Credentials.AccessKeyId")
  AWS_SECRET_ACCESS_KEY=$(echo "$CREDS_JSON" | jq -r ".Credentials.SecretAccessKey")
  AWS_SESSION_TOKEN=$(echo "$CREDS_JSON" | jq -r ".Credentials.SessionToken")

  export AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY
  export AWS_SESSION_TOKEN
}

assume_deployment_role




