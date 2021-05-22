# chronos

## Build

```sh
$ COMPOSE_DOCKER_CLI_BUILD=1 docker-compose build
```

## Dev

```sh
$ docker-compose up -d
```

## AWS

Deploy with [AWS Copilot](https://aws.github.io/copilot-cli/).

### Nginx

Build Nginx container, and push to ECR.

```sh
$ aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.ap-northeast-1.amazonaws.com

$ aws ecr create-repository --repository-name chronos/nginx

$ docker build -f nginx/Dockerfile -t aws_account_id.dkr.ecr.ap-northeast-1.amazonaws.com/chronos/nginx nginx

$ docker push aws_account_id.dkr.ecr.ap-northeast-1.amazonaws.com/chronos/nginx
```

### Rails

```sh
# Create application
$ copilot app init chronos

# Create environment
$ copilot env init --name dev --profile default --default-config

# Set secretes
$ copilot secret init --app chronos --name RAILS_MASTER_KEY

# Create service
$ copilot svc init --name rails --svc-type "Load Balanced Web Service" --dockerfile Dockerfile.prod --port 3000

# Deploy
$ copilot svc deploy --name rails --env dev
```

### Cleaning

```sh
$ aws ssm delete-parameter --name /copilot/chronos/dev/secrets/RAILS_MASTER_KEY
$ copilot app delete
```

## Deployment

Running a deployment workflow using [GitHub CLI](https://cli.github.com/).

```sh
$ gh workflow run
? Select a workflow  [Use arrows to move, type to filter]
> Deploy service with AWS Copilot (deploy.yml)
```
