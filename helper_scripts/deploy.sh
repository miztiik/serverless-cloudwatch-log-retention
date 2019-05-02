#!/bin/bash
set -ex

#----- Change these parameters to suit your environment -----#
AWS_PROFILE="default"
BUCKET_NAME="sam-templates-010" # bucket must exist in the SAME region the deployment is taking place
TEMPLATE_NAME="serverless-cloudwatch-log-retention-policy.yaml"
STACK_NAME="set-cloudwatch-logs-retention"
OUTPUT_DIR="./outputs/"
PACKAGED_OUTPUT_TEMPLATE="${OUTPUT_DIR}${STACK_NAME}-packaged-template.yaml"
#----- End of user parameters  -----#

aws cloudformation package \
    --template-file "${TEMPLATE_NAME}" \
    --s3-bucket "${BUCKET_NAME}" \
    --output-template-file "${PACKAGED_OUTPUT_TEMPLATE}"

aws cloudformation deploy \
    --profile "${AWS_PROFILE}" \
    --template-file "${PACKAGED_OUTPUT_TEMPLATE}" \
    --stack-name "${STACK_NAME}" \
    --capabilities CAPABILITY_IAM
