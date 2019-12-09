# Docker Hub Tools
[![](https://img.shields.io/github/license/moikot/docker-tools)](https://github.com/moikot/docker-tools/blob/master/Dockerfile "License")
[![](https://img.shields.io/docker/cloud/build/moikot/docker-tools)](https://hub.docker.com/r/moikot/docker-tools/builds "Build")
[![](https://images.microbadger.com/badges/image/moikot/docker-tools.svg)](https://hub.docker.com/r/moikot/docker-tools/tags "Image Tags")
[![](https://images.microbadger.com/badges/commit/moikot/docker-tools.svg)](https://github.com/moikot/docker-tools/blob/master/Dockerfile "Dockerfile")

A tiny Docker image with a set of Bash scripts for:
1. Installing Docker and enabling the experimental mode.
1. Building and tagging multi-platform Docker images.
3. Pushing README file to Docker Hub.

## Getting the script

Create a container and copy the scripts file from it.

```bash
id=$(docker create moikot/docker-tools)
docker cp $id:/scripts.sh /tmp/scripts.sh && docker rm -v $id
```

## Install the latest Docker

```bash
/tmp/scripts.sh update_docker
```

The command updates Docker to the latest version and enables the experimental mode in Docker daemon.

## Build multi-platform Docker images

* **Image name:** moikot/foobar
* **Git tag:** v1.0.0
* **Platforms:** linux/amd64, linux/arm64/v8

```bash
/tmp/scripts.sh build_images
  moikot/foobar v1.0.0 \
  linux/amd64,linux/arm64/v8 \
  [additional build arguments]
```

**NOTE:** Additional build arguments are passed directly to `docker buildx build` command.

## Push README.md to Docker Hub

```bash
/tmp/scripts.sh push_readme \
  moikot/foobar README.md \
  [docker_hub_user] [docker_hub_password]
```
