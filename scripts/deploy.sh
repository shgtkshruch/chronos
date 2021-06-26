#!/usr/bin/env bash

set -e -u

# default settings
env="dev"
rails="false"
nuxt="false"
maintenance="false"
branch="main"

usage_exit() {
  echo "Usage: $0 [flags]

    -r, --rails          Deploy Rails
    -n, --nuxt           Deploy Nuxt
    -m, --maintenance    Maintenance mode on
    --branch string      Deploy branch name
    --env string         Deploy environment. dev | staging | production
  " 1>&2
  exit 1
}

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -r|--rails) rails="true" ;;
    -n|--nuxt) nuxt="true" ;;
    -m|--maintenance) maintenance="true" ;;
    -b|--branch) branch="$2"; shift ;;
    --env) env="$2"; shift ;;
    *) usage_exit; exit 1 ;;
  esac
  shift
done

json='{
  "env":"'"$env"'",
  "rails": "'"$rails"'",
  "nuxt": "'"$nuxt"'",
  "maintenance": "'"$maintenance"'"
}'

echo "[Environment]  $env"
echo "[Branch Name]  $branch"
echo "[Deploy Mode]  rails: $rails, nuxt: $nuxt, maintenance: $maintenance"

read -p "Are you sure? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo $json | gh workflow run deploy.yml --ref $branch --json
fi
