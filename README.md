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

### Shared EFS

To share EFS between services, fetch EFS configuration from copilot commands bellow.

```sh
$ FS_ID=$(copilot env show -n dev --json --resources | jq -r '.resources[] | select(.type | contains("EFS::FileSystem")) | .physicalID')
$ FS_AP=$(copilot svc show -n rails --json --resources | jq -r '.resources.dev[] | select(.type | contains("EFS::AccessPoint")) | .physicalID')
```

And set these values to `storage` section.

```yml
storage:
  volumes:
    sharedEFS:
      efs:
        id: $FS_ID
        auth:
          access_point_id: $FS_AP
          iam: true
      path: /app/public/maintenance
      read_only: false
```

### Switch maintenance

```sh
# turn on maintenance mode
$ copilot svc exec --app chronos --command 'bin/maintenance on'

# turn off maintenance mode
$ copilot svc exec --app chronos --command 'bin/maintenance off'
```

### Cleaning

```sh
$ ./scripts/copilot-delete.sh
```

## Deployment

Running a deployment workflow using [GitHub CLI](https://cli.github.com/).

```sh
./scripts/deploy.sh -h
Usage: ./scripts/deploy.sh [flags]

    -r, --rails          Deploy Rails
    -n, --nuxt           Deploy Nuxt
    -m, --maintenance    Maintenance mode on
    --branch string      Deploy branch name
    --env string         Deploy environment. dev | staging | production
```
