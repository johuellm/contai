#!/bin/sh
set -eu

docker build \
	-t contai:latest \
	--build-arg UID=$(id -u) \
	--build-arg USERNAME=$(id -un) \
	--build-arg GID=$(id -g) \
	--build-arg GROUPNAME=$(id -gn) \
	- < Dockerfile
