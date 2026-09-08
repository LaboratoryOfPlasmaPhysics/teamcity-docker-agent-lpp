FROM jetbrains/teamcity-agent:2026.2-linux-sudo

ADD daemon.json /etc/docker/daemon.json
ADD install_python.sh /tmp/install_python.sh

ENV PATH="/home/buildagent/.local/bin:${PATH}"
ENV DEBIAN_FRONTEND=noninteractive

RUN sudo ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
        sudo apt update -yqq && \
	sudo apt install -yqq libc6-i386 lib32z1 git \
	cmake ninja-build build-essential clang ccache \
	wget curl zip unzip rsync jq gdb valgrind xvfb

RUN bash /tmp/install_python.sh
