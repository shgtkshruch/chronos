#!/usr/bin/env bash

set -e -u

env=$1

FIRST_PRIORITY=1
SECOND_PRIORITY=50000

vpc_id=$(copilot env show --name $env --json | jq '.environmentVPC.id')
elb=$(aws elbv2 describe-load-balancers | jq ".LoadBalancers[] | select(.VpcId == $vpc_id)" | jq -r ".LoadBalancerArn")
listener=$(aws elbv2 describe-listeners --load-balancer-arn $elb | jq -r '.Listeners[].ListenerArn')

rules=$(aws elbv2 describe-rules --listener-arn $listener)
first_rule=$(echo $rules | jq -r '.Rules[] | select(.Priority == "'"$FIRST_PRIORITY"'") | .RuleArn')
second_rule=$(echo $rules | jq -r '.Rules[] | select(.Priority == "'"$SECOND_PRIORITY"'") | .RuleArn')

rules=$(aws elbv2 set-rule-priorities --rule-priorities '[
  {
    "RuleArn": "'"$first_rule"'",
    "Priority": '$SECOND_PRIORITY'
  },
  {
    "RuleArn": "'"$second_rule"'",
    "Priority": '$FIRST_PRIORITY'
  }
]')
echo $rules
