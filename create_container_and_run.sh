#!/bin/bash

U=`id -g`
G=`id -u`

if [ $# -ne 3 ]
  then
    echo "We expect exactly three arguments:"
    echo "    1. A source image name"
    echo "    2. A container name"
    echo "    3. A bindmount path for /work"
    exit 1
fi

# Start a detached interactive process
# ./create_container_and_run.sh debian_dev:latest debian_dev_container /work/rpe/docker_work
docker run -dit -u $U:$G --mount type=bind,source=$3,target=/work --name $2 $1 bash
