#!/usr/bin/env bash

vpc_id=$(copilot env show --name dev --json | jq '.environmentVPC.id')

elb=$(aws elbv2 describe-load-balancers | jq ".LoadBalancers[] | select(.VpcId == $vpc_id)" | jq -r ".LoadBalancerArn")

lisner=$(aws elbv2 describe-listeners --load-balancer-arn $elb | jq -r '.Listeners[].ListenerArn')

rule_first=$(aws elbv2 describe-rules --listener-arn $lisner | jq -r '.Rules[] |  select(.Priority == "1") | .RuleArn')
rule_second=$(aws elbv2 describe-rules --listener-arn $lisner | jq -r '.Rules[] |  select(.Priority == "50000") | .RuleArn')

rules=$(aws elbv2 set-rule-priorities --rule-priorities '[
  {
    "RuleArn": "'"$rule_first"'",
    "Priority": 50000
  },
  {
    "RuleArn": "'"$rule_second"'",
    "Priority": 1
  }
]')
echo $rules
