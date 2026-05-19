#!/bin/bash
set -x

if [ $# -ne 2 ]
  then
    echo "We expect exactly two arguments:"
    echo "    1. A source image name"
    echo "    2. A name and optionally a tag in the 'name:tag' format"
    echo "ex: ./"
    exit 1
fi

docker build -t $2 -f Dockerfile.simple-real-home \
    --build-arg GID=`id -g` \
    --build-arg UID=`id -u` \
    --build-arg USER_NAME=`whoami` \
    --build-arg IMAGE_NAME=$1 .
