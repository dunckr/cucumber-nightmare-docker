NAME=cucumber
IMAGE=nightmare

if [[ -z `'${uname}' == 'Darwin'` ]]; then \
	IP=$(shell ifconfig en0 | grep inet | awk '$$1=="inet" {print $$2}'); \
else; \
	IP=$(shell fconfig eth0 | grep 'inet addr' | cut -d ':' -f 2 | cut -d ' ' -f 1); \
fi;

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
	@xhost "+${IP}" &>/dev/null;
	@docker start ${NAME};

sh: start
	@docker exec -it ${NAME} /bin/bash;

test: start
	@docker exec ${NAME} /bin/bash -c "yarn test";

stop:
	@docker stop ${NAME};

rm: stop
	@docker rm -v ${NAME};
	@docker rmi -f ${IMAGE};

.PHONY: build create start sh test stop rm
