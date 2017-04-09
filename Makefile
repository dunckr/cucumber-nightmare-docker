NAME=electron
IMAGE=electron
IP=$(shell ifconfig en0 | grep inet | awk '$$1=="inet" {print $$2}')

all: start

build:
	@docker build \
		--tag "${IMAGE}" \
		.;

create: build
	@if [[ -z `docker ps -a | grep '${NAME}'` ]] ; then \
		docker create \
		--name="${NAME}" \
		--interactive \
		--tty \
		--security-opt seccomp:unconfined \
		--env "DISPLAY=${IP}:0" \
		--volume "/tmp/.X11-unix:/tmp/.X11-unix" \
		--volume "yarn_cache:/root/.cache/yarn" \
		--volume "yarn_config:/root/.config/yarn" \
		--volume "yarn_misc:/root/.yarn" \
		--volume "$(PWD)/:/app" \
		"${IMAGE}"; \
	fi;

start: create
	@if [[ -z `netstat -an | grep 6000` ]]; then \
		open -a XQuartz; \
	fi;
	@xhost "+${IP}";
	@docker start ${NAME};

sh:
	@docker exec -it ${NAME} /bin/bash

stop:
	@docker stop ${NAME}

rm: stop
	@docker rm -v ${NAME}
	@docker rmi -f ${IMAGE}

.PHONY: build create start sh stop rm
