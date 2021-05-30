#!/usr/bin/env bash

set -e -u

env=$1
command=$2

echo "maincenance ${command}"

if [ $command = 'on' ]
then
  DEFAULT_PRIORITY=1000
  MAINTENANCE_PRIORITY=1
else
  DEFAULT_PRIORITY=1
  MAINTENANCE_PRIORITY=1000
fi

elb=$(copilot env show --name dev --resources --json | jq -r '.resources[] | select(.type == "AWS::ElasticLoadBalancingV2::LoadBalancer") | .physicalID')
listeners=$(aws elbv2 describe-listeners --load-balancer-arn $elb | jq -r '.Listeners[]' | jq '.')
listener443=$(echo $listeners | jq -r 'select( .Port == 443).ListenerArn')

rules=$(aws elbv2 describe-rules --listener-arn $listener443)

default_rule=$(echo $rules | jq -r '.Rules[] | select(.Conditions[1].Field == "host-header").RuleArn')
maintennce_rule=$(echo $rules | jq -r '.Rules[] | select(.Actions[].Type == "fixed-response").RuleArn')

rules=$(aws elbv2 set-rule-priorities --rule-priorities '[
  {
    "RuleArn": "'"$default_rule"'",
    "Priority": '$DEFAULT_PRIORITY'
  },
  {
    "RuleArn": "'"$maintennce_rule"'",
    "Priority": '$MAINTENANCE_PRIORITY'
  }
]')
echo $rules
