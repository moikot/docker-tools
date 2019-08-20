# MUA Docker Tools
![GitHub](https://img.shields.io/github/license/moikot/mua-docker-tools)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/moikot/mua-docker-tools)
![Docker Image Layers](https://images.microbadger.com/badges/image/moikot/mua-docker-tools.svg)
![Docker Image Wersion](https://images.microbadger.com/badges/version/moikot/mua-docker-tools.svg)

A Docker container with a set of Bash scripts for:
1. Building multi-architectural Docker images.
2. Pushing Docker images and manifests to Docker Hub.
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
docker cp $id:/scripts.sh /tmp/mua-scripts.sh
docker rm -v $id
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

This should produce two Docker images with tags:
* moikot/foobar:1.0.0_linux_amd64
* moikot/foobar:1.0.0_linux_arm64_v8

**NOTE:** Additional build arguments are passed directly to `docker build` command.

## Pushing images to Docker Hub

```bash
/tmp/mua-scripts.sh push-images \
  moikot/foobar v1.0.0 \
  linux/amd64,linux/arm64/v8 \
  [docker_hub_user] [docker_hub_password]
```

The following steps will be performed:
1. Images with tags `moikot/foobar:1.0.0_linux_amd64` and `moikot/foobar:1.0.0_linux_arm64_v8` will be pushed to Docker Hub.
2. Multi-architectural manifests `moikot/foobar:1`, `moikot/foobar:1.0`, `moikot/foobar:1.0.0`, and `moikot/foobar:latest` will be created referencing images pushed at step #1.
3. Tags `moikot/foobar:1.0.0_linux_amd64` and `moikot/foobar:1.0.0_linux_arm64_v8` will be derefrenced on Docker Hub.

## Pushing README to Docker Hub

```bash
/tmp/mua-scripts.sh push-readme \
  moikot/foobar README.md \
  [docker_hub_user] [docker_hub_password]
```
