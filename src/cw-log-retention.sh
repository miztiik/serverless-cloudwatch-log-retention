#!/bin/bash
set -ex

declare -r retention="30"

for L in $(aws logs describe-log-groups \
    --query 'logGroups[?!not_null(retentionInDays)] | [].logGroupName' \
    --output text)
do
   aws logs  put-retention-policy --log-group-name ${L} \
                                  --retention-in-days ${retention}
done