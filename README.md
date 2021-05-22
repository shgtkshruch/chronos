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

### Infra

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
