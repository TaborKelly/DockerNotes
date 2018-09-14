ARG IMAGE_NAME
FROM ${IMAGE_NAME}

ARG USER_NAME

# Install curl
# Create a normal user that matches your $USER_NAME with no password and
# complete sudo privileges
RUN apt-get update && apt-get install -y cmake curl sudo wget && \
    addgroup --gid 1000 $USER_NAME && \
    adduser --uid 1000 --ingroup $USER_NAME --home /home/$USER_NAME --shell /bin/sh --disabled-password --gecos "" $USER_NAME && \
    usermod -aG sudo $USER_NAME && \
    echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Copy your .bashrc and .ssh directory, because we care.
COPY --chown=1000:1000 ./.bashrc /home/$USER_NAME
COPY --chown=1000:1000 ./.ssh /home/$USER_NAME/.ssh

# setup fixuid
RUN USER=$USER_NAME && \
    GROUP=$USER_NAME && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

USER $USER_NAME:$USER_NAME
ENTRYPOINT ["fixuid"]
