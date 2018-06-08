.PHONY: build

IMAGE_NAME = denibertovic/gitit
LOCAL_USER_ID ?= $(shell id -u $$USER)
USER_NAME ?= "Deni Bertovic"
USER_EMAIL ?= "deni@denibertovic.com"

.DEFAULT_GOAL = help

require-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "ERROR: Environment variable not set: \"$*\""; \
		exit 1; \
	fi


## Build docker image
build:
	@docker build -t ${IMAGE_NAME} .

## Run docker container
run:
	@docker run -it \
		-e LOCAL_USER_ID=${LOCAL_USER_ID} \
		-e USER_NAME=${USER_NAME} \
		-e USER_EMAIL=${USER_EMAIL} \
		-v `pwd`/data:/data \
		-p 5001:5001 \
	${IMAGE_NAME}

## Show help screen.
help:
	@echo "Please use \`make <target>' where <target> is one of\n\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-30s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

