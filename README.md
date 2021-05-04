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

### Secrets

Save `RAILS_MASTER_KEY` to AWS Systems Manager Parameter Store (SSM).

ref: https://aws.github.io/copilot-cli/docs/developing/secrets/

```sh
$ aws ssm put-parameter \
  --name /copilot/applications/chronos/components/rails/RAILS_MASTER_KEY \
  --value YOUR_RAILS_MASTER_KEY \
  --type SecureString \
  --tags Key=copilot-environment,Value=test \
         Key=copilot-application,Value=chronos
```

### Infra

```sh
# Create application
$ copilot init

# Create service
$ copilot svc init

# Deploy
$ copilot svc deploy
```

### Cleaning

```sh
$ aws ssm delete-parameter --name /copilot/applications/chronos/components/rails/RAILS_MASTER_KEY
$ copilot app delete
```

## Deployment

Running a deployment workflow using [GitHub CLI](https://cli.github.com/).

```sh
$ gh workflow run
? Select a workflow  [Use arrows to move, type to filter]
> Deploy service with AWS Copilot (deploy.yml)
```
