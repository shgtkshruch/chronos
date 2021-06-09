#!/usr/bin/env bash

set -e -u

env=$1

echo "(1/3) Fetch RAILSCLUSTER_SECRET"
RAILSCLUSTER_SECRET=$(copilot svc show -n rails --json | jq -r '.secrets[] | select(.name == "RAILSCLUSTER_SECRET").valueFrom')
echo $RAILSCLUSTER_SECRET

manifest_path='./copilot/admin-rails/manifest.yml'
echo "(2/3) Set RAILSCLUSTER_SECRE to $manifest_path"
sed -i -e "s/<RAILSCLUSTER_SECRET>/$RAILSCLUSTER_SECRET/" $manifest_path

echo "(3/3) Deploy admin-rails service"
copilot svc deploy --name admin-rails --env $env
