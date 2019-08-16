SHELL = /bin/bash
IMAGE_NAME?=egghead
IMAGE_TAG?=latest

.PHONY: build run

#
# Docker
#

run:
	docker run -it --rm ${IMAGE_NAME}:${IMAGE_TAG}

build:
	docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

push: build
	docker push ${IMAGE_NAME}:${IMAGE_TAG}
