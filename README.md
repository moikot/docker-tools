# Docker Hub Tools
![GitHub](https://img.shields.io/github/license/moikot/docker-tools)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/moikot/docker-tools)
![Docker Image Layers](https://images.microbadger.com/badges/image/moikot/docker-tools.svg)
![Docker Image Version](https://images.microbadger.com/badges/version/moikot/docker-tools.svg)

A Docker container with a set of Bash scripts for:
1. Building and tagging Docker images.
3. Pushing README file to Docker Hub.

## Requirements

* Docker version >= 18.09 for BuildKit support.
* Docker experimental mode enabled on daemon.

**NOTE:**
To enable docker BuildKit by default, set daemon configuration in `/etc/docker/daemon.json` feature to true and restart the daemon:

```bash
echo '{"experimental":true,"features":{"buildkit":true}}'
    | sudo tee /etc/docker/daemon.json
sudo service docker restart    
```

## Getting the script

Create a container and copy the scripts file from it.

```bash
id=$(docker create moikot/mua-docker-tools)
docker cp $id:/scripts.sh /tmp/mua-scripts.sh && docker rm -v $id
```

## Building multi-architectural Docker images

* **Image name:** moikot/foobar
* **Git tag:** v1.0.0
* **Platforms:** linux/amd64, linux/arm64/v8

```bash
/tmp/mua-scripts.sh build_images
  moikot/foobar v1.0.0 \
  linux/amd64,linux/arm64/v8 \
  [additional build arguments]
```

**NOTE:** Additional build arguments are passed directly to `docker buildx build` command.

## Pushing README to Docker Hub

```bash
/tmp/mua-scripts.sh push-readme \
  moikot/foobar README.md \
  [docker_hub_user] [docker_hub_password]
```
