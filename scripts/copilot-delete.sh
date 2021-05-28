#!/usr/bin/env bash

set -e -u

echo "(1/2) Delete secret parameter"
aws ssm delete-parameter --name /copilot/chronos/dev/secrets/RAILS_MASTER_KEY

echo "(2/2) Delete copilot application"
copilot app delete
