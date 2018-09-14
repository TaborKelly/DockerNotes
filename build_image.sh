#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "We expect exactly two arguments:"
    echo "    1. A source image name"
    echo "    2. A name and optionally a tag in the 'name:tag' format"
    echo "ex: ./"
    exit 1
fi

# First, copy some files where Docker can find them
cp ~/.bashrc .
cp -r ~/.ssh .

docker build -t $2 --build-arg USER_NAME=`whoami` --build-arg IMAGE_NAME=$1 .
