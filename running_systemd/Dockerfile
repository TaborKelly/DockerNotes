# Running systemd in Docker is tricky. This Dockerfile was inspired by:
# - https://github.com/solita/docker-systemd/blob/master/Dockerfile
# - https://github.com/j8r/dockerfiles/blob/master/systemd/ubuntu/Dockerfile-18.04

FROM ubuntu:bionic

ENV container docker
STOPSIGNAL SIGRTMIN+3

RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y systemd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Don't start any optional services except for the few we need.
RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*journal*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -exec rm \{} \;

RUN systemctl set-default multi-user.target

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]
