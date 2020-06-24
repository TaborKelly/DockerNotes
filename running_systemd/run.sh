#!/bin/bash -xe

docker rm running_systemd || true
docker run \
    --detach \
    --tmpfs /tmp \
    --tmpfs /run \
    --tmpfs /run/lock \
    --tty \
    --cap-add SYS_PTRACE \
    --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --name running_systemd \
    running_systemd
