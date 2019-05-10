#!/bin/bash
# set -x
set -e


#----- Change these parameters to suit your environment -----#
AWS_PROFILE="default"
BUCKET_NAME="sam-templates-011" # bucket must exist in the SAME region the deployment is taking place
TEMPLATE_NAME="serverless-cloudwatch-log-retention-policy.yaml"
STACK_NAME="set-cloudwatch-logs-retention"
OUTPUT_DIR="./outputs/"
PACKAGED_OUTPUT_TEMPLATE="${OUTPUT_DIR}${STACK_NAME}-packaged-template.yaml"
SERVICE_NAME="cw-log-retention-enforcer"
#----- End of user parameters  -----#

# Cleanup Output directory
rm -rf "${OUTPUT_DIR}"*
echo -e "==============================="
echo -e "\n Stack Packaging Initiated \n"
echo -e "==============================="
aws cloudformation package \
    --template-file "${TEMPLATE_NAME}" \
    --s3-bucket "${BUCKET_NAME}" \
    --output-template-file "${PACKAGED_OUTPUT_TEMPLATE}"


# Deploy the stack
echo -e "==============================="
echo -e "\n Stack Deployment Initiated \n"
echo -e "==============================="
aws cloudformation deploy \
    --profile "${AWS_PROFILE}" \
    --template-file "${PACKAGED_OUTPUT_TEMPLATE}" \
    --stack-name "${STACK_NAME}" \
    --tags Service="${SERVICE_NAME}" \
    --capabilities CAPABILITY_IAM
