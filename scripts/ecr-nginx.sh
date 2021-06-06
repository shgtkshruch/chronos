#!/usr/bin/env bash

set -e -u

aws_account_id=353381651656
ecr_endpoint=$aws_account_id.dkr.ecr.ap-northeast-1.amazonaws.com
app_name=chronos
repo_name=$app_name/nginx
tag_name=$ecr_endpoint/$repo_name

echo "(1/4) Login ECR"
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin $ecr_endpoint

echo "(2/4) Create ECR repository if it's not exist"
ecr_repository=$(aws ecr describe-repositories | jq '.repositories[] | select(.repositoryName == "'"$repo_name"'").repositoryArn')

if [ -z $ecr_repository ]
then
  echo "Create ECR repository $repo_name"
  aws ecr create-repository --repository-name $repo_name
else
  echo "Already exist ECR repository: $repo_name"
fi

echo "(3/4) Build Nginx docker image"
docker build -f nginx/Dockerfile -t $tag_name ./nginx

echo "(4/4) Push Nginx docker image to ECR"
docker push $tag_name
