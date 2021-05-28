#!/usr/bin/env bash

set -e -u

env=$1

echo "(1/5) Create application"
copilot app init chronos

echo "(2/5) Create environment"
copilot env init --name $env --profile default --default-config

echo "(3/5) Set secretes"
copilot secret init --app chronos --name RAILS_MASTER_KEY

echo "(4/5) Create service"
copilot svc init \
  --name rails \
  --svc-type "Load Balanced Web Service" \
  --dockerfile Dockerfile.prod \
  --port 3000

echo "(5/5) Deploy"
copilot svc deploy --name rails --env $env
