FROM jetbrains/teamcity-agent:2026.2.1-linux-sudo

ADD install_python.sh /tmp/install_python.sh

ENV PATH="/home/buildagent/.local/bin:${PATH}"
ENV DEBIAN_FRONTEND=noninteractive

RUN sudo ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
        sudo apt update -yqq && \
	sudo apt install -yqq libc6-i386 lib32z1 git \
	cmake ninja-build build-essential clang ccache \
	wget curl zip unzip rsync jq gdb valgrind xvfb

RUN bash /tmp/install_python.sh

# Podman replaces Docker-in-Docker, for agent pods without `privileged`, in a user namespace
# (hostUsers: false). `docker` still works (podman-docker).
# Sub-IDs: the pod has only 65536 IDs, so buildagent gets all the others, or images with files owned by
# nobody (65534) fail to unpack.
ADD podman/containers.conf /etc/containers/containers.conf
ADD podman/registries.conf /etc/containers/registries.conf.d/00-docker-hub.conf
RUN sudo apt purge -yqq docker-ce docker-ce-cli docker-ce-rootless-extras docker-buildx-plugin \
        docker-compose-plugin containerd.io && \
    sudo apt install -yqq podman podman-docker uidmap && \
    sudo touch /etc/containers/nodocker && \
    printf 'buildagent:1:999\nbuildagent:1001:64535\n' | sudo tee /etc/subuid /etc/subgid >/dev/null
# TeamCity's Docker steps only run on agents reporting a Docker server; Podman serves them through podman-docker.
ENV AGENT_OPTS="docker.server.version=4.9.3"
