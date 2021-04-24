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

```sh
# Create application
$ copilot init

# Create service
$ copilot svc init

# Deploy
$ copilot svc deploy
```
