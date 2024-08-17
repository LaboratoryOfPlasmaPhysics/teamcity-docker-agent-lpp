FROM jetbrains/teamcity-agent:2024.07.1-linux-sudo

ADD daemon.json /etc/docker/daemon.json

ENV PATH="/home/buildagent/.local/bin:${PATH}"

RUN sudo add-apt-repository -y ppa:deadsnakes/ppa && sudo apt update -y && \
	sudo apt install -y libc6-i386 lib32z1 python3-virtualenv virtualenv python3-coverage python-coverage \
	python3-coverage-test-runner python-unittest2 python3-unittest2 python3-venv python3.6-venv \
        python3.7-venv python3.8-venv python3.9-venv python3.10-venv python3.11-venv \
        python3.8-dev python3.9-dev python3.10-dev python3.11-dev\
        python3-pip tox && \
        sudo pip3 install --upgrade pip && pip3 install --user pytest

RUN sudo pip3 install git+https://github.com/LaboratoryOfPlasmaPhysics/teamcity_rest_client
