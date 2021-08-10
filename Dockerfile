FROM jetbrains/teamcity-agent:2021.1.2-linux-sudo

ADD daemon.json /etc/docker/daemon.json

RUN sudo apt update -y && sudo apt upgrade -y && \
	sudo apt install -y python3-virtualenv virtualenv python3-coverage python-coverage \
	python3-coverage-test-runner python-unittest2 python3-unittest2 python3-venv python3.8-venv \
	python3.9-venv python3-pip tox && \
        sudo pip3 install --upgrade pip

RUN sudo pip3 install git+https://github.com/LaboratoryOfPlasmaPhysics/teamcity_rest_client
