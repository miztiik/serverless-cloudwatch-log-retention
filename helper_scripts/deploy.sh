#!/bin/bash
set -ex

# Change BUCKET_NAME to a bucket you own for use by CloudFormation
BUCKET_NAME="sam-templates-010"
TEMPLATE_NAME="serverless-cloudwatch-log-retention-policy.yaml"
STACK_NAME="set-cloudwatch-logs-retention"
OUTPUT_DIR="./outputs/"
PACKAGED_OUTPUT_TEMPLATE="${OUTPUT_DIR}${STACK_NAME}-packaged-template.yaml"

aws cloudformation package \
    --template-file ${TEMPLATE_NAME} \
    --s3-bucket $BUCKET_NAME \
    --output-template-file ${PACKAGED_OUTPUT_TEMPLATE}

aws cloudformation deploy \
    --template-file ${PACKAGED_OUTPUT_TEMPLATE} \
    --stack-name ${STACK_NAME} \
    --capabilities CAPABILITY_IAM