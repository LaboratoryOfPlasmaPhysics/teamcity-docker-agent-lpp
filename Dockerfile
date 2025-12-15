FROM jetbrains/teamcity-agent:2025.11.1-linux-sudo

ADD daemon.json /etc/docker/daemon.json
ADD install_python.sh /tmp/install_python.sh

ENV PATH="/home/buildagent/.local/bin:${PATH}"
ENV DEBIAN_FRONTEND=noninteractive

RUN sudo ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
        sudo apt update -yqq && \
	sudo apt install -yqq libc6-i386 lib32z1 libreadline-dev \
	make build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
        xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git

RUN bash /tmp/install_python.sh

RUN sudo python3.8 -m pip install git+https://github.com/LaboratoryOfPlasmaPhysics/teamcity_rest_client
