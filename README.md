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
$ ./scripts/copilot-init.sh <env name>
```

### Switch maintenance

1. Add listener rule to show maintenance to ALB that created by aws copilot.

2. Run command to switch maintenacne on/off.
```sh
$ ./scripts/switch-maintenance.sh <env> <on or off>
```

### Cleaning

```sh
$ ./scripts/copilot-delete.rb
```

## Deployment

Running a deployment workflow using [GitHub CLI](https://cli.github.com/).

```sh
$ gh workflow run
? Select a workflow  [Use arrows to move, type to filter]
> Deploy service with AWS Copilot (deploy.yml)
```
