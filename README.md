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

### Nginx

Build Nginx docker image, and push to ECR.

```sh
./scripts/ecr-nginx.sh
```

### Copilot

Create AWS resources (ex. VPC, ALB, Farge, RDS) with [AWS Copilot](https://aws.github.io/copilot-cli/).

```sh
$ ./scripts/copilot-init.sh <env> <domain>
```

### Switch maintenance

1. Add listener rule to show maintenance to ALB that created by AWS Copilot.

2. Run command to switch maintenacne on/off.
```sh
$ ./scripts/switch-maintenance.sh <env> <on or off>
```

### Cleaning

```sh
$ ./scripts/copilot-delete.sh
```

## Deployment

Running a deployment workflow using [GitHub CLI](https://cli.github.com/).

```sh
$ gh workflow run
? Select a workflow  [Use arrows to move, type to filter]
> Deploy service with AWS Copilot (deploy.yml)
```
