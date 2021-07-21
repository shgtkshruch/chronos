#!/usr/bin/env bash

set -e -u

identifier='copilot-chronos-dev'

status=$(aws rds describe-db-instances --db-instance-identifier $identifier | jq -r '.DBInstances[].DBInstanceStatus')

echo "RDS status: $status"

if [ $status = 'available' ]
then
  echo 'Stop RDS'
  aws rds stop-db-instance --db-instance-identifier $identifier
else
  echo 'Start RDS'
  aws rds start-db-instance --db-instance-identifier $identifier
fi
