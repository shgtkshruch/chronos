#!/usr/bin/env bash

set -e -u

identtifier='database-1'

status=$(aws rds describe-db-instances --db-instance-identifier $identtifier | jq -r '.DBInstances[].DBInstanceStatus')

echo "RDS status: $status"

if [ $status = 'available' ]
then
  echo 'Stop RDS'
  aws rds stop-db-instance --db-instance-identifier $identtifier
else
  echo 'Start RDS'
  aws rds start-db-instance --db-instance-identifier $identtifier
fi
