#!/bin/bash

U=`id -g`
G=`id -u`

if [ $# -ne 4 ]
  then
    echo "We expect exactly three arguments:"
    echo "    1. A source image name"
    echo "    2. A container name"
    echo "    3. A bindmount path for /work"
    echo "    4. A bindmount path for /home/$USER"
    exit 1
fi

# Start a detached interactive process
# ./create_container_and_run.sh debian_dev:latest debian_dev_container /work/rpe/docker_work
docker run --hostname $2 -dit --security-opt seccomp=unconfined -u $U:$G --mount type=bind,source=/opt,target=/opt --mount type=bind,source=$3,target=/work --mount type=bind,source=$4,target=/home/`whoami` --name $2 $1 bash
