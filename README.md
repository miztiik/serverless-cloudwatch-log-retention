# AWS Serverless CloudWatch Logs Retention Policy Enforcer

This lambda function adds a retention policy to CloudWatch log group[s] that does *not* have an retention policy. You can use the override feature to set new values on existing policies, Say for example you have decided to retain logs longer now, from 14 to 21 days.

#### Prerequisites

- AWS CLI pre-configured
- Log Retention Days: Defaults to 14 days.

# Infrastructure

This [AWS SAM](https://github.com/awslabs/serverless-application-model) project deploys a serverless function comprised of a Lambda that 
is triggered once every 24 hours by a CloudWatch Event to add a retention policly to CloudWatch log groups that do not alreadyt have a policy. 
The included CloudFormation template also creates an IAM role for the Lambda that allows the function to perform required functions. 

## Deployment

1. Clone the repository
  ```sh
  git clone https://github.com/matwerber1/aws-lambda-set-cloudwatch-logs-retention
  ```

2. Within ./deploy.sh, replace YOUR_S3_BUCKET with an existing S3 bucket to use for uploading packaged template to CloudFormation. 
  
  ```sh
  BUCKET_NAME=_YOUR_S3_BUCKET
  ```

3. OPTIONAL - within ./src/index.js, set config.debug to true to have the Lambda function output raw API responses to the function logs. 

4. OPTIONAL - within ./src/index.js, set config.defaultRetentionDays to your desired retention period. 

5. Run deploy.sh

  ```sh
  ./deploy.sh
  ```
  
# Usage

The function will automatically trigger once every 24 hours via a CloudWatch Event. 

Optionally, you can manually invoke the Lambda and include a JSON payload of {overridePolicies: true} to change the retention period for all log groups, regardless of what their current policies are. 

Here is an example of the output from the Lambda function: 

  ```
  ```