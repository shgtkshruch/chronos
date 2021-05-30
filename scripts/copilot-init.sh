#!/usr/bin/env bash

set -e -u

env=$1
domain=$2

app_name=chronos

echo "(1/5) Create application"
copilot app init $app_name --domain $domain

echo "(2/5) Create environment"
copilot env init --name $env --profile default --default-config

echo "(3/5) Set secretes"
copilot secret init --app $app_name --name RAILS_MASTER_KEY

echo "(4/5) Create service"
copilot svc init \
  --name rails \
  --svc-type "Load Balanced Web Service" \
  --dockerfile Dockerfile.prod \
  --port 3000

echo "(6/7) Create job"
copilot job init \
  --app $app_name \
  --image test \
  --name slack-notification \
  --schedule "cron(0/5 * * * ? *)"

echo "(7/7) Execute deploy job in GitHub Actons"
gh workflow run --ref main
